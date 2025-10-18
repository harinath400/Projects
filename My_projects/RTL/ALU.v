module alu(
	input signed [7:0] a,b,
	input [3:0] opcode,
	input alu_en,
	output signed [15:0]result,
	output reg overflow,zero,parity  // status flags
);

reg signed [15:0]out;
integer i;
reg [3:0]count;

parameter ADD = 4'h0,
	  SUB = 4'h1,
	  MUL = 4'h2,
	  DIV = 4'h3,
	  AND = 4'h4,
	  OR = 4'h5,
	  NAND = 4'h6,
	  NOR = 4'h7,
	  NOT = 4'h8,
	  SR = 4'h9,
     SL = 4'hA,
     INC = 4'hB,
     DEC = 4'hC,
	  XOR = 4'hD,
     XNOR = 4'hE;

always@(*)
begin
	case(opcode)
		ADD : out = a + b; // addition
		SUB : out = a - b; // subtraction
		MUL : out = a * b; // multiplication
		DIV : out = b?(a / b):16'd0; // division
		AND : out = a & b; // bistwise AND
	   OR  : out = a | b; // bitwise OR
		NAND: out = ~(a & b); // bitwise NAND
		NOR : out = ~(a | b); // bitwise NOR
		NOT : out = ~a; // bitwise NOT
	   SR  : out = a >> 1; // Logical right shift
	   SL  : out = a << 1; // Logical left shift 
	   INC : out = a + 1'b1; // increment by 1
	   DEC : out = a - 1'b1; // decrement by 1
		XOR : out = (a ^ b); // bitwise Exclusive-OR
		XNOR: out = ~(a ^ b); // bitwise Exclusive-NOR
	   default : out = 16'd0;
	 endcase
 end

assign result = (alu_en)?out:16'd0;

always@(*)
begin
     if (result==16'd0) 
	  begin
	  zero = 1'b1;
	  end
	  else zero = 1'b0;
     for (i=0;i<16;i=i+1)
     begin
	     if (result[i]==1)
		     count = count + 1'b1;
     end
     if(count%2==0)
	     parity = 1'b1;
	  else 
	     parity = 1'b0;
     case(opcode)
	     ADD: overflow = (a[7]&&b[7]&&~result[7]) || (~a[7]&&~b[7]&&result[7]);
	     SUB: overflow = (a[7]&&~b[7]&&result[7]) || (~a[7]&&b[7]&&~result[7]);
     endcase
end
endmodule


