clear all;
clc;

% Time parameters
fs = 1000;                % Sampling frequency (Hz)
t = linspace(0, 1, fs);   % Time vector (0 to 1 second)

% Message signal parameters
fm = 10;                  % Message signal frequency (Hz)
Am = 1;                   % Message signal amplitude
message_signal = Am * sin(2*pi*fm.*t); % Message signal

% Carrier signal parameters
fc = 100;                 % Carrier signal frequency (Hz)
Ac = 2;                   % Carrier signal amplitude
carrier_signal = Ac * sin(2*pi*fc.*t); % Carrier signal

% Perform frequency modulation (FM)
kf = 10;                  % Frequency deviation constant
modulated_signal = Ac * sin(2*pi*fc.*t + kf * message_signal);

% Plotting
figure;
subplot(3,1,1);
plot(t, message_signal);
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,2);
plot(t, carrier_signal);
title('Carrier Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(3,1,3);
plot(t, modulated_signal);
title('Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

% Demodulate the modulated signal
demodulated_signal = diff(modulated_signal) * fs / kf;

% Plotting
figure;
subplot(2,1,1);
plot(t(1:end-1), modulated_signal(1:end-1));
title('Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(t(1:end-1), demodulated_signal);
title('Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;