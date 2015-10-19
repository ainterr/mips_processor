// ------------------------------------------------------------------------- //
// mux9bit.v
//
// This module represents a 9 bit multiplexor.
//
// Alex Interrante-Grant
// James Massucco
// 10/08/2015
// ------------------------------------------------------------------------- //

`timescale 1ns/10ps

module mux9bit(a, b, sel, f);
	input [8:0] a, b;
	input sel;
	output reg [8:0] f;

	always@(a, b, sel) begin
		case(sel)
			0: f = a;
			1: f = b;
			default: f = 0;
		endcase
	end
endmodule
