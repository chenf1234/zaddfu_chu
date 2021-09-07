function phase = cal_phase(lastphase,Q,I)
    if(I > 0 && Q >= 0)%第一象限和x正半轴
        phase = atan(Q/I);   
    elseif(I > 0 && Q < 0)%第四象限
        phase = atan(Q/I)+2*pi;  
  	elseif(I < 0)%第二象限和x负半轴和第三象限
      	phase = atan(Q/I) + pi;
  	elseif(I == 0 && Q > 0)%y轴正半轴
        phase = pi/2;
   	elseif(I == 0 && Q < 0)%y轴负半轴
      	phase = 3*pi/2;
    else
        phase = 0;
    end
       
	num=floor(lastphase/2/pi);
	phase=phase+2*num*pi;
	if(phase-lastphase<-pi)
        phase=phase+2*pi;
    elseif(phase-lastphase>pi)
        phase=phase-2*pi;
	end
     
end