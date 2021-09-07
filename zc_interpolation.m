function zcnew=zc_interpolation(N,u,L)
%对原始zc序列插值后的结果,L为插值后的长度
    %N和u为zc序列的参数
    zc=zaddfu_chu(N,u);
    
    fs=48e3;%采样率
    
    %频域插值
    zcfft=fft(zc);
    if(mod(N,2)==1)
        
        zcnew=[zcfft(1:(N+1)/2),zeros(1,L-N),zcfft((N+1)/2+1:end)];
    else 
        zcnew=[zcfft(1:N/2),zeros(1,L-N),zcfft(N/2+1:end)];
    end
    zcnew=ifft(zcnew);
    %figure;
    %subplot(2,1,1);
    %plot(real(zcnew));title("插值后的zc序列实部");
    %subplot(2,1,2);
    %plot(imag(zcnew));title("插值后的zc序虚部");
    
    %cyclic_h=fftshift(ifft(fft(flip(conj(zcnew))).*fft(zcnew)));%循环自相关
    %figure;subplot(2,1,1);plot(abs(cyclic_h));title("原始zc序列循环自相关结果");
    %[corr_h,lags]=xcorr(zcnew,zcnew);
    %subplot(2,1,2);plot(lags,abs(corr_h));title("原始zc序列自相关结果");
    
end