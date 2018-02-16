function y=comp1f(f0)

Fs=48000;

[y,t]=gensine(f0,1,Fs);

y=0.99.*y./(max(abs(y)));
