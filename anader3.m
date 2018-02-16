function anader3(filename);

disp(filename)
[y,Fs2]=wavread([filename '.wav']); 
Fs=32000;
y=resample(y(:,1),Fs,Fs2);
t=0:1./Fs:(length(y)-1)./Fs;
%plot(t,y(:,1))
fcoefs=MakeERBFilters(Fs,24,50);
fcoefs=fcoefs(24:-1:1,:);
tic
x=ERBFilterBank(y(:,1),fcoefs);
load midF32k
for n=1:24
disp(['band: ' int2str(n)]);
%x(n,:)=x(n,:).*hanning(length(x(n,:)))';
ye=calc_env(x(n,:),midFreq(n),Fs,'m2');

ye2(:,n)=resample(ye',2000,Fs);
yd(:,n)=derive(ye2(:,n),1);
end % of for
YE=sum(ye2');
YD=derive(YE,1);

eval(['save ' filename ' ye2 yd'])
eval(['save ' filename '2 YE YD'])
toc