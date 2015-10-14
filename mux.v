// ------------------------------------------------------------------------- //
// mux.v
//
// This module is a nine bit multiplexor that outputs eight bits depending on
// the single bit select.
//
// Alex Interrante-Grant
// 10/08/2015
// ------------------------------------------------------------------------- //

`timescale 1ns/10ps

module mux(a, b, sel, f);
	input [8:0] a, b;
	input sel;
	output reg [7:0] f;

	always@(a, b, sel) begin
		case(sel)
			0: f = a[7:0];
			1: f = b[7:0];
			default: f = 0;
		endcase
	end
endmodule
