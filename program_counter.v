// -------------------------------------------------------------------------- //
// program_counter.v
//
// This is a program counter.
// 
// Alex Interrante-Grant
// James Massucco
// 11/13/2015
// -------------------------------------------------------------------------- //

`timescale 1ns / 1ps

module program_counter(
    input clk,
    input rst,
    signed input[7:0] branch_offs,
    input ALU_zero,
    output reg [7:0] value
    );
    
    always@(posedge clk, posedge rst) begin
        if(rst) value = 0;
        else if (clk)
	begin
		if (ALU_zero)
			value = value + branch_offs; //This needs to be a signed addition...
		else
			value = value + 1;
	end
    end
endmodule
