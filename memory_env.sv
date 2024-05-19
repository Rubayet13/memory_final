class memory_env;
	memory_agent agent;
	memory_scoreboard scb;

	function new(string name, virtual memory_interface intf);
		agent = new("agent", intf);
		scb   = new("scoreboard", intf);
		$display ("%s is created", name);
		
		agent.drv.exp_mb = new();
		agent.mon.act_mb = new();

		scb.exp_mb = agent.drv.exp_mb; 
		scb.act_mb = agent.mon.act_mb;
	
	endfunction 


endclass  
