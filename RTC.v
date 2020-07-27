module RTC (input clk, rst, 
	    output reg [3:0] s0, m0, s1, m1, h0, h1);  //Declaring all output variables as 4-bit since sevensegdisplay input = 4 bits

parameter max1 = 9, max2 = 5, max3 = 3, max4 = 2;     //since max hour = 23:59:59

wire [6:0] SEC0, SEC1, MIN0, MIN1, HOUR0, HOUR1;   //Seven segment displays declaration for each variable

sevenseg sec0(s0, SEC0);            //Initializing seven segment display for each of the terms
sevenseg sec1(s1, SEC1);
sevenseg min0(m0, MIN0);            // OUR SSD IS [HOUR1 HOUR0 : MIN1 MIN0 : SEC1 SEC0]
sevenseg min1(m1, MIN1);
sevenseg hour0(h0, HOUR0);          //OUR OUTPUT IS [h1 h0 : m1 m0 : s1 s0]
sevenseg hour1(h1, HOUR1);

always@(posedge clk )
   begin
     if(rst == 1)   //if clock is reset, it should start over. Active HIGH reset.
       begin
	h1 <= 0;
	h0 <= 0;
	m1 <= 0;
	m0 <= 0;
        s1 <= 0;
	s0 <= 0;
       end
     else 
        begin  
        if(s0 == max1)                           // If s0 = 9, initialize s0 = 0
          begin 
             s0 <= 4'b0;
           	if(s1 == max2)                   // If s1 = 5 && s0 = 9, set s1 = 0 and m0 = m0 + 1 
	      	   begin
		     s1 <= 4'b0;        
			if(m0 == max1)           // If m0 = 9, initialize m0 = 9
			   begin 
			     m0 <= 4'b0;
 			     if (m1 == max2)    
				begin 
				   m1 <= 4'b0;
				   if(h0 == max1 && h1 < max4)    //If h0 = 9 && h1 < 2, then h0 = 0 and h1 = h1 + 1
					begin
    					  h0 <= 4'b0;        
					  h1 <= h1 + 1;
					end
			           else if (h0 < max3 && h1 == max4) //If h0 < 3 && h1 == 2, then h0 = h0 + 1
					 h0 <= h0 + 1;
	    			   else if (h0 == max3 && h1 == max4) //If h0 = 3 && h1 = 2, then reset the clock
		   			    begin 
						h1 <= 0;
						h0 <= 0;
						m1 <= 0;
						m0 <= 0;
        					s1 <= 0;
						s0 <= 0;  
					    end 
				    else  
					h0 <= h0 + 1;                 
				   end
			     else 
				m1 <= m1 + 1;
                            end
			  else 
			      m0 = m0 + 1;
                      end
		 else
		    s1 <= s1 + 1;
           end
         else 
         s0 = s0 + 1;
        end 
   end
endmodule


module sevenseg(input [3:0] B, output reg [6:0] L);

always@(B)
  begin
    case(B)
	4'b0000: L = 7'b1011111;
	4'b0001: L = 7'b0000011;
	4'b0010: L = 7'b1110110;
	4'b0011: L = 7'b1110011;
	4'b0100: L = 7'b0101011;
	4'b0101: L = 7'b1111001;
	4'b0110: L = 7'b1111101;
	4'b0111: L = 7'b1000011;
	4'b1000: L = 7'b1111111;
	4'b1001: L = 7'b1101011;
        default: L = 7'b1111111;
     endcase
   end
endmodule


module RTC_tb();

  reg clk, rst;
  wire [3:0] s0, m0, s1, m1, h0, h1;
  wire [6:0] SEC0, SEC1, MIN0, MIN1, HOUR0, HOUR1; 
  sevenseg sec0(s0, SEC0);            //Initializing seven segment display for each of the terms
  sevenseg sec1(s1, SEC1);
  sevenseg min0(m0, MIN0);            // OUR SSD IS [HOUR1 HOUR0 : MIN1 MIN0 : SEC1 SEC0]
  sevenseg min1(m1, MIN1);
  sevenseg hour0(h0, HOUR0);          //OUR OUTPUT IS [h1 h0 : m1 m0 : s1 s0]
  sevenseg hour1(h1, HOUR1);

  RTC first(clk, rst,  s0, m0, s1, m1, h0, h1);

  initial 
  begin
    clk = 0; 
    forever #1 clk = ~clk;
  end

  initial 
  begin 
     rst = 1;
     #10 rst = 0;
     #100000;
  end

endmodule
  

            










