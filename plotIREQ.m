%function plotIREQ(data, fs, dec)
%dec is decimation amount roughly
%this will just plot the magnatude of a bode plot

function plotIREQ(data, fs, c='b')

l = length(data); 
%eq curve
semilogx( fs/l:fs/l:fs/2, 20*log10(abs(fft(data(:,1)))(1:ceil(l/2))),c)
xlim([20 20000])
title('Frequency response')
xlabel('Hz')
ylabel('dB')
grid('on')
end
