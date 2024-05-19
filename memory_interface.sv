interface memory_interface (input wire clk); 
	logic reset;
	logic [7:0] addr;
   	logic [7:0] data_in;
   	logic valid;
   	logic activate;
   	logic wr_rd_enb;
   	logic error;
   	logic [7:0] data_out;
endinterface 

