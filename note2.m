function [s,s2]=note2(o)
n=round(12*o);
cents = 100*(12*o-n);
oct=floor((n-3)/12)+5;
chroma=mod(n,12);
chromalist = {'A'; 'A#'; 'B'; 'C'; 'C#'; 'D'; 'D#'; 'E'; 'F'; 'F#';...
	'G'; 'G#'};
cents = sprintf('%+.0f',cents);
s=[char(chromalist(chroma+1)),num2str(oct),' ',num2str(cents), ' cents'];
s2=[num2str(oct),char(chromalist(chroma+1))];
