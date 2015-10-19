// ------------------------------------------------------------------------- //
// pdatapath_top.v
//
// This is our top module. This module connects all individual elements to form
// a complete MIPS datapath.
//
// Alex Interrante-Grant
// James Massucco
// 10/19/2015
// ------------------------------------------------------------------------- //

`timescale 1ns / 1ps

module pdatapath_top(
		input wire clk,
		input wire rst_general
		);

wire [7:0] alu_1st_input, alu_2nd_input, alu_2nd_input_vio;
wire [7:0] alu_output;
wire [2:0] ALUOp;
wire       alu_ovf_flag;
wire       alu_zero_output;

wire RegWrite;//Write enable
wire RegRead;//Read enable
wire [1:0] regfile_read_address1;//source register1 address
wire [1:0] regfile_read_address2;//source register2 address
wire [1:0] regfile_write_address;//destination register address
wire [8:0] regfile_write_data;//result data
wire [8:0] read_data1;//source register1 data
wire [8:0] read_data2;//source register2 data

wire ALUSrc1, ALUSrc2;
wire [8:0] alu_result;
wire [8:0] zero_register;

wire MemtoReg;
wire MemWrite;
wire MemEN;

wire [8:0] data_mem_out;

//Instantiate the ALU
eightbit_alu alu(
		.a(alu_1st_input),
		.b(alu_2nd_input),
		.sel(ALUOp),
		.f(alu_output),
		.ovf(alu_ovf_flag),
		.zero(alu_zero_output));

//Instantiate the Register File
reg_file registers(
		.rst(rst_general),
		.clk(clk),
		.wr_en(RegWrite),
		.rd_en(RegRead),
		.rd0_addr(regfile_read_address1),
		.rd1_addr(regfile_read_address2),
		.wr_addr(regfile_write_address),
		.wr_data(regfile_write_data),
		.rd0_data(read_data1),
		.rd1_data(read_data2));

//Instantiate Data Path Routing Elements
mux8bit alu_mux0( //Mux that routes ReadData1 or $zero
		.a(read_data1[7:0]),
		.b(8'b0),
		.sel(ALUSrc1),
		.f(alu_1st_input)),
	alu_mux1( //Mux that routes ReadData2 or alu_2nd_input_vio
		.a(read_data2[7:0]),
		.b(alu_2nd_input_vio),
		.sel(ALUSrc2),
		.f(alu_2nd_input));

mux9bit mem_mux(
		.a({alu_ovf_flag, alu_output}),
		.b(data_mem_out),
		.sel(MemtoReg),
		.f(regfile_write_data));

//Instantiate the VIO core here
//Find the instantiate template from Sources Pane, IP sources -> Instantiation Template -> vio_0.veo (double click to open the file)
vio_0 vio(
		.clk(clk),                  // input wire clk
		.probe_in0(regfile_write_data),      // input wire [8 : 0] probe_in1
		.probe_in1(read_data1),      // input wire [7 : 0] probe_in2
		.probe_in2(read_data2),      // input wire [7 : 0] probe_in3
		.probe_in3(alu_1st_input),      // input wire [7 : 0] probe_in4
		.probe_in4(alu_2nd_input),      // input wire [7 : 0] probe_in5
		.probe_in5(alu_zero_output),      // input wire [0 : 0] probe_in6
		.probe_in6(alu_ovf_flag),      // input wire [0 : 0] probe_in7
		.probe_in7(alu_output),      // input wire [7 : 0] probe_in8
		.probe_in8(data_mem_out),      // input wire [8 : 0] probe_in9
		.probe_out0(RegWrite),    // output wire [0 : 0] probe_out0
		.probe_out1(RegRead),    // output wire [0 : 0] probe_out1
		.probe_out2(alu_2nd_input_vio),    // output wire [7 : 0] probe_out2
		.probe_out3(ALUSrc1),    // output wire [0 : 0] probe_out3
		.probe_out4(ALUSrc2),    // output wire [0 : 0] probe_out4
		.probe_out5(ALUOp),    // output wire [2 : 0] probe_out5
		.probe_out6(MemWrite),    // output wire [0 : 0] probe_out6
		.probe_out7(MemEN),    // output wire [0 : 0] probe_out7
		.probe_out8(MemtoReg),    // output wire [0 : 0] probe_out8
		.probe_out9(regfile_read_address1),    // output wire [1 : 0] probe_out9
		.probe_out10(regfile_read_address2),  // output wire [1 : 0] probe_out10
		.probe_out11(regfile_write_address));  // output wire [1 : 0] probe_out11

//Instantiate the Data Memory
data_memory mem(
		.clka(clk),    // input wire clka
		.rsta(rst_general),    // input wire rsta
		.ena(MemEN),      // input wire ena
		.wea(MemWrite),      // input wire [0 : 0] wea
		.addra(alu_output),  // input wire [7 : 0] addra
		.dina(read_data2),    // input wire [8 : 0] dina
		.douta(data_mem_out));  // output wire [8 : 0] douta

endmodule
