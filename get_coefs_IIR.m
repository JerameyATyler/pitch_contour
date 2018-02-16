function [Bh,Ah,fcoefs,Blp,Alp,B,A] = get_coefs_IIR(f0,fa)

%barilare membrane filtering
fcoefs = MakeERBFilters(fa*1000,[f0 f0]*1000);
fcoefs = fcoefs(1,:);

%hair cell low pass filter
[Blp,Alp] = butter(5,2/fa); 

%create filter h
%t = 1:1:500*fa;
%nr0 = [2.5 10 50]*fa;
%ar = [.24 .21 .47];

nr0 = [2.5 10 75]*fa;
ar = [.224 .274 .487];

[B1,A1] = butter(1,1/(pi*nr0(1)));
[B2,A2] = butter(1,1/(pi*nr0(2)));
[B3,A3] = butter(1,1/(pi*nr0(3)));

Bh = [ar(1)*B1 ; ar(2)*B2 ; ar(3)*B3];

Ah = [A1 ; A2 ; A3];

%create integrator w(n)
[B,A] = butter(1,2*4/(fa*1000));


	


