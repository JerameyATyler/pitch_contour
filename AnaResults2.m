load DanResults2
D1=sum(A1.*B1)./sum(A1);
D2=sum(A2.*B2)./sum(A2);

figure
barh([D1 D2])

set(gca,'Yticklabels',['drum';'harp']);
xlabel(['Model Units [MU]']);
A=[D1 D2]
print -deps2 centAnaA2.eps

figure
barh([mean(B1) mean(B2)])

set(gca,'Yticklabels',['drum';'harp']);
xlabel(['Model Units [MU]']);
B=[mean(B1) mean(B2)]
print -deps2 centAnaB2.eps

E1=sum(A1.*C1)./sum(A1);
E2=sum(A2.*C2)./sum(A2);
figure
barh([E1 E2])

set(gca,'Yticklabels',['drum';'harp']);
xlabel(['Model Units [MU]']);
C=[E1 E2]
print -deps2 centAnaC2.eps


figure
barh([mean(C1) mean(C2)])

set(gca,'Yticklabels',['drum';'harp']);
xlabel(['Model Units [MU]']);
D=[mean(C1) mean(C2)]
print -deps2 centAnaD2.eps

