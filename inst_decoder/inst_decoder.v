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
		case (instruction[15:12])
			0:
			begin
				rs_addr = instruction[11:10];
				rt_addr = instruction[9:8];
				rd_addr = 0;
				immediate = instruction[7:0];
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
				rs_addr = instruction[11:10];
				rt_addr = instruction[9:8];
				rd_addr = 0;
				immediate = instruction[7:0];
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
				rs_addr = instruction[11:10];
				rt_addr = instruction[9:8];
				rd_addr = instruction[7:6];
				immediate = 0;
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
				rs_addr = instruction[11:10];
				rt_addr = 0;
				rd_addr = instruction[9:8];
				immediate = instruction[7:0];
				RegDst = 1;
				RegWrite = 1;
				ALUSrc1 = 0;
				ALUSrc2 = 1;
				ALUOp = 0;
				MemWrite = 0;
				MemToReg = 0;
			end
			4:
			begin
				rs_addr = instruction[11:10];
				rt_addr = instruction[9:8];
				rd_addr = instruction[7:6];
				immediate = 0;
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
				rs_addr = instruction[11:10];
				rt_addr = instruction[9:8];
				rd_addr = instruction[7:6];
				immediate = 0;
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
				rs_addr = instruction[11:10];
				rt_addr = 0;
				rd_addr = instruction[9:8];
				immediate = instruction[7:0];
				RegDst = 1;
				RegWrite = 1;
				ALUSrc1 = 0;
				ALUSrc2 = 1; //changed
				ALUOp = 2;
				MemWrite = 0;
				MemToReg = 0;
			end
			7:
			begin
				rs_addr = instruction[11:10];
				rt_addr = instruction[9:8];
				rd_addr = instruction[7:6];
				immediate = 0;
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
				rs_addr = instruction[11:10];
				rt_addr = 0;
				rd_addr = instruction[9:8];
				immediate = instruction[7:0];
				RegDst = 1;
				RegWrite = 1;
				ALUSrc1 = 0;
				ALUSrc2 = 1;
				ALUOp = 3;
				MemWrite = 0;
				MemToReg = 0;
			end
			9:
			begin
				rs_addr = instruction[11:10];
				rt_addr = 0;
				rd_addr = instruction[9:8];
				immediate = instruction[7:0];
				RegDst = 1;
				RegWrite = 1;
				ALUSrc1 = 0;
				ALUSrc2 = 1;
				ALUOp = 4;
				MemWrite = 0;
				MemToReg = 0;
			end
			10:
			begin
				rs_addr = instruction[11:10];
				rt_addr = 0;
				rd_addr = instruction[9:8];
				immediate = instruction[7:0];
				RegDst = 1;
				RegWrite = 1;
				ALUSrc1 = 0;
				ALUSrc2 = 1;
				ALUOp = 5;
				MemWrite = 0;
				MemToReg = 0;
			end
			11:
			begin
				rs_addr = instruction[11:10];
				rt_addr = instruction[9:8];
				rd_addr = 0;
				immediate = instruction[7:0];
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
				rs_addr = instruction[11:10];
				rt_addr = instruction[9:8];
				rd_addr = 0;
				immediate = instruction[7:0];
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
				rs_addr = instruction[11:10];
				rt_addr = instruction[9:8];
				rd_addr = instruction[7:6];
				immediate = 0;
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
				rs_addr = 0;
				rt_addr = 0;
				rd_addr = 0;
				immediate = 0;
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
