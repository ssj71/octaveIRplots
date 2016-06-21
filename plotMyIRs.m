%function plotMyIRs

pkg load signal
[y fs b] = wavread("before-1.wav");
y = y/mean(abs(y));%normalize
l = length(y);
[y2 fs b] = wavread("nopaper-1.wav");
norm = mean(abs(y2));
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
legend('untreated','no paper', 'paper')
hold off


if(0)
%if(~dec)
    semilogx( fs/l:fs/l:fs/2, 20*log10(abs(fft(y(:,1)))(1:ceil(l/2))),
         fs/l2:fs/l2:fs/2, 20*log10(abs(fft(y2(:,1)))(1:ceil(l2/2))),
         fs/l3:fs/l3:fs/2, 20*log10(abs(fft(y3(:,1)))(1:ceil(l3/2)))
        )
xlim([20 20000])
title('Frequency response')
xlabel('Hz')
ylabel('dB')
legend('untreated','no paper', 'paper')
grid('on')
end

% smoothed version
figure(2)
    dec = 2;
    skip = 0;
    [ys1 x1] = fftdecimate(20*log10(abs(fft(y(:,1)))), fs, dec, skip);
    [ys2 x2] = fftdecimate(20*log10(abs(fft(y2(:,1)))), fs,dec, skip);
    [ys3 x3] = fftdecimate(20*log10(abs(fft(y3(:,1)))), fs,dec, skip);
    semilogx( x1,ys1, x2,ys2, x3,ys3);

xlim([20 20000])
title('Frequency response')
xlabel('Hz')
ylabel('dB')
legend('untreated','no paper', 'paper')
grid('on')


%spectrogram
figure(3)
clf
specgram(y(:,1),256,fs,hanning(256),256-32)
title('Spectrogram')


%waterfall plot
%this plot is tuned for looking at room responses for resonances
%figure(3)
windowlen = 500;%ms
rise = 100;%ms
slices = 101;

%y = y2;
nfft = 2^ceil(log2(windowlen/1000*fs));
lhs = rise/1000*fs;%samples of hanning rise time
win = [hanning(2*lhs)(1:lhs); tukeywin(nfft,.25)(lhs+1:end)];%window has hanning rise and rest is .25 tukey
step = 2^floor(log2(length(y)/slices));%time size of each slice of spectra
overlap = nfft - step;
[S, f, t] = specgram (y(:,1), nfft, fs, win,  overlap);%nfft - nfft/8);
ff = f' * ones (1, length (t));
tt = ones (length (f), 1) * t;
Sdb = 20*log10(abs(S'));
%TODO: may want to smooth it a bit 
srf = waterfall (tt', ff'+.1, Sdb);%a minor offset is added to avoid 0 values on the log scale
ax = get(srf,'parent');
set(ax,'yscale','log');
view([100,15,15])
grid('on')
shading('faceted')
ylim([10 200])
zmx = max(max(Sdb));
zlim([zmx-60 1.1*zmx])
xlabel('sec')
ylabel('Hz')
zlabel('dB')
colormap('jet')


figure(1)


