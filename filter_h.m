%[y] = filter_h(Bh,Ah,x);
%Filters a signal x with the filter h, applying IIR filters.
%
%Input:
% Bh, Ah	Filter coefficients produced by the function get_coefs_IIR.m
% x		input signal
%
%Output:
% y		output signal
function [y] = filter_h(Bh,Ah,x);

%y = filter(Bh(1,:),Ah(1,:),x) + filter(Bh(2,:),Ah(2,:),x) + filter(Bh(3,:),Ah(3,:),x) + filter(Bh(4,:),Ah(4,:),x);
y = filter(Bh(1,:),Ah(1,:),x) + filter(Bh(2,:),Ah(2,:),x) + filter(Bh(3,:),Ah(3,:),x);