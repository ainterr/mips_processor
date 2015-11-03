// ------------------------------------------------------------------------- //
// reg_file.v
//
// This module represents a register file of four, nine-bit registers. It is
// intended to be used with our ALU as our processor's register file.
//
// Alex Interrante-Grant
// James Massucco
// 10/08/2015
// ------------------------------------------------------------------------- //

`timescale 1ns/10ps

module reg_file(rst, clk, wr_en, rd0_addr, rd1_addr, wr_addr, wr_data,
	rd0_data, rd1_data);
	
	input rst, clk, wr_en;
	input [1:0] rd0_addr, rd1_addr, wr_addr;
	input signed [8:0] wr_data;
	output signed [8:0] rd0_data, rd1_data;

	integer i;
	reg signed [8:0] registers [3:0];
	
	
	assign rd0_data = registers[rd0_addr];
	assign rd1_data = registers[rd1_addr];

	always@(posedge clk, posedge rst) begin
		if(rst) for(i = 0; i < 4; i=i+1) registers[i] = 0;
		// We only want to do this on a positive clock edge, we don't
		// want it to be triggered by an async reset accidentally
		
		else if(wr_en) registers[wr_addr] = wr_data;
	end
endmodule
