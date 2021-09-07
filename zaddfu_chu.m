function zc=zaddfu_chu(N,u)
%原始zc序列
    if gcd(N,u) ~=1
        %N与u必须要互为质数
        error("ZC sequence length N and parameter u should be relative prime. %d and %d are not relative prime",N,u);
    else
        n=[0:N-1];
        q=0;
        zc=exp(-1j*(pi*u*n.*(n+1+2*q)/N));
        %figure;
        %subplot(2,1,1);
        %plot(real(zc));title("原始zc序列实部");
        %subplot(2,1,2);
        %plot(imag(zc));title("原始zc序列虚部");
        
        %cyclic_h=fftshift(ifft(fft(flip(conj(zc))).*fft(zc)));%循环自相关
        %figure;subplot(2,1,1);plot(abs(cyclic_h));title("原始zc序列循环自相关结果");
        %[corr_h,lags]=xcorr(zc,zc);
        %subplot(2,1,2);plot(lags,abs(corr_h));title("原始zc序列自相关结果");
        
    end
    
end