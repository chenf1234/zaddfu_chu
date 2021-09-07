function ys=zc_modul(fc,N,u,L)
%对zc序列进行调制，构造zc发射信号
%载波频率fc是构造的zc发射信号的中心频率
   % N=83;u=41;%B=3000Hz
   % L=1328;
    zcnew=zc_interpolation(N,u,L);
    t=[0:L-1];
    fs=48e3;
    ys=real(zcnew).*cos(2*pi*t*fc/fs)-imag(zcnew).*sin(2*pi*t*fc/fs);
end