// ------------------------------------------------------------------------- //
// inst_decoder.v
//
// This module decodes instructions to control dataflow of our processor.
//
// Alex Interrante-Grant
// James Massucco
// 10/29/2016
// ------------------------------------------------------------------------- //

module inst_decoder(
	input [15:0] instruction,
	output reg [3:0] opcode, // Maybe not used...
	output reg [1:0] rs_addr,
	output reg [1:0] rt_addr,
	output reg [1:0] rd_addr,
	output reg [7:0] immediate,
	output reg RegDst,
	output reg RegWrite,
	output reg ALUSrc1,
	output reg ALUSrc2,
	output reg [2:0] ALUOp,
	output reg MemWrite,
	output reg MemToReg
);

	always @(instruction) begin
		opcode = instruction[15:12];
		rs_addr = instruction[11:10];
        rt_addr = instruction[9:8];
        rd_addr = instruction[7:6];
        immediate = instruction[7:0];
        
		case (instruction[15:12])
			0:
			begin
				RegDst = 0;
				RegWrite = 1;
				ALUSrc1 = 0;
				ALUSrc2 = 1;
				ALUOp = 0;
				MemWrite = 0;
				MemToReg = 1;
			end
			1:
			begin
				RegDst = 0;
				RegWrite = 0;
				ALUSrc1 = 0; //changed
				ALUSrc2 = 1;
				ALUOp = 0;
				MemWrite = 1;
				MemToReg = 0;
			end
			2:
			begin
				RegDst = 1; //changed
				RegWrite = 1;
				ALUSrc1 = 0;
				ALUSrc2 = 0;
				ALUOp = 0;
				MemWrite = 0;
				MemToReg = 0;
			end
			3:
			begin
				RegDst = 0;
				RegWrite = 1;
				ALUSrc1 = 0;
				ALUSrc2 = 1;
				ALUOp = 0;
				MemWrite = 0;
				MemToReg = 0;
			end
			4:
			begin
				RegDst = 1; //changed
				RegWrite = 1;
				ALUSrc1 = 0;
				ALUSrc2 = 0;
				ALUOp = 1;
				MemWrite = 0;
				MemToReg = 0;
			end
			5:
			begin
				RegDst = 1; //changed
				RegWrite = 1;
				ALUSrc1 = 0;
				ALUSrc2 = 0;
				ALUOp = 2;
				MemWrite = 0;
				MemToReg = 0;
			end
			6:
			begin
				RegDst = 0;
				RegWrite = 1;
				ALUSrc1 = 0;
				ALUSrc2 = 1; //changed
				ALUOp = 2;
				MemWrite = 0;
				MemToReg = 0;
			end
			7:
			begin
				RegDst = 1; //changed
				RegWrite = 1;
				ALUSrc1 = 0;
				ALUSrc2 = 0;
				ALUOp = 3;
				MemWrite = 0;
				MemToReg = 0;
			end
			8:
			begin
				RegDst = 0;
				RegWrite = 1;
				ALUSrc1 = 0;
				ALUSrc2 = 0;
				ALUOp = 3;
				MemWrite = 0;
				MemToReg = 0;
			end
			9:
			begin
				RegDst = 0;
				RegWrite = 1;
				ALUSrc1 = 0;
				ALUSrc2 = 1;
				ALUOp = 4;
				MemWrite = 0;
				MemToReg = 0;
			end
			10:
			begin
				RegDst = 0;
				RegWrite = 1;
				ALUSrc1 = 0;
				ALUSrc2 = 1;
				ALUOp = 5;
				MemWrite = 0;
				MemToReg = 0;
			end
			11:
			begin
				RegDst = 0;
				RegWrite = 0;
				ALUSrc1 = 0;
				ALUSrc2 = 0;
				ALUOp = 6;
				MemWrite = 0;
				MemToReg = 0;
			end
			12:
			begin
				RegDst = 0;
				RegWrite = 0;
				ALUSrc1 = 0;
				ALUSrc2 = 0;
				ALUOp = 7;
				MemWrite = 0;
				MemToReg = 0;
			end
			13:
			begin
				RegDst = 1; //changed
				RegWrite = 1;
				ALUSrc1 = 1;
				ALUSrc2 = 0;
				ALUOp = 2;
				MemWrite = 0;
				MemToReg = 0;
			end
			default
			begin
				RegDst = 0;
				RegWrite = 0;
				ALUSrc1 = 0;
				ALUSrc2 = 0;
				ALUOp = 0;
				MemWrite = 0;
				MemToReg = 0;
			end
		endcase
	end
endmodule
