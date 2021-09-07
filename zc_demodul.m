function res = zc_demodul(y,fc,fs,L)
    t=[0:L-1];
    
    realPart=2*y.*cos(2*pi*fc*t/fs);
    %realPart=lowpass(realPart,fc/100,fs);%无需低通滤波
    
    imagePart=2*y.*(-sin(2*pi*fc*t/fs));
    %imagePart=lowpass(imagePart,fc/100,fs);
    
    res=realPart+j*imagePart;
end