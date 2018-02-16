load drumExp14
A(1)=prctile(YD,99);
B(1)=std(YD);
index=find(YD>0);
YD=YD(index);
C(1)=prctile(YD,99);
D(1)=std(YD);

load harpExp14
A(2)=prctile(YD,99);
B(2)=std(YD);
index=find(YD>0);
YD=YD(index);
C(2)=prctile(YD,99);
D(2)=std(YD);

figure
barh(A)
set(gca,'Yticklabels',['drum';'harp']);
xlabel(['Model Units [MU]']);
print -deps2 attackAna2A.eps
figure
barh(B)
set(gca,'Yticklabels',['drum';'harp']);
xlabel(['Model Units [MU]']);
print -deps2 attackAna2B.eps
figure
barh(C)
set(gca,'Yticklabels',['drum';'harp']);
xlabel(['Model Units [MU]']);
print -deps2 attackAna2C.eps
figure
barh(D)
set(gca,'Yticklabels',['drum';'harp']);
xlabel(['Model Units [MU]']);
print -deps2 attackAna2D.eps
