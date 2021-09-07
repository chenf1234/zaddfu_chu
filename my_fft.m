function [freq,amplitude]=my_fft(y,fs)
    x=fft(y);%对声音信号进行快速傅里叶变换
    N=length(y);
    x=x/N;%幅值修正
    f1=[0:(fs/N):fs/2-fs/N];%转换横坐标以Hz为单位
    x=x(1:length(f1));%选取前半部分，因为fft之后为对称的双边谱
    x(2:end)=2*x(2:end);
    amplitude=x;
    freq=f1;
end