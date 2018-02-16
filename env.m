    y(n,:)=calc_env(y(n,:),frequencies(n,1),Fs,'m2');
     [p,s]=polyfit(t,y(n,:),20);
     p=polyder(p);
     z(n,:)=polyval(p,t,s);