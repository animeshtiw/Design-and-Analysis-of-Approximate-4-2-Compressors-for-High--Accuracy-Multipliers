function [sum_fa, carry_fa] = FA(in1, in2,cin_fa)
    sum_fa = bitxor(bitxor(in1,in2),cin_fa);
    carry_fa = bitor(bitand(in1,in2),bitand(bitxor(in1,in2),cin_fa));
end