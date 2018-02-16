load L1_S14
A(1)=prctile(YD,99);
B(1)=std(YD);
index=find(YD>0);
YD=YD(index);
C(1)=prctile(YD,99);
D(1)=std(YD);

load L2_S14
A(2)=prctile(YD,99);
B(2)=std(YD);
index=find(YD>0);
YD=YD(index);
C(2)=prctile(YD,99);
D(2)=std(YD);

load L3_S14
A(3)=prctile(YD,99);
B(3)=std(YD);
index=find(YD>0);
YD=YD(index);
C(3)=prctile(YD,99);
D(3)=std(YD);

load L4_S14
A(4)=prctile(YD,99);
B(4)=std(YD);
index=find(YD>0);
YD=YD(index);
C(4)=prctile(YD,99);
D(4)=std(YD);

load L5_S14
A(5)=prctile(YD,99);
B(5)=std(YD);
index=find(YD>0);
YD=YD(index);
C(5)=prctile(YD,99);
D(5)=std(YD);


A1=A;


clear A
clear B
clear C
clear D

load L1_S24
A(1)=prctile(YD,99);
B(1)=std(YD);
index=find(YD>0);
YD=YD(index);
C(1)=prctile(YD,99);
D(1)=std(YD);

load L2_S24
A(2)=prctile(YD,99);
B(2)=std(YD);
index=find(YD>0);
YD=YD(index);
C(2)=prctile(YD,99);
D(2)=std(YD);

load L3_S24
A(3)=prctile(YD,99);
B(3)=std(YD);
index=find(YD>0);
YD=YD(index);
C(3)=prctile(YD,99);
D(3)=std(YD);

load L4_S24
A(4)=prctile(YD,99);
B(4)=std(YD);
index=find(YD>0);
YD=YD(index);
C(4)=prctile(YD,99);
D(4)=std(YD);

load L5_S24
A(5)=prctile(YD,99);
B(5)=std(YD);
index=find(YD>0);
YD=YD(index);
C(5)=prctile(YD,99);
D(5)=std(YD);


figure
subplot(2,2,1)
barh(A1,'k')
set(gca,'Yticklabels',['L1';'L2';'L3';'L4';'L5'],'FontSize',12);
xlabel(['Attack Strength [Model Units, MU]'],'FontSize',12);
ylabel(['Room Index'],'FontSize',12);
set(gca,'LineWidth',1.5);
set(gca,'FontSize',12);
title('drums','FontSize',14);
axis([0 0.25 0.5 5.5])


subplot(2,2,3)
barh(A,'k')
title('harp','FontSize',14);
set(gca,'Yticklabels',['L1';'L2';'L3';'L4';'L5'],'FontSize',12);
xlabel(['Attack Strength [Model Units, MU]'],'FontSize',12);
ylabel(['Room Index'],'FontSize',12);
set(gca,'LineWidth',1.5);
set(gca,'FontSize',12);
axis([0 0.25 0.5 5.5])
print -deps2 AttackData.eps
