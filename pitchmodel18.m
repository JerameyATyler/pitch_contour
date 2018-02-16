function [F0,G2]=pitchmodel(x,Fs);
%Fs=48000;

% internal variables to tune model
FigOn=0;
freqSel=0;
maxSel=0;
ratioSel=0;
freqSel2=0;
maxSel2=0;
ratioSel2=0;


% load filters
load poly2.erb -mat
y=ERBFilterBank(x,fcoefs);

a=xcorr(x,x,480);
tt=(-480:480)./48000*1000;
% define frequency axis for time-based autocorrelation function
f=48000./(-480:480); % f=Fs/t

tabs=480;
% runs through lower frequency bands (expect no rate code at higher bands)
for n=1:32*2
        % perform autocorrelation function within each frequency band
        a=xcorr(y(n,:),y(n,:),tabs);
        % creating window function
        wind=(1+0.15.*hanning(tabs*2+1))';
        % b is a weighted autocorrelation function to emphasize closer
        % sidepeaks to main peak, deemphasize outer side peaks.
        b(n,:)=a.*wind;
        bb(n)=sqrt(sum(y(n,:).^2));
        % Look for maximum outside the main peak, that is why you look for
        % minmimum first 
        [mini,index]=min(b(n,tabs+1:tabs*2+1));
        b(n,:)=a;
        [maxi,index2]=max(b(n,tabs+index(1):tabs*2+1));
        % amplitude of maxumimum
        g(n)=maxi;
        % time location of side peak maximum [tabs]
        c(n)=index(1)+index2(1)-1;
        % musical note analysis
        [n1,n2,n3,n4]=note3(Fs./c(n));
        d(n)=b(n,481); % I think this is related to pitch strength
        e{n}=char(n2);
        h(n)=n4;
        % Fs./c(n) is frequency detected in each band
        if FigOn
            if n==1
                disp(['Frequency Band index/center frequency, frequency measured in this band with AC'])
            end
            disp([int2str(n) '/' int2str(CenterFreq(n)) ': ' int2str(Fs./c(n)) 'Hz, '  char(e(n)) ', '  int2str(d(n)) 'amp, '  num2str(g(n)/d(n),2) 'd, ' int2str(n3) 'oct, ' int2str(h(n)) 'c'])
        end
end    

FreqSpread=0.2;
d2=sqrt(d);

index=find(Fs./c >60 & Fs./c <400  & (g./d)>=0.90 & abs(log2(Fs./c)-log2(CenterFreq(1:64)))<=FreqSpread);
%plot(Fs./c(index),d2(index),'k+','markersize',10);
G=g./d;
if length(index)>=5
    [D,I]=sort(d2(index));
    D2=d2(index(I(length(I)-4:length(I))));
    F=Fs./(c(index(I(length(I)-4:length(I)))));
    F0=median(F);
    %G2=median(G(index(I(length(I)-4:length(I)))));
else
    F0=median(Fs./(c(index)));
    %G2=median(G(index));
end