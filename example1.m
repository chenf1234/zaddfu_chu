%%一个zc测距的例子，帮助更好的理解利用zc序列测距原理

%构造zc发射信号
N=83;u=41;B=3000;%基本参数
fc=20e3;%载波频率
L=1328;%一个segment的长度
fs=48e3;
ys=zc_modul(fc,N,u,L);%发射信号
ys_zc=zc_interpolation(N,u,L);

%模拟接收的zc信号，接收的zc信号为具有不同延迟的传输信号的多个副本的叠加
%根据真实情况，延迟小的早于延迟大的发射，两者同时被接收到，因此，延迟越小的传播路径越长，经过的反射次数越多，振幅也就越小
yr_copy1=0.15*[ys,ys];yr_copy1=[yr_copy1(101:end),yr_copy1(1:100)];%接收到的第一个多径副本，延迟100个采样点
yr_copy2=0.28*[ys,ys];yr_copy2=[yr_copy2(301:end),yr_copy2(1:300)];%接收到的第二个多径副本，延迟300个采样点
yr_copy3=0.35*[ys,ys];yr_copy3=[yr_copy3(701:end),yr_copy3(1:700)];%接收到的第三个多径副本，延迟700个采样点
yr_copy4=0.40*[ys,ys];yr_copy4=[yr_copy4(1001:end),yr_copy4(1:1000)];%接收到的第四个多径副本，延迟1000个采样点
yr_copy5=0.05*[ys,ys];%无延迟副本

%接收的zc信号,由5个不同延迟的传输信号副本构成
yr=yr_copy1+yr_copy2+yr_copy3+yr_copy4+yr_copy5;
yr_seg1=yr(1:L);
yr_seg1=zc_demodul(yr_seg1,fc,fs,L);

%与yr_copyX对应的原始zc序列
yr_zc_copy1=0.15*[ys_zc,ys_zc];yr_zc_copy1=[yr_zc_copy1(101:end),yr_zc_copy1(1:100)];
yr_zc_copy2=0.28*[ys_zc,ys_zc];yr_zc_copy2=[yr_zc_copy2(301:end),yr_zc_copy2(1:300)];
yr_zc_copy3=0.35*[ys_zc,ys_zc];yr_zc_copy3=[yr_zc_copy3(701:end),yr_zc_copy3(1:700)];
yr_zc_copy4=0.40*[ys_zc,ys_zc];yr_zc_copy4=[yr_zc_copy4(1001:end),yr_zc_copy4(1:1000)];
yr_zc_copy5=0.05*[ys_zc,ys_zc];

yr_zc=yr_zc_copy1 + yr_zc_copy2 + yr_zc_copy3 + yr_zc_copy4 + yr_zc_copy5;
yr_zc_seg1=yr_zc(1:L);

h1=ifft(fft(conj(flip(yr_seg1))).*fft(ys_zc));
h2=ifft(fft(conj(flip(yr_zc_seg1))).*fft(ys_zc));

figure;
subplot(2,1,1);plot(abs(h1));title("接收信号解调后与发射zc序列循环自相关结果");
subplot(2,1,2);plot(abs(h2));title("预期的解调zc接收序列与发射zc序列循环自相关结果");