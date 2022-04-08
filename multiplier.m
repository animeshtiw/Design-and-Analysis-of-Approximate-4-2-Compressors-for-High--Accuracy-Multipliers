function [answer] = multiplier(in1,in2)
a = de2bi(in1,8,'right-msb');
b = de2bi(in2,8,'right-msb');
pp = zeros(8,8);
pp2 = zeros(4,15);
pp3 = zeros(2,15);
pp4 = zeros(1,15);

for i=1:8
        for j=1:8
            pp(i,j) = a(j)&b(i);
        end
end

pp2(1,1) = pp(1,1);
pp2(2,1) = 0;
pp2(3,1) = 0;
pp2(4,1) = 0;

pp2(1,2) = pp(1,2);
pp2(2,2) = pp(2,1);
pp2(3,2) = 0;
pp2(4,2) = 0;

pp2(1,3) = pp(1,3);
pp2(2,3) = pp(2,2);
pp2(3,3) = pp(3,1);
pp2(4,3) = 0;

pp2(1,4) = pp(1,4);
pp2(2,4) = pp(2,3);
pp2(3,4) = pp(3,2);
pp2(4,4) = pp(4,1);

[pp2(1,5), pp2(2,6)] = HA(pp(1,5), pp(2,4));
pp2(2,5) = pp(3,3);
pp2(3,5) = pp(4,2);
pp2(4,5) = pp(5,1);

[pp2(1,6), pp2(2,7)] = AP(pp(1,6), pp(2,5), pp(3,4), pp(4,3));
pp2(3,6) = pp(5,2);
pp2(4,6) = pp(6,1);

pp2(4,7) = pp(7,1);
[pp2(3,7), pp2(4,8)] = HA(pp(5,3), pp(6,2));
[pp2(1,7), pp2(2,8)] = AP(pp(1,7), pp(2,6), pp(3,5), pp(4,4));

[pp2(1,8), pp2(2,9)] = AP(pp(1,8), pp(2,7), pp(3,6), pp(4,5));
[pp2(3,8), pp2(4,9)] = AP(pp(5,4), pp(6,3), pp(7,2), pp(8,1));

carry_in = 0;

[pp2(1,9), carry_e0, pp2(2,10)] = EX(pp(2,8), pp(3,7), pp(4,6), pp(5,5), carry_in);
[pp2(3,9), pp2(4,10)] = FA(pp(6,4), pp(7,3), pp(8,2));

[pp2(1,10), carry_e1, pp2(2,11)] = EX(pp(3,8), pp(4,7), pp(5,6), pp(6,5), carry_e0);
[pp2(3,10), pp2(4,11)] = HA(pp(7,4), pp(8,3));

pp2(3,11) = pp(8,4);
[pp2(1,11), carry_e2, pp2(2,12)] = EX(pp(4,8), pp(5,7), pp(6,6), pp(7,5), carry_e1);

pp2(3,12) = pp(7,6);
pp2(4,12) = pp(8,5);
[pp2(1,12), pp2(2,13)] = FA(pp(5,8), pp(6,7), carry_e2);


pp2(3,13) = pp(7,7);
pp2(4,13) = pp(8,6);
pp2(1,13) = pp(6,8);
pp2(1,14) = pp(7,8);

pp2(2,14) = pp(8,7);
pp2(3,14) = 0;
pp2(4,14) = 0;
pp2(1,15) = pp(8,8);

pp2(2,15) = 0;
pp2(3,15) = 0;
pp2(4,15) = 0;


pp3(1,1) = pp2(1,1);
pp3(2,1) = 0;

pp3(1,2) = pp2(1,2);
pp3(2,2) = pp2(2,2);

[pp3(1,3), pp3(2,4)] = HA(pp2(1,3), pp2(2,3));
pp3(2,3) = pp2(3,3);

[pp3(1,4), pp3(2,5)] = AP(pp2(1,4), pp2(2,4), pp2(3,4), pp2(4,4));

[pp3(1,5), pp3(2,6)] = AP(pp2(1,5), pp2(2,5), pp2(3,5), pp2(4,5));

[pp3(1,6), pp3(2,7)] = AP(pp2(1,6), pp2(2,6), pp2(3,6), pp2(4,6));
        
[pp3(1,7), pp3(2,8)] = AP(pp2(1,7), pp2(2,7), pp2(3,7), pp2(4,7));

[pp3(1,8), pp3(2,9)] = AP(pp2(1,8), pp2(2,8), pp2(3,8), pp2(4,8));

[pp3(1,9), carry_e3, pp3(2,10)] = EX(pp2(1,9), pp2(2,9), pp2(3,9), pp2(4,9), carry_in);

[pp3(1,10), carry_e4, pp3(2,11)] = EX(pp2(1,10), pp2(2,10), pp2(3,10), pp2(4,10), carry_e3);

[pp3(1,11), carry_e5, pp3(2,12)] = EX(pp2(1,11), pp2(2,11), pp2(3,11), pp2(4,11), carry_e4);

[pp3(1,12), carry_e6, pp3(2,13)] = EX(pp2(1,12), pp2(2,12), pp2(3,12), pp2(4,12), carry_e5);

[pp3(1,13), carry_e7, pp3(2,14)] = EX(pp2(1,13), pp2(2,13), pp2(3,13), pp2(4,13), carry_e6);

[pp3(1,14), pp3(2,15)] = FA(pp2(1,14), pp2(2,14), carry_e7);

pp3(1,15) = pp2(1,15);

[pp4(1), carry4_1] = FA(pp3(1,1), pp3(2,1), carry_in);
[pp4(2), carry4_2] = FA(pp3(1,2), pp3(2,2), carry4_1);
[pp4(3), carry4_3] = FA(pp3(1,3), pp3(2,3), carry4_2);
[pp4(4), carry4_4] = FA(pp3(1,4), pp3(2,4), carry4_3);
[pp4(5), carry4_5] = FA(pp3(1,5), pp3(2,5), carry4_4);
[pp4(6), carry4_6] = FA(pp3(1,6), pp3(2,6), carry4_5);
[pp4(7), carry4_7] = FA(pp3(1,7), pp3(2,7), carry4_6);
[pp4(8), carry4_8] = FA(pp3(1,8), pp3(2,8), carry4_7);
[pp4(9), carry4_9] = FA(pp3(1,9), pp3(2,9), carry4_8);
[pp4(10), carry4_10] = FA(pp3(1,10), pp3(2,10), carry4_9);
[pp4(11), carry4_11] = FA(pp3(1,11), pp3(2,11), carry4_10);
[pp4(12), carry4_12] = FA(pp3(1,12), pp3(2,12), carry4_11);
[pp4(13), carry4_13] = FA(pp3(1,13), pp3(2,13), carry4_12);
[pp4(14), carry4_14] = FA(pp3(1,14), pp3(2,14), carry4_13);
[pp4(15), pp4(16)] = FA(pp3(1,15), pp3(2,15), carry4_14);

answer = bi2de(pp4,'right-msb'); 

end
