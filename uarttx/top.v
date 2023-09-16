module top (
    input  clk,
    input  reset_n,
    output tx
);
  wire clk_48mhz;
  SB_HFOSC SB_HFOSC_inst (
      .CLKHFEN(1),
      .CLKHFPU(1),
      .CLKHF  (clk_48mhz)
  );

  simple_uart_tx simple_uart_tx0 (
      reset_n,
      clk_48mhz,
      tx
  );




endmodule
