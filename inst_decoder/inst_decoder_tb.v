// ------------------------------------------------------------------------- //
// inst_decoder_tb.v
//
// This module is a testbench for our instruction decoder.
//
// Alex Interrante-Grant
// James Massucco
// 10/29/2016
// ------------------------------------------------------------------------- //

module inst_decoder_tb();
        reg [15:0] instruction;
        wire [3:0] opcode; // Maybe not used...
        wire [1:0] rs_addr;
        wire [1:0] rt_addr;
        wire [1:0] rd_addr;
        wire [7:0] immediate;
        wire RegDst;
        wire RegWrite;
        wire ALUSrc1;
        wire ALUSrc2;
        wire [2:0] ALUOp;
        wire MemWrite;
        wire MemToReg;

	inst_decoder uut(
		.instruction(instruction),
		.opcode(opcode),
		.rs_addr(rs_addr),
		.rt_addr(rt_addr),
		.rd_addr(rd_addr),
		.immediate(immediate),
		.RegDst(RegDst),
		.RegWrite(RegWrite),
		.ALUSrc1(ALUSrc1),
		.ALUSrc2(ALUSrc2),
		.ALUOp(ALUOp),
		.MemWrite(MemWrite),
		.MemToReg(MemToReg)
	);

	reg [3:0] temp;

	initial begin
		instruction = 0; temp = 0;
		repeat(16) begin
			#10 instruction = {temp, {12{1'b0}}};
			temp = temp + 1;
		end
	end

	initial begin
		$display("opcode, rs_addr, rt_addr, rd_addr, immediate, RegDst, RegWrite, ALUSrc1, ALUSrc2, ALUOp, MemWrite, MemToReg");
		//	    opcode    rs          rt       rd      imm       RegDST   RegWr     Src1    Src2     ALUOp     MemWr   MemTR 
		$monitor("%b, %b, %b, %b, %d, %b, %b, %b, %b, %d, %b, %b", opcode, rs_addr, rt_addr, rd_addr, immediate, RegDst, RegWrite, ALUSrc1, ALUSrc2, ALUOp, MemWrite, MemToReg);
	end
endmodule
