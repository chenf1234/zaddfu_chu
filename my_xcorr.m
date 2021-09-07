function [c,lags]=my_xcorr(a,b)
    c=[];
    lags=[];
    left=length(a)-1;
    right=min(length(a)-1,length(b));
    maxlen=max(length(a),length(b));
    a=[zeros(1,maxlen),a];
    b=[zeros(1,maxlen),b];
    if(length(a)<length(b))
        a=[a,zeros(1,length(b)-length(a))];
    elseif(length(a)>length(b))
        b=[b,zeros(1,length(a)-length(b))];
    end
        
    for i=[0-left:0+right]
       lags=[lags,i];
       tmpb=conj(b);
       if(i<0)
           
           tmpa=[a(end+i+1:end),a(1:end+i)];
       else
           tmpa=[a(i+1:end),a(1:i)];
       end
       c=[c,sum(tmpa.*tmpb)];
    end
end