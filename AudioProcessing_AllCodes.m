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

%% Add Noise to Signal And Filter it
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

%% Add Echo to Signal
delay = 0.2;
amp = 0.5;
% Find the time between points using Fs
dt = 1/Fs;
% Calculate the number of points for the given delay
N = round(delay/dt);
% Pad the original signal with zeros to make room for the echo
s1 = [Or_sig; zeros(N, 1)];
% Create an echo signal that starts with 0's
s2 = [zeros(N, 1); Or_sig.*amp];
% Add the echo to the original signal
output = s1 + s2;
% the abs of all values must be < 1. Rescale if necessary
if max(abs(output)) > 1
    output = output./max(abs(output));
end
echo_signal(:,1) = output(:,1);
sound(echo_signal,Fs)
pause(time)         % Wait For Sound To Finish
figure
plot(t,echo_signal(1:length(t),1))
title('Echo signal');
xlabel('Time')
ylabel('Amplitude')