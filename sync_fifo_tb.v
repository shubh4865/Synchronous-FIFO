module sync_fifo_tb();

reg [3:0] data_in;
reg clk, rst, wr_en, rd_en;
wire [3:0] data_out;
wire empty, full;
integer i;

sync_fifo u1(clk, rst, data_in, data_out, wr_en, rd_en, empty, full);

initial 
begin
clk=1'b1;
forever #5 clk=~clk;
end

initial
begin
#5 rst=1'b1; wr_en=1'b0; rd_en=1'b0;
#10 rst=1'b0; 
for(i=0; i<17; i=i+1)
    begin
    #10 wr_en=1'b1; data_in=i;
    end
#5 wr_en=1'b0; rd_en=1'b1;
#500 $finish;
end    
endmodule