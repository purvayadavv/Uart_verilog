module uart_top_tb;

reg clk, rst;
reg wr_enb;
reg [7:0] data_in;
reg rdy_clr;
wire rdy, busy;
wire [7:0] dout;

uart_top dut (
    .rst(rst),
    .data_in(data_in),
    .wr_enb(wr_enb),
    .clk(clk),
    .rdy_clr(rdy_clr),
    .rdy(rdy),
    .busy(busy),
    .data_out(dout)
);

initial begin
    clk     = 0;
    rst     = 0;
    data_in = 0;
    rdy_clr = 0;
    wr_enb  = 0;
end

always #5 clk = ~clk;

task send_byte(input [7:0] din);
    begin
        @(negedge clk);
        data_in = din;
        wr_enb  = 1'b1;
        @(negedge clk);
        wr_enb  = 1'b0;
    end
endtask

task clr_rdy;
    begin
        @(negedge clk);
        rdy_clr = 1'b1;
        @(negedge clk);
        rdy_clr = 1'b0;
    end
endtask

initial begin
    send_byte(8'h41);
    wait (!busy);
    wait (rdy);
    $display("received data is %h", dout);
    clr_rdy;

    send_byte(8'h55);
    wait (!busy);
    wait (rdy);
    $display("received data is %h", dout);
    clr_rdy;

    #500 $finish;
end

endmodule
