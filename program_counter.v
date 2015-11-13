// -------------------------------------------------------------------------- //
// program_counter.v
//
// This is a program counter.
// 
// Alex Interrante-Grant
// James Massucco
// 11/06/2015
// -------------------------------------------------------------------------- //

`timescale 1ns / 1ps

module program_counter(
    input clk,
    input rst,
    output reg [7:0] value
    );
    
    always@(posedge clk, posedge rst) begin
        if(rst) value = 0;
        else if (clk) value = value + 1;
    end
endmodule
