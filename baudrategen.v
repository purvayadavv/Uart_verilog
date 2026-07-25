module baudrategen (
    input clk,
    input rst,
    output tx_clk_enb,
    output rx_clk_enb
);

reg [12:0] tx_counter = 0;
reg [9:0] rx_counter = 0;

always @(posedge clk) begin
    if (rst)
        tx_counter <= 0;
    else if (tx_counter == 5208)
        tx_counter <= 0;
    else
        tx_counter <= tx_counter + 1'b1;
end

always @(posedge clk) begin
    if (rst)
        rx_counter <= 0;
    else if (rx_counter == 325)
        rx_counter <= 0;
    else
        rx_counter <= rx_counter + 1'b1;
end

assign tx_clk_enb = (tx_counter == 5208) ? 1'b1 : 1'b0;
assign rx_clk_enb = (rx_counter == 325) ? 1'b1 : 1'b0;

endmodule
