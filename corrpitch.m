Fs=48000;
[y1,t]=gensine(500,1,Fs);
[y2,t]=gensine(1000,1,Fs);
[y3,t]=gensine(1500,1,Fs);
[y4,t]=gensine(2000,1,Fs);
y=0*y1+0.5*y2+0.3*y3+0.15*y4;
%plot(t,y)
a=xcorr(y,y,480);
tt=(-480:480)./48000*1000;
f=48000./(-480:480);
figure
subplot(3,1,1)
index=find(a(482:961)<=0);
index=index(1)+481;

semilogx(f(961:-1:index),a(961:-1:index)./max(abs(a)),'k')
hold on
semilogx(f(index:-1:482),a(index:-1:482)./max(abs(a)),'k:')
hold off
axis([100 20000 -1.2 1.2]);

subplot(3,1,2)

N=4*1024;
X=fft(y,N);
Xc=X.*conj(X);
f= Fs*(1:N/2)/N;

Xc=Xc(1:length(f));
semilogx(f,Xc./(max(abs(Xc))),'k');
%ylabel('dB','FontSize',12);
%set(gca, 'FontSize', 12);
%grid on
hold off
axis([100 20000 0 1.2]);

subplot(3,1,3)
fcoefs=MakeERBFilters(Fs,48,100);
%fcoefs=fcoefs(25:48,:);
N=4096;
y=ERBFilterbank([1 zeros(1,N-1)],fcoefs);
resp=20*log10(abs(fft(y')));
freqScale=(0:N./2-1)/(N/2)*Fs;
semilogx(freqScale(1:N./2-1),resp(1:N./2-1,:));
%all_y=sum(abs(fft(y'))');
%all_y=all_y';
%respall=20*log10(all_y);
%hold on
%semilogx(freqScale(1:N./2-1),respall(1:N./2-1,:),'k:');
axis([100 20000 -40 5]);

xlabel('Frequency (Hz)');
ylabel('Filter Response (dB)');