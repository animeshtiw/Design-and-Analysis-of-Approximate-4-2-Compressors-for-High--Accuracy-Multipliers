function [sum_ap, cout_ap] = AP(x4_ap, x3_ap, x2_ap, x1_ap)

    d1 = ~(bitor(x1_ap,x2_ap));
    d2 = ~(bitor(x3_ap,x4_ap));
    d3 = ~(bitand(x1_ap,x2_ap));
    d4 = ~(bitand(x3_ap,x4_ap));
    O2 = bitor(bitor(d1,d2),bitand(d3,d4));
    O3 = bitand(bitor(d1,d2),bitand(d3,d4));
    O4 = bitand(d1,d2);

    sum_ap = bitor((bitand(O3,~(O4))),~(O2));
    cout_ap = ~(O3);
end
