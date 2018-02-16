function [y,t]=gensine(freq,dur,Fs);

% function [y,t]=gensine(freq,dur,Fs);
%
% generates sine tone y with amplitude of one. 
% freq=frequency [Hz]
% dur=duration [s]
% Fs=sampling frequency
% t=time vector [s]
% 
% Jonas Braasch, RPI 2008

t=0:1./Fs:dur-1./Fs;
y=sin(freq*2*pi*t);