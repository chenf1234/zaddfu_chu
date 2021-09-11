function dis = cal_dis(filename,fc)
    %基本参数
    N = 83;u = 41;
    L = 1328;%一个segment的长度
    c = 340;%声速
    B = 3e3;%带宽
    
    %插值后的zc序列
    zcnew = zc_interpolation(N,u,L);
    
    %读取下麦克风的数据，然后带通滤波过滤掉无关频率
    [data,fs] = audioread(filename);
    data = data(:,1)';
    %data=bandpass(data,[fc-B/2 fc+B/2],fs);
    data = firbandpass(fc-B/2,fc+B/2,data,fs);
    data = data(2*L+1:end);
    
    %测距
    N = length(data);
    dis_coarse = [];%粗粒度距离
    dis_fine = [];%细粒度距离
    phase = [];%相位
    lastphase = 0;
    for i = [1:L:N]
        if(i+L > N)
            break
        end
        tmp=data(i:i+L-1);%用一个周期的数据运算
        tmp=zc_demodul(tmp,fc,fs,L);%接收信号解调
        h=ifft(fft(conj(flip(tmp))).*fft(zcnew));%循环卷积
        [val,pos]= max(abs(h));
        val=h(pos);
        %粗粒度测距
        dis_coarse = [dis_coarse,pos*c/fs];
        
        %细粒度测距
        Q=imag(val);
        I=real(val);
        curphase = cal_phase(lastphase,Q,I);
        phase = [phase,curphase];
        lastphase = curphase;
        
    end
    dis_coarse=outlier_remove(dis_coarse,0.02);
    
    for i = [1:length(phase)]
        dis_fine=[dis_fine,(phase(i)-phase(1))*c/(2*pi*fc)];
    end
    dis_fine=outlier_remove(dis_fine,0.02);
    figure;plot(dis_coarse,"b-");ylabel("distance(m)");title("粗粒度测距结果");
    figure;plot(dis_fine,"r-");ylabel("distance(m)");title("细粒度测距结果");
    dis = dis_fine;
end