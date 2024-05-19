class memory_scoreboard;
	
	mailbox exp_mb;
	mailbox act_mb;

	packet exp_pkt;
	packet act_pkt;

	packet exp_pkt_c;
	packet act_pkt_c;
	
	typedef logic [7:0] addr; 
	
	packet exp_array [addr];

	function new(string name, virtual memory_interface intf);
		act_mb = new();
		$display ("%s is created", name);
		
		fork 
			get_exp_pkt(); 
			get_act_pkt();
		join_none 
		
	endfunction 


	task get_exp_pkt (); 
		begin
			forever begin 
				exp_mb.get(exp_pkt);
				$display ("[%0t] Expected DATA at SCB DATA :: %0d ADDR :: %0d", $time, exp_pkt.data, exp_pkt.addr);
				exp_array[exp_pkt.addr] = exp_pkt;
	
			end
		end
	endtask 



	task get_act_pkt(); 
		begin 
			forever begin 
				act_mb.get(act_pkt);
				$display ("[%0t] Actual DATA at SCB DATA :: %0d ADDR :: %0d", $time, act_pkt.data, act_pkt.addr);
				compare (act_pkt);
			end 
		end 
	endtask 

	task compare (packet act_pkt_c); 
		begin 
			if (exp_array.exists(act_pkt_c.addr))begin 
				$display ("exists");
				exp_pkt_c = exp_array[act_pkt_c.addr];
					if (exp_pkt_c.data === act_pkt_c.data && exp_pkt_c.addr === act_pkt_c.addr) begin 
						$display ("[%0t] PASS TEST! With Value of DATA :: %0d ADDR :: %0d", $time, act_pkt_c.data, act_pkt_c.addr);
					end
			end
			else begin 
				$display ("[%0t] FAILED TEST! With Value of DATA :: %0d ADDR :: %0d", $time, act_pkt_c.data, act_pkt_c.addr);
			end
		end 
	endtask 


endclass  