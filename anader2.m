%function [A,B,C]=anaone(filename);
%[y,Fs]=wavread('violin.wav'); 
%[y,Fs]=wavread('sax.wav'); 
%[y,Fs]=wavread('voice.wav'); 
[y,Fs]=wavread('djembe.wav'); 
%[y,Fs]=wavread(filename); 
t=0:1./Fs:(length(y)-1)./Fs;
%plot(t,y(:,1))
fcoefs=MakeERBFilters(Fs,36,20);
fcoefs=fcoefs(36:-1:1,:);
tic
x=ERBFilterbank(y(:,1),fcoefs);
toc
n=10;
load midF
%x(n,:)=x(n,:).*hanning(length(x(n,:)))';
y=calc_env(x(n,:),midFreq(n),Fs,'m2');
toc
yd=derive(y,1);
toc

figure
plot(y)
figure
plot(yd)
     