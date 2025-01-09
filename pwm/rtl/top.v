module pwm_generator(
	input wire clk,
	input wire rst_n,
	input wire [7:0] duty,
	input wire rst_counter,
	output reg pwm
);

reg [7:0] count;

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		count <= 8'b00000000;
		pwm <= 0;
	end else if (!rst_counter) begin
		count <= 0;
	end else begin
		count <= count + 1'b1;
		pwm <= (count < duty) ? 1'b1 : 1'b0;
	end
end
endmodule

