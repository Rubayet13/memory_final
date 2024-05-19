`timescale 1ns/1ns 
`include "memory_package.sv"

module memory_tb_top;
	bit clk=0; 

	initial forever begin 
		#2 clk =~ clk;
	end 

	memory_interface intf(clk);

	memory_rtl DUT (
		.clk(clk),
		.reset(intf.reset),
   		.addr(intf.addr),
	    .data_in(intf.data_in),
	    .valid(intf.valid),
		.activate(intf.activate),
		.wr_rd_enb(intf.wr_rd_enb),
		.error(intf.error),
		.data_out(intf.data_out)
	);
	

	memory_test test;

	initial begin 
		test = new("test", intf);
		$display("all components are created");
		
		//test.bulk_reset();
		//test.bulk_write();
		//test.bulk_read();
		test.bulk_write_read();
		//test.unbounded_write();
		//test.unbounded_read();
		//test.bulk_reset();
		//test.bulk_reset();

		$finish();
	end 

endmodule 
