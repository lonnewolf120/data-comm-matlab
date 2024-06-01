clc;
clear all;

fs = 1000;
t = linspace(0,1,1000);

% message signal
Am = 1;
fm = 10;
message_signal = Am * sin(2*pi*fm .* t);

% carrier signal
Ac = 2;
fc = 100;
carrier_signal = Ac * sin(2*pi*fc .* t);

% modulated signal
modulated_signal = (1+message_signal) .* carrier_signal;

% rectification
rectified_signal = abs(modulated_signal);

%lowpass filter param
cutoff_freq = 20;
% demod
order = 4;
nyquist_freq = fs/2;
normalized_cutoff_freq = cutoff_freq/nyquist_freq;
[b,a] = butter(order, normalized_cutoff_freq, 'low');

filtered_signal = filter(b,a, rectified_signal);


subplot(5,1,1)
plot(t,message_signal)
xlabel('Message Signal');
ylabel('Time');
grid on
subplot(5,1,2)
plot(t,carrier_signal)
xlabel('Carrier Signal');
ylabel('Time');
grid on
subplot(5,1,3)
plot(t,modulated_signal)
xlabel('Modulated Signal');
ylabel('Time');
grid on
subplot(5,1,4)
plot(t,rectified_signal)
xlabel('Rectified Signal');
ylabel('Time');
grid on
subplot(5,1,5)
plot(t,filtered_signal)
xlabel('Demodulated Signal');
ylabel('Time');
grid on
