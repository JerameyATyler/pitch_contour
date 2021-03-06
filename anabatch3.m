load sax4
A(1)=prctile(YD,99);
B(1)=std(YD);
index=find(YD>0);
YD=YD(index);
C(1)=prctile(YD,99);
D(1)=std(YD);

load violin4
A(2)=prctile(YD,99);
B(2)=std(YD);
index=find(YD>0);
YD=YD(index);
C(2)=prctile(YD,99);
D(2)=std(YD);

load theremin4
A(3)=prctile(YD,99);
B(3)=std(YD);
index=find(YD>0);
YD=YD(index);
C(3)=prctile(YD,99);
D(3)=std(YD);

load voice4
A(4)=prctile(YD,99);
B(4)=std(YD);
index=find(YD>0);
YD=YD(index);
C(4)=prctile(YD,99);
D(4)=std(YD);

load snare4
A(5)=prctile(YD,99);
B(5)=std(YD);
index=find(YD>0);
YD=YD(index);
C(5)=prctile(YD,99);
D(5)=std(YD);

load djembe4
A(6)=prctile(YD,99);
B(6)=std(YD);
index=find(YD>0);
YD=YD(index);
C(6)=prctile(YD,99);
D(6)=std(YD);

figure
barh(A)
set(gca,'Yticklabels',['     Sax';'Theremin';'  Violin';'   Voice';'   Snare';'  Djembe']);
xlabel(['Model Units [MU]']);
print -deps2 attackAnaA.eps
figure
barh(B)
set(gca,'Yticklabels',['     Sax';'Theremin';'  Violin';'   Voice';'   Snare';'  Djembe']);
xlabel(['Model Units [MU]']);
print -deps2 attackAnaB.eps
figure
barh(C)
set(gca,'Yticklabels',['     Sax';'Theremin';'  Violin';'   Voice';'   Snare';'  Djembe']);
xlabel(['Model Units [MU]']);
print -deps2 attackAnaC.eps
figure
barh(D)
set(gca,'Yticklabels',['     Sax';'Theremin';'  Violin';'   Voice';'   Snare';'  Djembe']);
xlabel(['Model Units [MU]']);
print -deps2 attackAnaD.eps
