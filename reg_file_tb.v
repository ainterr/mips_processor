// ------------------------------------------------------------------------- //
// reg_file_tb.v
//
// This is the testbench for our register file (implemented in reg_file.v).
//
// Alex Interrante-Grant
// 10/08/2015
// ------------------------------------------------------------------------- //

`timescale 1ns/10ps

module reg_file_tb();
	reg rst, clk, wr_en, rd_en;
	reg [1:0] rd0_addr, rd1_addr, wr_addr;	
	reg signed [8:0] wr_data;
 	wire signed [8:0] rd0_data, rd1_data;

	reg_file uut(
		.rst(rst),
		.clk(clk),
		.wr_en(wr_en),
		.rd_en(rd_en),
		.rd0_addr(rd0_addr),
		.rd1_addr(rd1_addr),
		.wr_addr(wr_addr),
		.wr_data(wr_data),
		.rd0_data(rd0_data),
		.rd1_data(rd1_data));

	// Clock signal
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end
	// Reset cycle
	initial begin
		rst = 1;
		#6 rst = 0;
	end
	// Test Vectors
	initial begin
		// Wait for initialization
		#15;
		// Write some data to a register
		#10 wr_en = 1; wr_addr = 0; wr_data = 9'b101010101;
		#10 wr_en = 0; wr_addr = 0; wr_data = 0;
		// Read the data from the same register and from a register
		// that should now contain zero (after the initial clear)
		#10 rd_en = 1; rd0_addr = 0; rd1_addr = 1;
		#10 rd_en = 0; rd0_addr = 0; rd1_addr = 0;
		// Try reading and writing to the same register. Note: reading
		// should happen first
		#10 rd_en = 1; wr_en = 1; rd0_addr = 0; 
		wr_addr = 0; wr_data = 0;
		#10 rd_en = 0; wr_en = 0;
		// Read the data again (should be zero now)
		#10 rd_en = 1;
		#10 rd_en = 0;
		// Give it a few extra cycles...
		#20

		$finish;
	end
	// Monitor
	initial begin
		$monitor("time=%d, clk=%b, rd_en=%b, wr_en=%b, rd0_addr=%d, rd1_addr=%d, wr_addr=%d, rd0_data=%d, rd1_data=%d, wr_data=%d", $time, clk, rd_en, wr_en, rd0_addr, rd1_addr, wr_addr, rd0_data, rd1_data, wr_data);
	end

endmodule
