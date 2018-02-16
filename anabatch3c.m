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


figure
barh(A)
set(gca,'Yticklabels',['L1_S1';'L2_S1';'L3_S1';'L4_S1';'L5_S1']);
xlabel(['Model Units [MU]']);
print -deps2 attackAnaAc.eps
figure
barh(B)
set(gca,'Yticklabels',['L1_S1';'L2_S1';'L3_S1';'L4_S1';'L5_S1']);
xlabel(['Model Units [MU]']);
print -deps2 attackAnaBc.eps
figure
barh(C)
set(gca,'Yticklabels',['L1_S1';'L2_S1';'L3_S1';'L4_S1';'L5_S1']);
xlabel(['Model Units [MU]']);
print -deps2 attackAnaCc.eps
figure
barh(D)
set(gca,'Yticklabels',['L1_S1';'L2_S1';'L3_S1';'L4_S1';'L5_S1']);
xlabel(['Model Units [MU]']);
print -deps2 attackAnaDc.eps
