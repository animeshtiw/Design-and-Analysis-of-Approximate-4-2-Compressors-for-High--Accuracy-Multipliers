///////////////////////////////////////////////////////////////////////////////////////////////////
// Part of paper Design and Analysis of Approximate 4-2 Compressors for HighAccuracy Multipliers
// 2022 April
//
// Contributers : Prof. Madhav Rao, Aakarsh Dev, Animesh Kumar Tiwari
// 
///////////////////////////////////////////////////////////////////////////////////////////////////

module pro_5(S,C,a,b,c,d);
 output S,C;
 input a,b,c,d;
 wire d1,d2,d3,d4,O2,O3,O4;

assign C = ~O3;
assign S = (O3&(~O4)) | (~O2);
assign d1 = ~(a|b);
assign d2 = ~(c|d);
assign d3 = ~(a&b);
assign d4 = ~(c&d);
assign O4 = d1 & d2;
assign O3 = (d1 | d2) & (d3 & d4);
assign O2 = (d1 | d2) | (d3 & d4);

endmodule