function send_signal_create()
%周期zc发射信号构造
    
    N=83;u=41;%B=3000Hz
    L=1328;
    rightfc=21.8e3;%右扬声频率20.3kHz-23.3kHz
    leftfc=18.5e3;%左扬声器频率17kHz-20kHz
    r=zc_modul(rightfc,N,u,L);
    l=zc_modul(leftfc,N,u,L);
    n=fix(50/(length(l)/48000));%50s的信号
    rzc=[];
    lzc=[];
    
    for i=[1:n]
       rzc=[rzc,r];
       lzc=[lzc,l];
    end
    y=[lzc',rzc'];
    audiowrite("zc1.wav",y,48e3);
end