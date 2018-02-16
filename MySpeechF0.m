function [t,F,y,Fs]=MySpeechF0(y,Fs)

% Speech Contour Analysis
% J. Braasch
%
% filename: input filename
% plotFlag: 1=plot figure, 0=don't plot figure
% t: time in seconds
% F: F0 Fundamental Frequency [Hz]
% En: relative Energy
% G: Pitch Strength
% index1: valid time in seconds
% y: signal from wav file
% Fs: Sample rate

tabs=4096;

%{
% Huang's code
% Creating low-cut and high-cut filter
bhi = fir1(34, 0.28, 'high', chebwin(35, 30));  % low-cut/high-pass
blo = fir1(34, 0.58, chebwin(35, 30));  %high-cut/low-pass

% Filtering signal
y = filter(bhi, 1, y);
y = filter(blo, 1, y);
%}

[Y]=OLAsplit2(y(:,1),tabs);
t=(0:(length(Y(1,:))-1)).*0.5.*tabs./Fs;

for n=1:length(Y(1,:))
    [F(n),]=pitchmodel18(Y(:,n),48000);
end

