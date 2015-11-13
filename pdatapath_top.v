// ------------------------------------------------------------------------- //
// pdatapath_top.v
//
// This is our top module. This module connects all individual elements to form
// a complete MIPS datapath.
//
// Alex Interrante-Grant
// James Massucco
// 11/13/2015
// ------------------------------------------------------------------------- //

`timescale 1ns / 1ps

module pdatapath_top(
		input wire clk,
		input wire top_pb_clk,
        input wire right_pb_rst_general  
    );
    
    wire [7:0] alu_1st_input, alu_2nd_input;
    wire [7:0] alu_output;
    wire [2:0] ALUOp;
    wire       alu_ovf_flag;
    wire       alu_zero_output;
    
    wire [15:0] instruction;
    //insturction fields
    wire [3:0] opcode;
    wire [1:0] rs_addr;
    wire [1:0] rt_addr;
    wire [1:0] rd_addr;
    wire [7:0] immediate;
    //control signals
    wire RegDst;
    wire RegWrite;
    wire ALUSrc1;
    wire ALUSrc2;
    wire MemWrite;
    wire MemToReg;

    wire [1:0] regfile_write_address;//destination register address
    wire [8:0] regfile_write_data;//result data
    wire [8:0] read_data1;//source register1 data
    wire [8:0] read_data2;//source register2 data

    wire [8:0] alu_result;
    wire [8:0] zero_register;
    wire [8:0] data_mem_out;

    wire pb_clk_debounced;
    
    wire [7:0] pc;

    debounce debounce_clk(
        .clk_in(clk),
        .rst_in(right_pb_rst_general),
        .sig_in(top_pb_clk),
        .sig_debounced_out(pb_clk_debounced)
    );
    
    inst_decoder instruction_decoder (
        .instruction(instruction),
        .opcode(opcode),
        .rs_addr(rs_addr),
        .rt_addr(rt_addr),
        .rd_addr(rd_addr),
        .immediate(immediate),
        .RegDst(RegDst),
        .RegWrite(RegWrite),
        .ALUSrc1(ALUSrc1),
        .ALUSrc2(ALUSrc2),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg)
    ); 
        
    //Select the right signal for the ALU's first input
    assign alu_1st_input = ALUSrc1 ? zero_register[7:0] : read_data1[7:0];
    //Select the right signal for the ALU's second input
    assign alu_2nd_input = ALUSrc2 ? immediate[7:0] : read_data2[7:0];
    
    assign zero_register = 8'b0;//ZERO constant          
     
    //ALU      
    eightbit_alu alu (
        .a(alu_1st_input),
        .b(alu_2nd_input),
        .sel(ALUOp),
        .f(alu_output),
        .ovf(alu_ovf_flag),
        .zero(alu_zero_output)
	);
	
	//VIO Module
	vio_0 vio_core (
      .clk(clk),                // input wire clk
      .probe_in0(alu_output),    // input wire [7 : 0] probe_in0
      .probe_in1(alu_ovf_flag),    // input wire [0 : 0] probe_in1
      .probe_in2(alu_zero_output),    // input wire [0 : 0] probe_in2
      .probe_in3(read_data1),    // input wire [7 : 0] probe_in3
      .probe_in4(read_data2),    // input wire [7 : 0] probe_in4
      .probe_in5(alu_1st_input),    // input wire [7 : 0] probe_in5
      .probe_in6(alu_2nd_input),    // input wire [7 : 0] probe_in6
      .probe_in7(read_data2),    // input wire [8 : 0] probe_in7
      .probe_in8(data_mem_out),    // input wire [8 : 0] probe_in8
      .probe_in9(opcode),    // input wire [2 : 0] probe_in9
      .probe_in10(rs_addr),  // input wire [1 : 0] probe_in10
      .probe_in11(rt_addr),  // input wire [1 : 0] probe_in11
      .probe_in12(rd_addr),  // input wire [1 : 0] probe_in12
      .probe_in13(immediate),  // input wire [7 : 0] probe_in13
      .probe_in14(RegDst),  // input wire [0 : 0] probe_in14
      .probe_in15(RegWrite),  // input wire [0 : 0] probe_in15
      .probe_in16(ALUSrc1),  // input wire [0 : 0] probe_in16
      .probe_in17(ALUSrc2),  // input wire [0 : 0] probe_in17
      .probe_in18(ALUOp),  // input wire [0 : 0] probe_in18
      .probe_in19(MemWrite),  // input wire [0 : 0] probe_in19
      .probe_in20(MemToReg),  // input wire [0 : 0] probe_in20
      .probe_in21(pc),  // input wire [7 : 0] probe_in21
      .probe_in22(instruction)  // input wire [15 : 0] probe_in22
    );

	assign alu_result = {alu_ovf_flag, alu_output};
	
	//Select the right signal for the register file write data
    assign regfile_write_data = MemToReg ? data_mem_out : alu_result;
    
    //Select the right signal for the register file write address
    assign regfile_write_address = RegDst ? rd_addr : rt_addr;
           
	reg_file register_file (
        .rst(right_pb_rst_general),//reset
        .clk(pb_clk_debounced),//clock
        .wr_en(RegWrite),//Write enable
        .rd0_addr(rs_addr),//source register1 address
        .rd1_addr(rt_addr),//source register2 address
        .wr_addr(regfile_write_address),//destination register address
        .wr_data(regfile_write_data),//result data
        .rd0_data(read_data1),//source register1 data
        .rd1_data(read_data2)//source register2 data
    );
    
    data_memory_take2 data_memory (
      .a(alu_output),      // input wire [7 : 0] a
      .d(read_data2),      // input wire [8 : 0] d
      .clk(pb_clk_debounced),  // input wire clk
      .we(MemWrite),    // input wire we
      .spo(data_mem_out)  // output wire [8 : 0] spo
    );

    program_counter program_counter(
        .clk(pb_clk_debounced),
        .rst(right_pb_rst_general),
	.branch_offs(immediate),
	.ALU_zero(alu_zero_output),
        .value(pc)
    );
    
    instr_memory inst_memory (
      .clka(pb_clk_debounced),    // input wire clka
      .rsta(right_pb_rst_general),    // input wire rsta
      .addra(pc),  // input wire [7 : 0] addra
      .douta(instruction) );    //ire [15 : 0] douta

endmodule
