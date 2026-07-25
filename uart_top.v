module uart_top (
    input rst,
    input [7:0] data_in,
    input wr_enb,
    input clk, input rdy_clr,
    output rdy ,output busy,
    output [7:0] data_out
);

wire rx_clk_enb;
wire tx_clk_enb;
wire tx_temp;

baudrategen bg (
    .clk(clk),
    .rst(rst),
    .tx_clk_enb(tx_clk_enb),
    .rx_clk_enb(rx_clk_enb)
);

transmitter ut (
    .clk(clk),
    .rst(rst),
    .wr_enb(wr_enb),
    .enb(tx_clk_enb),
    .data_in(data_in),
    .tx(tx_temp),
    .busy(busy)
);

uart_receive ur (
    .clk(clk),
    .rst(rst),
    .rx(tx_temp),
    .rdy_clr(rdy_clr),
    .enb(rx_clk_enb),
    .rdy(rdy),
    .data_out(data_out)
);

endmodule
