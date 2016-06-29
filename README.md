a bunch of convenience functions for plotting IRs in GNU octave. I do this often enough that I finally made something semi-official

look at plotmyIRs.m for an example of useage for comparing multiple files. The IR measurements I used for this script are included so you can run plotMyIRs.

* plotIREQ makes a plot of the magnitude of the frequency response
* plotIRwaterfall makes a plot of the time behavior in the lower region (you can easily make it show any region)
* fftdecimate - mostly used internally, approximately downsamples per decade so that you can make cleaner plots on a semilog scale

![screenshot](https://raw.githubusercontent.com/ssj71/octaveIRplots/master/eq_smooth.png "example of smoothed IR EQ plots")
![screenshot](https://raw.githubusercontent.com/ssj71/octaveIRplots/master/paper_waterfall.png "example of waterfall plot")

There's a decent chance of a calulation error in here so no warranty offered or implied. 
