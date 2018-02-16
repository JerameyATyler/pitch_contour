function [y3,y2,y1,opx] = model_process_IIR(x,Bh,Ah,fcoefs,Blp,Alp,B,A);

N = length(x);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%preprocessing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%bandpass filtering -> ERB-filters
y = erbfilterbank(x,fcoefs);

%envelope calculations / hair cells
y = 1*(y + abs(y));
y1 = filter(Blp,Alp,y);
y1 = y1.^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%adaptation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%create internal noise
%Lx = 2;
%ax = 10.^(Lx/20);
%nx = (ax*nx);
%nx = erbfilterbank(nx,fcoefs);
%nx = filter(Blp,Alp,nx.^2);
%nx = .5*(nx + abs(nx));
nx = 2;

%operating point signal opx
a1 = 7;%10%18 a1 und a2 decribe the variation of the Basilar membrane NL of the Log-Function
opx = 10*log10(y1/a1+1);%opx: signal describing the operating point
opx = filter_h(Bh,Ah,opx);
opx = 10.^(opx/10);%factor a1 ignored and normally op = opxm -1 + 1 = opxm

%output of the SDC stage y2
y2 = 10*log10(1 + (y1+nx)./opx);
y2 = .5*(y2 + abs(y2));%instantaneous ouptut signal

%output of the temporal integrator w(n) y3
y3 = filter(B,A,y2);
