function [t,F,G,En]=SpeechF0(filename,plotFlag)

% Speech Contour Analysis
% J. Braasch
%
% filename: input filename
% plotFlag: 1=plot figure, 0=don't plot figure
% t: time in seconds
% F: F0 Fundamental Frequency [Hz]
% En: relative Energy
% G: Pitch Strength

[y,Fs]=audioread(filename);
tabs=4096;
[Y]=OLAsplit2(y(:,1),tabs);
t=(0:(length(Y(1,:))-1)).*tabs./Fs;

for n=1:length(Y(1,:))
    [F(n),G(n)]=pitchmodel18(Y(:,n),48000);
end


En=sqrt(sum(Y.^2)); % Energy
index1=find(En>0.1.*max(En) & G>0.98);

if plotFlag
figure
subplot(3,1,1);
plot(t,F)
hold on
plot(t(index1),F(index1),'r+')
xlabel('time');
ylabel('Frequency');
hold off
subplot(3,1,2);
plot(t,En);
xlabel('time');
ylabel('Energy');
subplot(3,1,3);
plot(t,G)
xlabel('time');
ylabel('Strength');
end % of if 