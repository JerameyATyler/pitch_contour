function [c,lags]=ncorr(x,y,numlags);
[c,lags]=xcorr(x,y,numlags);

if sqrt(sum(x.^2)*sum(y.^2))==0
    c=c.*0;
else
    c=c./(sqrt(sum(x.^2)*sum(y.^2)));
end % of if




