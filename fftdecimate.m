%fftdecimate.m %spencer jackson %this takes fft data and returns a smoother version for plotting. Smoothing makes N points per decade (default of 64) 
%data fft data
%fs sample rate of source
%dec decimation amount per decade ((first decade is untouched)
function [y x] = fftdecimate(data, fs, dec, skip=0) 
    l = length(data);
    ndec = log10(fs/2); %number of decades
    logdex = round(logspace(0,log10(fs/2),ndec));
    jump = logdex(2); %move this much for a decade
    i = logdex(2+skip);
    y = data(1:l/2);
    x = fs/l:fs/l:fs/2;
    while i+jump<=length(y)
        y = [y(1:i-1); decimate(y(i:end),dec)]; 
        x = [x(1:i-1) x(i:dec:end)];
        i += jump;
    end 
end
