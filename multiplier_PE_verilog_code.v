`timescale 1ns / 1ps

// Half Adder 

module HA(in1_ha, in2_ha, sum_ha, cout_ha);
input in1_ha, in2_ha;
output sum_ha, cout_ha;

assign {cout_ha,sum_ha} = in1_ha + in2_ha;

endmodule

// Full Adder

module FA(in1_fa, in2_fa, cin_fa, sum_fa, cout_fa);

input in1_fa, in2_fa, cin_fa;
output sum_fa, cout_fa;

assign {cout_fa,sum_fa} = in1_fa + in2_fa + cin_fa;

endmodule

// Exact 4-2 compressor

module EXACT(x4_ex, x3_ex, x2_ex, x1_ex, cin_ex, sum_ex, carry_ex, cout_ex);

input x4_ex, x3_ex, x2_ex, x1_ex, cin_ex;
output sum_ex, carry_ex, cout_ex;

assign sum_ex = x4_ex ^ x3_ex ^ x2_ex ^ x1_ex ^ cin_ex;
assign cout_ex = (x2_ex ^ x1_ex)&(x3_ex) | (~(x2_ex ^ x1_ex))&(x1_ex);
assign carry_ex = ((x4_ex ^ x3_ex ^ x2_ex ^ x1_ex)&(cin_ex)) | (~(x4_ex ^ x3_ex ^ x2_ex ^ x1_ex))&(x4_ex);
assign b1 = (~(x4_ex ^ x3_ex ^ x2_ex ^ x1_ex));
assign b2 = b1 &(x4_ex);
assign a1 = (x4_ex ^ x3_ex ^ x2_ex ^ x1_ex);
assign a2 = a1&(cin_ex);

endmodule


// Pro 5 approximate compressor

module APPROX_PRO5(x4_ap, x3_ap, x2_ap, x1_ap, sum_ap, cout_ap);

input x4_ap, x3_ap, x2_ap, x1_ap;
output sum_ap, cout_ap;
wire d1,d2,d3,d4,O2,O3,O4;

assign d1 = ~(x1_ap | x2_ap);
assign d2 = ~(x3_ap | x4_ap);
assign d3 = ~(x1_ap & x2_ap);
assign d4 = ~(x3_ap & x4_ap);
assign O2 = (d1 | d2) | (d3 & d4);
assign O3 = (d1 | d2) & (d3 & d4);
assign O4 = d1 & d2;

assign sum_ap = (O3 & (~O4)) | (~O2);
assign cout_ap = ~O3;

endmodule

// Now we are starting the top level module

module Eight_bit_multiplier;

wire [7:0] A=8'b11010011;
wire [7:0] B=8'b11001110;
//output wire [15:0] y;
wire  pp [7:0][7:0];
wire pp2 [3:0][14:0];
wire pp3 [1:0][14:0];
wire pp4 [15:0];
wire carry_e0,carry_e1,carry_e2;

// generating partial products 

genvar i;
genvar j;

for(i = 0; i<8; i=i+1)begin

   for(j = 0; j<8;j = j+1)begin
      assign pp[i][j] = A[j]*B[i];
end
end

// partial products generated

assign pp2[0][0] = pp[0][0];
assign pp2[1][0] = 1'b0;
assign pp2[2][0] = 1'b0;
assign pp2[3][0] = 1'b0;

assign pp2[0][1] = pp[0][1];
assign pp2[1][1] = pp[1][0];
assign pp2[2][1] = 1'b0;
assign pp2[3][1] = 1'b0;

assign pp2[0][2] = pp[0][2];
assign pp2[1][2] = pp[1][1];
assign pp2[2][2] = pp[2][0];
assign pp2[3][2] = 1'b0;

assign pp2[0][3] = pp[0][3];
assign pp2[1][3] = pp[1][2];
assign pp2[2][3] = pp[2][1];
assign pp2[3][3] = pp[3][0];

HA h0 (pp[0][4], pp[1][3], pp2[0][4], pp2[1][5]);
assign pp2[1][4] = pp[2][2];
assign pp2[2][4] = pp[3][1];
assign pp2[3][4] = pp[4][0];

APPROX_PRO5 ap0 (pp[0][5], pp[1][4], pp[2][3], pp[3][2], pp2[0][5], pp2[1][6]);
assign pp2[2][5] = pp[4][1];
assign pp2[3][5] = pp[5][0];

assign pp2[3][6] = pp[6][0];
HA h1 (pp[4][2], pp[5][1], pp2[2][6], pp2[3][7]);
APPROX_PRO5 ap1 (pp[0][6], pp[1][5], pp[2][4], pp[3][3], pp2[0][6], pp2[1][7]);

APPROX_PRO5 ap2 (pp[0][7], pp[1][6], pp[2][5], pp[3][4], pp2[0][7], pp2[1][8]);
APPROX_PRO5 ap3 (pp[4][3], pp[5][2], pp[6][1], pp[7][0], pp2[2][7], pp2[3][8]);

wire carry_in;

assign carry_in = 1'b0;

EXACT e0 (pp[1][7], pp[2][6], pp[3][5], pp[4][4], carry_in, pp2[0][8], carry_e0, pp2[1][9]);
FA f0 (pp[5][3], pp[6][2], pp[7][1], pp2[2][8], pp2[3][9]);

EXACT e1 (pp[2][7], pp[3][6], pp[4][5], pp[5][4], carry_e0, pp2[0][9], carry_e1, pp2[1][10]);
HA h2 (pp[6][3], pp[7][2], pp2[2][9], pp2[3][10]);

assign pp2[2][10] = pp[7][3];
EXACT e2 (pp[3][7], pp[4][6], pp[5][5], pp[6][4], carry_e1, pp2[0][10], carry_e2, pp2[1][11]);

assign pp2[2][11] = pp[6][5];
assign pp2[3][11] = pp[7][4];
FA f1 (pp[4][7], pp[5][6], carry_e2, pp2[0][11], pp2[1][12]);

assign pp2[2][12] = pp[6][6];
assign pp2[3][12] = pp[7][5];
assign pp2[0][12] = pp[5][7];


assign pp2[0][13] = pp[6][7];
assign pp2[1][13] = pp[7][6];
assign pp2[2][13] = 1'b0;
assign pp2[3][13] = 1'b0;

assign pp2[0][14] = pp[7][7];
assign pp2[1][14] = 1'b0;
assign pp2[2][14] = 1'b0;
assign pp2[3][14] = 1'b0;

// Now writing the code for third stage

assign pp3[0][0] = pp2[0][0];
assign pp3[1][0] = 1'b0;

assign pp3[0][1] = pp2[0][1];
assign pp3[1][1] = pp2[1][1];

HA h3 (pp2[0][2], pp2[1][2], pp3[0][2], pp3[1][3]);
assign pp3[1][2] = pp2[2][2];

APPROX_PRO5 ap4 (pp2[0][3], pp2[1][3], pp2[2][3], pp2[3][3], pp3[0][3], pp3[1][4]);

APPROX_PRO5 ap5 (pp2[0][4], pp2[1][4], pp2[2][4], pp2[3][4], pp3[0][4], pp3[1][5]);

APPROX_PRO5 ap6 (pp2[0][5], pp2[1][5], pp2[2][5], pp2[3][5], pp3[0][5], pp3[1][6]);

APPROX_PRO5 ap7 (pp2[0][6], pp2[1][6], pp2[2][6], pp2[3][6], pp3[0][6], pp3[1][7]);

APPROX_PRO5 ap8 (pp2[0][7], pp2[1][7], pp2[2][7], pp2[3][7], pp3[0][7], pp3[1][8]);

wire carry_e3,carry_e4,carry_e5,carry_e6,carry_e7;


EXACT e3 (pp2[0][8], pp2[1][8], pp2[2][8], pp2[3][8], carry_in, pp3[0][8], carry_e3, pp3[1][9]);

EXACT e4 (pp2[0][9], pp2[1][9], pp2[2][9], pp2[3][9], carry_e3, pp3[0][9], carry_e4, pp3[1][10]);

EXACT e5 (pp2[0][10], pp2[1][10], pp2[2][10], pp2[3][10], carry_e4, pp3[0][10], carry_e5, pp3[1][11]);

EXACT e6 (pp2[0][11], pp2[1][11], pp2[2][11], pp2[3][11], carry_e5, pp3[0][11], carry_e6, pp3[1][12]);

EXACT e7 (pp2[0][12], pp2[1][12], pp2[2][12], pp2[3][12], carry_e6, pp3[0][12], carry_e7, pp3[1][13]);

FA f2 (pp2[0][13], pp2[1][13], carry_e7, pp3[0][13], pp3[1][14]);

assign pp3[0][14] = pp2[0][14];

// Last stage 

wire carry4_0,carry4_1,carry4_2,carry4_3,carry4_4,carry4_5,carry4_6,carry4_7,carry4_8,carry4_9,carry4_10,carry4_11,carry4_12,carry4_13,carry4_14;

FA pp4_0 (pp3[0][0], pp3[1][0], 1'b0, pp4[0], carry4_0);

FA pp4_1 (pp3[0][1], pp3[1][1], carry4_0, pp4[1], carry4_1);

FA pp4_2 (pp3[0][2], pp3[1][2], carry4_1, pp4[2], carry4_2);

FA pp4_3 (pp3[0][3], pp3[1][3], carry4_2, pp4[3], carry4_3);

FA pp4_4 (pp3[0][4], pp3[1][4], carry4_3, pp4[4], carry4_4);

FA pp4_5 (pp3[0][5], pp3[1][5], carry4_4, pp4[5], carry4_5);

FA pp4_6 (pp3[0][6], pp3[1][6], carry4_5, pp4[6], carry4_6);

FA pp4_7 (pp3[0][7], pp3[1][7], carry4_6, pp4[7], carry4_7);

FA pp4_8 (pp3[0][8], pp3[1][8], carry4_7, pp4[8], carry4_8);

FA pp4_9 (pp3[0][9], pp3[1][9], carry4_8, pp4[9], carry4_9);

FA pp4_10 (pp3[0][10], pp3[1][10], carry4_9, pp4[10], carry4_10);

FA pp4_11 (pp3[0][11], pp3[1][11], carry4_10, pp4[11], carry4_11);

FA pp4_12 (pp3[0][12], pp3[1][12], carry4_11, pp4[12], carry4_12);

FA pp4_13 (pp3[0][13], pp3[1][13], carry4_12, pp4[13], carry4_13);

FA pp4_14 (pp3[0][14], pp3[1][14], carry4_13, pp4[14], pp4[15]);

endmodule


