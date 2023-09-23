clc
close all
clear all
%% Add Noise to Signal And Filter it
filename = 'Myvoice.mp4'; %define filename
[Or_sig,Fs]=audioread(filename); %read file
time=(1/Fs)*length(Or_sig);   %calculate time of signal
t=linspace(0,time,length(Or_sig)); %define t for ploting signal in time
%Noisy_sig=awgn(Or_sig,1,'measured'); % add white noise to signsl
F = 4000; % Sine wave frequency (hertz)
data = sin(2*pi*F*t);
Noisy_sig = data'+Or_sig;
sound(Noisy_sig,Fs) %play sound
pause(time)

fc= 1500;        % Hz cutoff freq
fs= Fs;       % Hz sample freq
[b,a] = butter(12,fc/(fs/2));
Filt_sig = filter (b, a, Noisy_sig);
figure
subplot(2,1,1)
plot(t,Noisy_sig)
title('Noisy Signal')
xlabel('Time')
ylabel('Amplitude')
subplot(2,1,2)
plot(t,Filt_sig)
title('Filtered Signal')
xlabel('Time')
ylabel('Amplitude')
sound (Filt_sig, Fs), pause(5)