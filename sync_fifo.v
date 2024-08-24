/Synchronous fifo design
module sync_fifo(clk, rst, data_in, data_out, wr_en, rd_en, empty, full);
input rst, clk, wr_en, rd_en;
input [3:0] data_in;
output reg [3:0] data_out;                           
output empty, full;
reg [4:0] wr_ptr, rd_ptr;
reg [3:0] buf_mem [15:0];


always@(posedge clk or posedge rst)  //data input output logic
begin
    if(rst)
        data_out<=0;
    
    else 
        begin
        if(!empty&&rd_en) data_out <= buf_mem[rd_ptr];
        else                  data_out <= data_out;

        if(!full&&wr_en) buf_mem[wr_ptr]<=data_in;
        else                 buf_mem[wr_ptr]<=buf_mem[wr_ptr];
        end
end

always@(posedge clk or posedge rst)  // pointer logic
begin
    if(rst) 
        begin
        wr_ptr<=0;
        rd_ptr<=0;
        end
    
    else
        begin
        if(!full&&wr_en)  wr_ptr<=wr_ptr+1;
        else                  wr_ptr<=wr_ptr;
        if(!empty&&rd_en) rd_ptr<=rd_ptr+1;
        else                  rd_ptr<=rd_ptr;
        end
   end
   
 assign empty = (wr_ptr==rd_ptr);                      //full and empty logic
 assign full = ({~wr_ptr[4], wr_ptr[3:0]}==rd_ptr);
   
endmodule