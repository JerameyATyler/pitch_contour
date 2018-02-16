function [ nF, t ] = toPitchContour( sig, Fs )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% Filtering (150Hz high pass filter )

wn = [150 2000]/(Fs/2);
[b ,a] = butter(5, wn);
midy = filter(b,a,sig);

%midy = sig;
%sound(midy, Fs);

% Make sure midy is column vector
s = size(midy);
if s(1) <= 2
    midy = midy';
end

tic
[t,F,midy,Fs] = MySpeechF0(midy, Fs);
toc

[nF] = PseudoNormalizationZScore(F);

end

