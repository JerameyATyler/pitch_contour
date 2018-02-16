function y=comp1f(f0)

Fs=48000;

%[y1,t]=gensine(f0,1,Fs);
[y2,t]=gensine(f0*2,1,Fs);
[y3,t]=gensine(f0*3,1,Fs);
[y4,t]=gensine(f0*4,1,Fs);
[y5,t]=gensine(f0*5,1,Fs);
[y6,t]=gensine(f0*6,1,Fs);
[y7,t]=gensine(f0*7,1,Fs);
[y8,t]=gensine(f0*8,1,Fs);
[y9,t]=gensine(f0*9,1,Fs);
[y10,t]=gensine(f0*10,1,Fs);
%y=y1+y2./2+y3./3+y4./4+y5./5+y6./6+y7./7+y8./8+y9./9+y10./10;
y=y2./2+y3./3+y4./4+y5./5+y6./6+y7./7+y8./8+y9./9+y10./10;
%y=y1+y2+y3+y4+y5+y6+y7+y8+y9+y10;

y=0.99.*y./(max(abs(y)));
