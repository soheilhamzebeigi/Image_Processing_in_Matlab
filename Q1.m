clc
close all
clear all
%% Read And Play
filename = 'Myvoice.mp4'; %define filename
[Or_sig,Fs]=audioread(filename); %read file
time=(1/Fs)*length(Or_sig);   %calculate time of signal
t=linspace(0,time,length(Or_sig)); %define t for ploting signal in time
figure
plot(t,Or_sig)
title('Original signal');
xlabel('Time')
ylabel('Amplitude')
sound(Or_sig,Fs) %playing sound
pause(time)

%% plot the signal histogram
figure
hHist = histogram(Or_sig,100);
xlabel('Amplitude')
ylabel('Number of samples')
title('Histogram of the signal')