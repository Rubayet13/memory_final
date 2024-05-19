class memory_test; 
	memory_env env;
	function new(string name, virtual memory_interface intf);
		env = new("environment", intf);
		$display ("%s is created", name);
	endfunction 
	

	task bulk_reset ();
		repeat(15)begin 
		env.agent.drv.reset();
		end
	endtask 


	task bulk_write ();
		env.agent.drv.reset();
		for (int i = 0; i <= 2**8-1; i++) begin 	 	
			env.agent.drv.write(i, $random);
		end 
	endtask 


	task bulk_read ();
		env.agent.drv.reset();
		for (int i = 0; i <= 2**8-1; i++) begin 		
			env.agent.drv.read(i);
		end 
	endtask 

	task bulk_write_read ();
		env.agent.drv.reset();
		for (int i = 0; i <= 2**8-1; i++) begin 	 	
			env.agent.drv.write(i,$random);
			env.agent.drv.read(i);
		end 
	endtask 

	task unbounded_write ();
		env.agent.drv.reset();
		begin 	
			env.agent.drv.write(2**8, $random);
			env.agent.drv.write(2**8-1, $random);
			env.agent.drv.write(2**8+1, $random);
		end 
	endtask 

	task unbounded_read ();
		env.agent.drv.reset();
		begin 	
			env.agent.drv.read(2**8);
			env.agent.drv.read(2**8-1);
			env.agent.drv.read(2**8+1);
		end 
	endtask 



endclass  
