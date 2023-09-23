clc
close all
clear all

%% Add Echo to Signal
filename = 'Myvoice.mp4'; %define filename
[Or_sig,Fs]=audioread(filename); %read file
time=(1/Fs)*length(Or_sig);   %calculate time of signal
t=linspace(0,time,length(Or_sig)); %define t for ploting signal in time
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