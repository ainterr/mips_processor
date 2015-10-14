// -------------------------------------------------------------------------- //
// alu_regfile_tb.v
//
// This module tests the combination of our register file with our eight bit 
// ALU using two muxes.
//
// Alex Interrante-Grant
// 10/08/2015
// -------------------------------------------------------------------------- //

`timescale 1ns/10ps

module alu_regfile_tb();
	reg rst, clk;
        reg [1:0] rd0_addr, rd1_addr, wr_addr;
        reg signed [8:0] wr_data;
        reg reg_write, reg_read, alu_src0, alu_src1;
        reg signed [8:0] instr_i;
        reg [2:0] alu_op;
        wire signed [7:0] input0, input1, result;
        wire ovf, zero;	

	alu_regfile uut(
		.rst(rst),
		.clk(clk),
		.rd0_addr(rd0_addr),
		.rd1_addr(rd1_addr),
		.wr_addr(wr_addr),
		.wr_data(wr_data),
		.reg_write(reg_write),
		.reg_read(reg_read),
		.alu_src0(alu_src0),
		.alu_src1(alu_src1),
		.instr_i(instr_i),
		.alu_op(alu_op),
		.input0(input0),
		.input1(input1),
		.result(result),
		.ovf(ovf),
		.zero(zero));

	// Clock
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end
	// Initial Reset
	initial begin
		rst = 1;
		#6 rst = 0;
	end
	// Test Vectors
	initial begin
		// Initialize our values
		rd0_addr = 0; rd1_addr = 0; wr_addr = 0;
		wr_data = 0; instr_i = 0;
		reg_read = 0; reg_write = 0; alu_src0 = 0; alu_src1 = 0;
		alu_op = 0;
		// Allow some time for the initial reset
		#15;
		// Set the values of some registers
		#10 reg_write = 1; wr_addr = 0; wr_data = 9'b111111111;
		#10 wr_addr = 1; wr_data = 9'b101010101;
		#10 wr_addr = 2; wr_data = 9'b010101010;
		#10 wr_addr = 3; wr_data = 9'b001111111;
		#10 reg_write = 0;

		// AND registers 1 and 2 (this should give us zero)
		#10 reg_read = 1; rd0_addr = 1; rd1_addr = 2;
		alu_op = 3'b010;
		
		// Now OR them (this should give us all 1's)
		#10 alu_op = 3'b011;

		// Add 127 and 85 (generating some overflow)
		#10 alu_op = 3'b000; rd1_addr = 3;

		// Test a branch operation (check if a register is equal to its self)
		#10 alu_op = 3'b110; rd1_addr = 1;

		// Test an immediate add to a zero input
		#10 alu_op = 3'b000; instr_i = 9'b000001111;
		alu_src0 = 1; alu_src1 = 1;

		#20 // Let it run for a few more cycles

		$finish;
	end
	// Monitor
	initial begin
		$monitor("time=%d, rd0_addr=%d, rd1_addr=%d, wr_addr=%d, wr_data=%d, reg_write=%b, reg_read=%b, alu_src0=%b, alu_src1=%b, instr_i=%d, alu_op=%d, input0=%d, input1=%d, result=%d, ovf=%b, zero=%b",$time, rd0_addr, rd1_addr, wr_addr, wr_data, reg_write, reg_read, alu_src0, alu_src1, instr_i, alu_op, input0, input1, result, ovf, zero);
	end
endmodule
