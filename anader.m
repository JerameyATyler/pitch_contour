%function [A,B,C]=anaone(filename);
%[y,Fs]=wavread('violin.wav'); 
[y,Fs]=wavread('sax.wav'); 
%[y,Fs]=wavread('voice.wav'); 
%[y,Fs]=wavread('djembe.wav'); 
%[y,Fs]=wavread(filename); 
t=0:1./Fs:(length(y)-1)./Fs;
%plot(t,y(:,1))
fcoefs=MakeERBFilters(Fs,36,20);
fcoefs=fcoefs(36:-1:1,:);

x=ERBFilterbank(y(200001:200882,1),fcoefs);
n=10;
load midF
clear y p s
x(n,:)=x(n,:).*hanning(length(x(n,:)))';
figure
plot(x(n,:))
y=calc_env(x(n,:),midFreq(n),Fs,'m2');

[p,s]=polyfit(t(1:882),y,20);
z2=polyval(p,t,s);

figure
plot(y)
hold on
plot(z2,'r')
hold off
     p=polyder(p);
     z(n,:)=polyval(p,t,s);
     

     figure
     plot(z(n,:))
     