`timescale 1ns/1ps
module test_bench;
	reg clk;
	reg rst_n;
	reg [7:0] duty;
	reg rst_counter;
	wire pwm;

	pwm_generator dut(
		.clk(clk),
		.rst_n(rst_n),
		.duty(duty),
		.rst_counter(rst_counter),
		.pwm(pwm)
	);

	task verify;
		input exp_pwm;
		begin
			$display("At time: %t, rst_n = 1'b%b, duty = 8'h%h", $time, rst_n, duty);
			if(exp_pwm == pwm) begin		
				$display("-------------------------------------------------------------------------------");
				$display("PASSED: Expected PWM: 1'b%b, Got PWM: 1'b%b", exp_pwm, pwm);
				$display("-------------------------------------------------------------------------------");
			end else begin
				$display("-------------------------------------------------------------------------------");
				$display("FAILED: Expected PWM: 1'b%b, Got PWM: 1'b%b", exp_pwm, pwm);
				$display("-------------------------------------------------------------------------------");
			end
		end
	endtask
	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end

	initial begin
		$dumpfile("test_bench.vcd");
		$dumpvars(0, test_bench);

		$display("-------------------------------------------------------------------------------");
		$display("---------------------------- TESTBENCH FOR PWM GENERATOR ----------------------");
		$display("-------------------------------------------------------------------------------");

		rst_n = 0;
		duty = 8'h0;
		rst_counter = 0;
		@(posedge clk);
		verify(0);

		rst_n = 1;
		rst_counter = 1;
		duty = 8'h0;
		@(posedge clk);
		verify(0);

		// the duty value equal 10 percent
		duty = 8'h1a;
		repeat (25) @(posedge clk);
		verify(1);
		
		repeat (2) @ (posedge clk);
		verify(0);	
		
		// the duty value equal 20 percent
		rst_counter = 0;
		duty = 8'h33;
		@(posedge clk);
		rst_counter = 1;
		repeat (49) @(posedge clk);
		verify(1);
		
		repeat (7) @ (posedge clk);
		verify(0);	
		
		// the duty value equal 30 percent
		rst_counter = 0;
		duty = 8'h4c;
		@(posedge clk);
		rst_counter = 1;
		repeat (76) @(posedge clk);
		verify(1);
		
		repeat (7) @ (posedge clk);
		verify(0);	
		
		// the duty value equal 40 percent
		rst_counter = 0;
		duty = 8'h66;
		@(posedge clk);
		rst_counter = 1;
		repeat (101) @(posedge clk);
		verify(1);
		
		repeat (7) @ (posedge clk);
		verify(0);	
		
		// the duty value equal 50 percent
		rst_counter = 0;
		duty = 8'h80;
		@(posedge clk);
		rst_counter = 1;
		repeat (127) @(posedge clk);
		verify(1);
		
		repeat (7) @ (posedge clk);
		verify(0);	
		
		// the duty value equal 75  percent
		rst_counter = 0;
		duty = 8'hc0;
		@(posedge clk);
		rst_counter = 1;
		repeat (191) @(posedge clk);
		verify(1);
		
		repeat (7) @ (posedge clk);
		verify(0);	

		#100;
		$finish;

	end
endmodule

