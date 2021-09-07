function [c,lags]=my_xcorr_v2(a,b)
    tmpb=[conj(flip(b))];
    c=conv(a,tmpb);
    left=length(a)-1;
    right=min(length(b),left);
    lags=[-left:1:right];
    
end