function pos_cal_2D(filename)
%2D位置计算
    disleft = cal_dis(filename,18.5e3);
    disright = cal_dis(filename,21.8e3);
    %初始距离与初始位置
    l=0.15;
    dis2speaker=0.23;
    r=sqrt(l*l+0.23*0.23);
    prev = [0,l];
    
    pos = [];
    for i = [1:length(disleft)]
        newl=l+disleft(i);
        newr=r+disright(i);
        %余弦定理，可以算出两个位置，取离上一个位置最近的位置作为当前位置
        angle=abs(acos((newl^2+dis2speaker^2-newr^2)/(2*newl*dis2speaker)));
        pos1=[newl*cos(angle),newl*sin(angle)];
        pos2=[newl*cos(-angle),newl*sin(-angle)];
        if(norm(pos1-prev)<norm(pos2-prev))
            pos = [pos;pos1];
        else
            pos = [pos;pos2];
        end
    end
    
    xpos=pos(:,1)';
    ypos=pos(:,2)';
    figure;
    plot(xpos,ypos,"r.-"); 
    axis equal;
    legend("手机2D运动轨迹");
    
end