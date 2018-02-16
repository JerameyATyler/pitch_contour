function x=cossquare(windowlength)

% cos^2 function for windowing purposes
% (c) Jonas Braasch, RPI 2012

x=sin([0:windowlength-1]./windowlength*pi).^2;
x=x';