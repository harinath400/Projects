module alu_tb();
reg signed [7:0]a,b;
reg [3:0]opcode;
reg alu_en;
wire signed [15:0]result;
wire overflow,zero,parity;

reg [15:0]out;
alu dut(a,b,opcode,alu_en,result,overflow,zero,parity);

reg [31:0]str;
integer i;

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
     SL = 4'ha,
     INC = 4'hb,
     DEC = 4'hc,
	  XOR = 4'hd,
     XNOR = 4'he;

always@(*)
begin
	case(opcode)
		ADD : str = "ADD";
		SUB : str = "SUB";
		MUL : str = "MUL";
		DIV : str = "DIV";
		AND : str = "AND"; 
	   OR  : str = "OR";
		NAND: str = "NAND";
		NOR : str = "NOR";
		NOT : str = "NOT";
	   SR  : str = "SR"; 
	   SL  : str = "SL";  
	   INC : str = "INC";
	   DEC : str = "DEC"; 
		XOR : str = "XOR";
		XNOR: str = "XNOR";
	 endcase
end

task initialize;
begin
	a = 0;
	b = 0;
	alu_en = 0;
end
endtask

task stimulus(input [7:0]a_in,b_in, input [3:0]cmd_in);
	begin
		alu_en = 1'b1;
		a = a_in;
		b = b_in;
		opcode = cmd_in;
	end
endtask

initial 
begin
	initialize;
	#10;
	stimulus(8'b11111111,8'b01111111,1);
	#10;
	/*for (i=0;i<2;i=i+1)
	begin
		stimulus({$random%256},{$random%256},{$random%16});
		$display("carry = %b\n zero = %b\n overflow = %b\n parity = %b",carry,zero,overflow,parity);
		#10;
	end*/
	$monitor("a = %d | b = %d | opcode = %d | result = %d\nzero = %b\n overflow = %b\n parity = %b",a,b,opcode,result,zero,overflow,parity);
	#50 $finish;
end
endmodule



