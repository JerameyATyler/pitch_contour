load L1_S14
A(1)=prctile(YE,99);
B(1)=std(YE);
index=find(YE>0);
YE=YE(index);
C(1)=prctile(YE,99);
D(1)=std(YE);

load L2_S14
A(2)=prctile(YE,99);
B(2)=std(YE);
index=find(YE>0);
YE=YE(index);
C(2)=prctile(YE,99);
D(2)=std(YE);

load L3_S14
A(3)=prctile(YE,99);
B(3)=std(YE);
index=find(YE>0);
YE=YE(index);
C(3)=prctile(YE,99);
D(3)=std(YE);

load L4_S14
A(4)=prctile(YE,99);
B(4)=std(YE);
index=find(YE>0);
YE=YE(index);
C(4)=prctile(YE,99);
D(4)=std(YE);

load L5_S14
A(5)=prctile(YE,99);
B(5)=std(YE);
index=find(YE>0);
YE=YE(index);
C(5)=prctile(YE,99);
D(5)=std(YE);


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
