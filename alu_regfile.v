// ------------------------------------------------------------------------- //
// alu_regfile.v
//
// This module connects our ALU (in eightbit_alu.v) to our register file (in
// reg_file.v) including a couple of muxes (in mux.v) for additional 
// control.
//
// Alex Interrante-Grant
// 10/08/2015
// ------------------------------------------------------------------------- //

`timescale 1ns/10ps

module alu_regfile(rst, clk, rd0_addr, rd1_addr, wr_addr, wr_data, reg_write,
	reg_read, instr_i, alu_src0, alu_src1, alu_op, result, input0, input1,
	ovf, zero);

	input rst, clk;
	input [1:0] rd0_addr, rd1_addr, wr_addr;
	input signed [8:0] wr_data;
	input reg_write, reg_read, alu_src0, alu_src1;
	input signed [8:0] instr_i;
	input [2:0] alu_op;

	output signed [7:0] input0, input1, result;
	output ovf, zero;

	wire [8:0] rd0_data, rd1_data;
	wire [7:0] alu_input0, alu_input1;

        reg_file registers(
                .rst(rst),
                .clk(clk),
                .wr_en(reg_write),
                .rd_en(reg_read),
                .rd0_addr(rd0_addr),
                .rd1_addr(rd1_addr),
                .wr_addr(wr_addr),
                .wr_data(wr_data),
                .rd0_data(rd0_data),
                .rd1_data(rd1_data));

	mux alu_mux0(
		.a(rd0_data),
		.b(9'b0),
		.sel(alu_src0),
		.f(alu_input0)),
	    alu_mux1(
		.a(rd1_data),
		.b(instr_i),
		.sel(alu_src1),
		.f(alu_input1));

	eightbit_alu alu(
		.a(alu_input0),
		.b(alu_input1),
		.sel(alu_op),
		.f(result),
		.ovf(ovf),
		.zero(zero));

	assign input0 = alu_input0;
	assign input1 = alu_input1;
endmodule
