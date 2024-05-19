class memory_agent;

	memory_driver drv;
	memory_monitor mon; 

	function new(string name, virtual memory_interface intf);
		drv = new("driver", intf);
		mon = new("monitor", intf);
		$display ("%s is created", name);
	endfunction 


endclass  