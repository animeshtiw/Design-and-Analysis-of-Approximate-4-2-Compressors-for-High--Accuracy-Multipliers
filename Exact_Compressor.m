function [sum_ex, carry_ex, cout_ex] = EX(x4_ex, x3_ex, x2_ex, x1_ex, cin_ex)

    sum_ex = bitxor((bitxor(bitxor(bitxor(x4_ex,x3_ex),x2_ex),x1_ex)),cin_ex);
    carry_ex = ((bitxor(bitxor(bitxor(x4_ex,x3_ex),x2_ex),x1_ex))&(cin_ex)) | (~((bitxor(bitxor(bitxor(x4_ex,x3_ex),x2_ex),x1_ex))))&(x4_ex);
    cout_ex = (bitxor(x2_ex,x1_ex))&(x3_ex) | (~(bitxor(x2_ex,x1_ex)))&(x1_ex);
end
