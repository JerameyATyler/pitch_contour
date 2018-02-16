function [ ynormalized ] = PseudoNormalizationZScore( y )
%Normalize input signal with mean = 300 and sd = 50
%   by Z-Score formular
m = 300;
s = 50;
si = size(y);

for i = 1:si(1)
    ynormalized(i, :) = (y(i , :) - m(i))/s(i);
end
end

