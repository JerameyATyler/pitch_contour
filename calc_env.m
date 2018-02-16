function [y_env]=calc_env(y_mod,Fc,Fs,type)

% function [y_env]=calc_env(y_mod,Fc,Fs,type)
%
% estimates envelope y_env out of y
%
% y    = modulated signal
% Fc   = carrier frequency of signal
% Fs   = sampling frequency 
% type = type of demodulation
%
% warning 'ma' and 'mm' very sensitive to Fc!!!
%
% Jonas Braasch
% Institut fuer Kommunikationsakustik
% Ruhr-Universitaet Bochum
% 44780 Bochum 
% e-mail: braasch@ika.ruhr-uni-bochum.de
% 
% Date 18.05.1998 % last update 20.01.2000

if type=='am'
   y_env=demod(y_mod,Fc,Fs,'am');
end % of if 

if type=='mm'
  	[r,c]=size(y_mod);
	if r*c == 0,
	    x = []; return
	end
	if (r==1),   % convert row vector to column
	   y_mod = y_mod(:);  len = c;
	else
	    len = r;
	end
    t = (0:1/Fs:((len-1)/Fs))';
    t = t(:,ones(1,size(y_mod,2)));
    y_env = y_mod.*cos(2*pi*Fc*t);
    [b,a]=butter(5,Fc*2/Fs);
    for i = 1:size(y_mod,2),
        y_env(:,i) = filtfilt(b,a,y_env(:,i));
    end
    if (r==1),   % convert y_env from a column to a row
      y_env = y_env.';
    end
   
 end % of if 
 
 if type=='m2'
   y_hil=hilbert(y_mod);
   y_env=sqrt(real(y_hil).*real(y_hil)+imag(y_hil).*imag(y_hil));
 end % of if 

