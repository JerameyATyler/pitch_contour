clear

x = [zeros(1,2000) 10000*randn(1,10000) zeros(1,5000)];

f0 = 1;%mid frequency of auditory channel in kHz
fa = 16;%sampling frequency in kHz
[Bh,Ah,fcoefs,Blp,Alp,B,A] = get_coefs_IIR(f0,fa);%all required coefficients

[y3,y2,y1,opx] = model_process(x,Bh,Ah,fcoefs,Blp,Alp,B,A);%calculation of output signal

