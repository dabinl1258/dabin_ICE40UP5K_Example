module simple_uart_tx (
    input      reset_n,
    input      clk,
    output reg tx
);

  parameter idle = 4'b0000;
  parameter start = 4'b0001;
  parameter d0 = 4'b0010;
  parameter d1 = 4'b0011;
  parameter d2 = 4'b0100;
  parameter d3 = 4'b0101;
  parameter d4 = 4'b0110;
  parameter d5 = 4'b0111;
  parameter d6 = 4'b1000;
  parameter d7 = 4'b1001;
  parameter stop = 4'b1010;
  parameter stop_1 = 4'b1011;

  reg [3:0] current_state;
  reg [3:0] next_state;
  reg [8:0] count;


  always @(posedge clk, negedge reset_n) begin
    if (~reset_n) begin
      current_state <= idle;
      count         <= 9'd0;
    end else if (count >= 9'd416) begin
      count         <= 9'd0;
      current_state <= next_state;
    end else count <= count + 1;
  end
  always @(*)
    case (current_state)
      idle: next_state = start;

      start:   next_state = d0;
      d0:      next_state = d1;
      d1:      next_state = d2;
      d2:      next_state = d3;
      d3:      next_state = d4;
      d4:      next_state = d5;
      d5:      next_state = d6;
      d6:      next_state = d7;
      d7:      next_state = stop;
      stop:    next_state = stop_1;
      stop_1:  next_state = idle;
      default: next_state = idle;


    endcase


  always @(*)
    case (current_state)
      idle:    tx = 1'b1;
      start:   tx = 1'b0;
      d0:      tx = 1'b1;
      d1:      tx = 1'b1;
      d2:      tx = 1'b0;
      d3:      tx = 1'b1;
      d4:      tx = 1'b0;
      d5:      tx = 1'b0;
      d6:      tx = 1'b1;
      d7:      tx = 1'b0;
      stop:    tx = 1'b1;
      stop_1:  tx = 1'b1;
      default: tx = 1'b1;
    endcase

endmodule
