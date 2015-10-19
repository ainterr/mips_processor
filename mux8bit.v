// ------------------------------------------------------------------------- //
// mux8bit.v
//
// This module represents an 8 bit multiplexor.
//
// Alex Interrante-Grant
// James Massucco
// 10/08/2015
// ------------------------------------------------------------------------- //

`timescale 1ns/10ps

module mux8bit(a, b, sel, f);
	input [7:0] a, b;
	input sel;
	output reg [7:0] f;

	always@(a, b, sel) begin
		case(sel)
			0: f = a;
			1: f = b;
			default: f = 0;
		endcase
	end
endmodule
