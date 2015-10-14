// ------------------------------------------------------------------------- //
// eightbit_alu.v
//
// This module takes in two eight bit inputs and a three bit select input,
// producting an eight bit output, an overflow flag, and a zero value. The
// select bit determines which operation is preformed on the two inputs
// producing the output and overflow flag. "Selectable" operations are as
// follows:
// 
// sel[2:0]   f       ovf       zero
//   000     a+b   overflow      0
//   001     ~b        0         0
//   010     a&b       0         0
//   011     a|b       0         0
//   100     a<<<1     0         0
//   101     a>>>1     0         0
//   110     a==b      0   branch result
//   111     a!=b      0   branch result
//
// Alex Interrante-Grant
// James Massucco
// 09/30/2015
// ------------------------------------------------------------------------- //

`timescale 1ns/10ps

module eightbit_alu(a, b, sel, f, ovf, zero);
	input signed [7:0] a, b;
	input [2:0] sel;
	output reg signed [7:0] f;
	output reg ovf;
	output reg zero;

	always@(a, b, sel) begin
		zero = 0;
		ovf = 0;
		f = 0;

		case(sel)
			3'b000: begin // f = a + b
				f = a + b;
				ovf = ~(a[7] ^ b[7]) & (a[7] ^ f[7]);
			end
			3'b001: begin // f = ~b
				f = ~b;
			end
			3'b010: begin // f = a & b
				f = a & b;
			end
			3'b011: begin // f = a | b
				f = a | b;
			end
			3'b100: begin // f = a >>> 1
				f = a >>> 1;
			end
			3'b101: begin // f = a <<< 1
				f = a <<< 1;
			end
			3'b110: begin // zero = a == b
				zero = a == b;
			end
			3'b111: begin // zero = a != b
				zero = a != b;
			end
			
		endcase
	end
endmodule
