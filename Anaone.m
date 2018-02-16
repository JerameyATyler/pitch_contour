function [A,B,C]=anaone(filename);
%[y,Fs]=wavread('violin.wav'); 
%[y,Fs]=wavread('sax.wav'); 
%[y,Fs]=wavread('voice.wav'); 
%[y,Fs]=wavread('djembe.wav'); 
[y,Fs]=wavread(filename); 
disp(filename)
t=0:1./Fs:(length(y)-1)./Fs;
%plot(t,y(:,1))
fcoefs=MakeERBFilters(Fs,36,20);
fcoefs=fcoefs(36:-1:1,:);
tablength=882;
%for m=1:29
for m=1:(length(y)./tablength)-2
x=ERBFilterbank(y(m*tablength+1:m*tablength+tablength,1),fcoefs);
%toc
for n=1:36
    X=x(n,:);
    z(n)=sum(sqrt(X.^2));
end % of for 
%whos
A(m)=sum(z);
if A(m)==0
    centroid=0
    bandwidth=0;
else 
    centroid=sum(z.*(1:36))./sum(z);
    %bandwidth=(z(1:36).*abs((1:36)-centroid))./sum(z)
    bandwidth=sum(z.*abs((1:36)-centroid))./sum(z);    
end % of if     
C(m)=centroid;
B(m)=bandwidth;
end % of for 
