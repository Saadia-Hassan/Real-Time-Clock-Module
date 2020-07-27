module counter(input clk, en, rst, output reg [3:0] count);

always@(posedge clk)
  begin
    if (rst == 0)
      count = 4'b0;
    else if (en)
       begin 
        if(count == 4'd15) 
           count = 4'b0;
        else 
         count = count + 1;
       end
    else 
       count = count;
   end
endmodule

module counter_tb();

reg clk, en, rst;
wire [3:0] count;

counter C1(clk, en, rst, count);

initial 
begin
clk = 0;
forever #5 clk = ~clk;
end

initial
begin
rst = 0;
en = 0;

#10 en = 1;
rst = 1;

#90;

end

endmodule 
    
