function [X]=OLAsplit(x,windowlength)

% function [X]=OLAsplit(x,windowlength)
%
% Jonas Braasch, RPI (c) 2010

if size(x(:,1))<size(x(1,:))
    x=x';
end % of if 

if size(x(:,1))>1
    x=x(:,1);
    disp('Warning: input file cut to 1D');
end % of if 

stepsize=floor(windowlength./2);
windowlength=stepsize*2;
numOfSteps=ceil(length(x)./stepsize)+2;
newLength=stepsize*numOfSteps;
y=zeros(newLength,1); % add zeros to make filelength 
y(1+stepsize:length(x)+stepsize)=x;
X=zeros(windowlength,numOfSteps-1);
%h = waitbar(0,'Please wait...');
for n=1:numOfSteps-1
    X(:,n)=y(1+(n-1).*stepsize:(n+1).*stepsize).*cossquare(windowlength);
    %waitbar(n/(numOfSteps-1),h)
end % of for 
%close(h)