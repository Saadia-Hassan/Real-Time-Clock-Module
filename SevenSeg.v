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
