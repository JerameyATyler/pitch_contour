Fs=32000;

%plot(t,y(:,1))
fcoefs=MakeERBFilters(Fs,24,50);
fcoefs=fcoefs(24:-1:1,:);
y=ERBFilterbank([1 zeros(1,511)],fcoefs);
resp=20*log10(abs(fft(y',4096)));
%freqScale=(0:2047)/2048*Fs;
freqScale=(0:2047)/4096*Fs;
semilogx(freqScale(1:2047),resp(1:2047,:));
all_y=sum(abs(fft(y',4096))');
all_y=all_y';
respall=20*log10(all_y);
hold on
semilogx(freqScale(1:2047),respall(1:2047,:),'k:');
%f=bark2hz(1:22);
%plot(f,zeros(22,1)+5,'r+')
axis([100 14000 -60 10]);
xlabel('Frequency (Hz)');
ylabel('Filter Response (dB)');

length(resp(1,:))
for n=1:length(resp(1,:))
   [Y,I]=max(resp(1:2047,n));
   index=find(resp(1:I,n)>Y-3);
   left_range=index(1);
   index=find(resp(I:2047,n)<Y-3);
   right_range=index(1)+I-1;
   maximum=Y;
%   plot(freqScale(I),maximum,'+');
   disp(['band: ' int2str(25-n) ' left: ' int2str(freqScale(left_range)) ' max: ' int2str(freqScale(I)) ' right: ' int2str(freqScale(right_range))]);
   midFreq(n)=freqScale(I)
end % of for 
save midF32k midFreq;

