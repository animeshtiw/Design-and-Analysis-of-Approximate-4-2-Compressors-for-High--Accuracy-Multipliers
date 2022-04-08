function [sum_ha, carry_ha] = HA(in1, in2)
    sum_ha = bitxor(in1,in2);
    carry_ha = bitand(in1,in2);
end