class memory_driver;
	virtual memory_interface intf;
	mailbox exp_mb; 
	packet exp_pkt;
	function new(string name, virtual memory_interface intf);
		this.intf = intf;
		$display ("%s is created", name);
	endfunction 

	task reset();
		$display ("[%0t] Reset task called", $time);
		repeat(2)@(negedge intf.clk);
		intf.reset 		<= 1'b1;
		intf.addr		<= 8'h0;
		intf.data_in	<= 8'h0;
		intf.activate	<= 1'b0;
		intf.wr_rd_enb	<= 1'b0;
		intf.valid		<= 1'b0;
		@(negedge intf.clk);
		intf.reset		<= 1'b0;
		repeat(2)@(negedge intf.clk);
		$display ("[%0t] Reset task called", $time);
	endtask 


	task write(logic [7:0] addr, logic [7:0] data);
		$display ("[%0t] wrtie task called", $time);
		@(negedge intf.clk);
		intf.addr		<= 8'h0;
		intf.data_in	<= 8'h0;
		intf.activate	<= 1'b1;
		intf.wr_rd_enb	<= 1'b0;
		intf.valid		<= 1'b0;
		@(negedge intf.clk);
		intf.addr		<= addr;
		intf.data_in	<= data;
		intf.activate	<= 1'b0;
		intf.wr_rd_enb	<= 1'b0;
		intf.valid		<= 1'b1;
		@(negedge intf.clk);
		intf.activate	<= 1'b1;
		@(negedge intf.clk);
		intf.valid		<= 1'b0;
		intf.activate	<= 1'b0;
		exp_pkt = new();
		exp_pkt.data = intf.data_in;
		exp_pkt.addr = intf.addr;
		exp_mb.put(exp_pkt);
		$display (" [%0t] WRITE at DRV with value of %0d and addr of %0d", $time, intf.data_in, intf.addr);

	endtask 


	task read(logic [7:0] addr);
		$display ("[%0t] Read task called", $time);
		@(negedge intf.clk);
		//intf.addr		<= 8'd0;
		intf.activate	<= 1'b1;
		intf.wr_rd_enb	<= 1'b0;
		intf.valid		<= 1'b0;
		@(negedge intf.clk);
		intf.addr		<= addr;
		intf.activate	<= 1'b0;
		intf.wr_rd_enb	<= 1'b1;
		intf.valid		<= 1'b1;
		@(negedge intf.clk);
		intf.activate	<= 1'b1;
		@(negedge intf.clk);
		intf.valid		<= 1'b0;
		intf.activate	<= 1'b0;
		@(negedge intf.clk);

	endtask 

endclass  