///////////////////////////////////////////////////////////////////////////////////////////////////
// Part of paper Design and Analysis of Approximate 4-2 Compressors for HighAccuracy Multipliers
// 2022 April
//
// Contributers : Prof. Madhav Rao, Aakarsh Dev, Animesh Kumar Tiwari
// 
///////////////////////////////////////////////////////////////////////////////////////////////////

module pro_4(S,C,a,b,c,d);
 output S,C;
 input a,b,c,d;
 wire t1,t2;

 assign t1 = a^b;
 assign t2 = c^d;
 assign S = ~((~t1)&(c|d) | (t1)&(~t2));
 assign C = ~((~(a|b)&(~(c&d))) | (~(c|d)&(~(a&b))));

endmodule