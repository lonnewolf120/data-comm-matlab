clc;
clear all;

fs = 1000;
t = linspace(0,1,1000);

% message signal
Am = 1;
fm = 10;
Wm = 2*pi*fm .* t;
message_signal = Am * cos(Wm);

% carrier signal
Ac = 1;
fc = 100;
Wc = 2*pi*fc .* t;
carrier_signal = Ac * sin(Wc);

% modulated signal
kf = 20;  %modulation index
modulated_signal = sin(Wc + kf .* sin(Wm)); 

% demodulation
% at first we differentiate to convert fm signal to am signal
am_signal = diff(modulated_signal);
rectified_signal = abs(am_signal);

%demod param
order = 15;
cutoff_freq = 20; %bigger than fm
nyquist_freq = fs/2;
normalized_cutoff_freq = cutoff_freq/nyquist_freq;
[b,a] = butter(order, normalized_cutoff_freq, 'low');

filtered_signal = filter(b,a, rectified_signal);
filtered_signal = 10 .* filtered_signal ;
% Adjust the time vector for the differentiated signal
%t_diff = t(1:end-1);

subplot(4,1,1)
plot(t,message_signal)
xlabel('Time');
ylabel('Message Signal');
grid on

subplot(4,1,2)
plot(t,carrier_signal)
xlabel('Time');
ylabel('Carrier Signal');
grid on

subplot(4,1,3)
plot(t,modulated_signal)
xlabel('Time');
ylabel('Modulated Signal');
grid on

subplot(4,1,4)
plot(filtered_signal)
xlabel('Time');
ylabel('Demodulated Signal');
grid on
