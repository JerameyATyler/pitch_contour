load DanResults
D1=sum(A1.*B1)./sum(A1);
D2=sum(A2.*B2)./sum(A2);
D3=sum(A3.*B3)./sum(A3);
D4=sum(A4.*B4)./sum(A4);
D5=sum(A5.*B5)./sum(A5);
D6=sum(A6.*B6)./sum(A6);

figure
barh([D1 D2 D3 D4 D5 D6])

set(gca,'Yticklabels',['  Violin';'     Sax';'   Voice'; '  Djembe'; '   Snare';'Theremin']);
xlabel(['Model Units [MU]']);
A=[D1 D2 D3 D4 D5 D6]
print -deps2 centAnaA.eps

figure
barh([mean(B1) mean(B2) mean(B3) mean(B4) mean(B5) mean(B6)])

set(gca,'Yticklabels',['  Violin';'     Sax';'   Voice'; '  Djembe'; '   Snare';'Theremin']);
xlabel(['Model Units [MU]']);
B=[mean(B1) mean(B2) mean(B3) mean(B4) mean(B5) mean(B6)]
print -deps2 centAnaB.eps

E1=sum(A1.*C1)./sum(A1);
E2=sum(A2.*C2)./sum(A2);
E3=sum(A3.*C3)./sum(A3);
E4=sum(A4.*C4)./sum(A4);
E5=sum(A5.*C5)./sum(A5);
E6=sum(A6.*C6)./sum(A6);
figure
barh([E1 E2 E3 E4 E5 E6])

set(gca,'Yticklabels',['  Violin';'     Sax';'   Voice'; '  Djembe'; '   Snare';'Theremin']);
xlabel(['Model Units [MU]']);
C=[E1 E2 E3 E4 E5 E6]
print -deps2 centAnaC.eps


figure
barh([mean(C1) mean(C2) mean(C3) mean(C4) mean(C5) mean(C6)])

set(gca,'Yticklabels',['  Violin';'     Sax';'   Voice'; '  Djembe'; '   Snare';'Theremin']);
xlabel(['Model Units [MU]']);
D=[mean(C1) mean(C2) mean(C3) mean(C4) mean(C5) mean(C6)]
print -deps2 centAnaD.eps

