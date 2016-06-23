%function plotMyIRs

pkg load signal
[y fs b] = wavread("before-1.wav");
y = y/max(abs(y));%normalize
l = length(y);
[y2 fs b] = wavread("nopaper-1.wav");
norm = max(abs(y2));
y2 = y2/norm;
l2 = length(y2);
[y3 fs b] = wavread("wpaper-1.wav");
y3 = y3/norm; % we know these last two were taken at the same gain
l3 = length(y3);
%mean(y2-y3)

%eq curve
figure(1)
hold on
plotIREQ(y,fs);
plotIREQ(y2,fs,'g');
plotIREQ(y3,fs,'r');
ylim([-20 25]);
legend('untreated','no paper', 'paper')
hold off
%print("-dpng","eq.png");

% smoothed version
figure(2)
    dec = 2;
    skip = 0;
    [ys1 x1] = fftdecimate(20*log10(abs(fft(y(:,1)))), fs, dec, skip);
    [ys2 x2] = fftdecimate(20*log10(abs(fft(y2(:,1)))), fs,dec, skip);
    [ys3 x3] = fftdecimate(20*log10(abs(fft(y3(:,1)))), fs,dec, skip);
    semilogx( x1,ys1, x2,ys2, x3,ys3);

ylim([-20 25]);
xlim([20 20000])
title('Frequency response')
xlabel('Hz')
ylabel('dB')
legend('untreated','no paper', 'paper')
grid('on')
%print("-dpng","eq_smooth.png");


%spectrogram
figure(3)
plotIRwaterfall(y,fs);
title("Before")
%print("-dpng","untreated_waterfall.png");

figure(4) 
plotIRwaterfall(y2,fs);
title("Unfaced")
%print("-dpng","nopaper_waterfall.png");

figure(5) 
plotIRwaterfall(y3,fs);
title("With Paper")
%print("-dpng","paper_waterfall.png"); 
