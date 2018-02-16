function buchana(filename)
disp(filename)
[y,Fs2]=wavread([filename '.wav']); 
Fs=16000;
x=resample(y(:,1),Fs,Fs2);
x=([zeros(1000,1); 10000.*x; zeros(1000,1)])';
f0 = 1;%mid frequency of auditory channel in kHz
fa = 16;%sampling frequency in kHz
load midF32k
f0=midFreq(1:20)./1000;
for n=1:20
disp(['band: ' int2str(n)]);
[Bh,Ah,fcoefs,Blp,Alp,B,A] = get_coefs_IIR(f0(n),fa);%all required coefficients
[y3,y2,y1,opx] = model_process(x,Bh,Ah,fcoefs,Blp,Alp,B,A);%calculation of output signal
ye(n,:)=y3;
yd(n,:)=derive(y3,1);
end %of for
if 0
figure
subplot(3,1,1)
plot(y1)
subplot(3,1,2)
plot(y2)
subplot(3,1,3)
plot(y3)
end % of if 

YE=sum(ye);
YD=derive(YE,1);

%eval(['save ' filename '3 ye yd'])
eval(['save ' filename '4 YE YD'])