class memory_monitor;
	virtual memory_interface intf;
	mailbox act_mb;
	packet act_pkt;
	function new(string name, virtual memory_interface intf);
		this.intf = intf;
		$display ("%s is created", name);

		fork 
			write_capture(); 
			read_capture();
		join_none 
	endfunction 

	task write_capture ();
		forever begin 
			@(negedge intf.clk);
				if(intf.activate && intf.valid && !intf.wr_rd_enb && !intf.reset) begin 
					$display ("[%0t] Captured WRITE at MON DATA :: %0d ADDR :: %0d", $time, intf.data_in, intf.addr);
				end 
	
		end

	endtask 


	task read_capture ();
		forever begin 
			@(negedge intf.clk);
				if(intf.activate && intf.valid && intf.wr_rd_enb && !intf.reset) begin 
					$display ("[%0t] Captured READ at MON DATA :: %0d ADDR :: %0d", $time, intf.data_out, intf.addr);
					act_pkt = new();
					act_pkt.data = intf.data_out;
					act_pkt.addr = intf.addr;
					act_mb.put(act_pkt);
					$display ("packeting done");
				end
		end 

	endtask 

endclass  
