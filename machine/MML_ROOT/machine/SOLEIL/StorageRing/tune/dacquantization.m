function b = dacquantization(a, q)
% function quantization for BPMs

b = a + sign(a) .* q/2 - rem( a+sign(a).*q/2 , q );