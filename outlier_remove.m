function res=outlier_remove(y,threshold)
%阈值法移除离群值
    res=[y(1)];
    for i=2:length(y)
       if(abs(y(i)-res(i-1))>threshold)
           res=[res,res(i-1)];
       else
           res=[res,y(i)];
       end
    end
end