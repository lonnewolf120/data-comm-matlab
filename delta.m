clc;
clear all;
close all;

% Parameters
fs = 10000;         % Sampling frequency
fm = 100;          % Message signal frequency
t = 0:1/fs:1000/fs;     % Time vector (0.1 seconds duration)
Am = 5;             % Amplitude of the message signal
del = 0.1;          % Step size for delta modulation

% Generate message signal
x = Am * sin(2*pi*fm*t);  % Message signal with peak voltage of 5V

% Plot the message signal
figure;
plot(t, x);
hold on;
title('Message Signal');
xlabel('Time (s)');
ylabel('Amplitude (V)');

% Initialize variables for delta modulation
y = 0;              % Output DM signal (0 or 1)
strc = 0;           % Staircase approximation (integrator output)

% Delta Modulation
for i = 1:length(x)-1
    if strc(i) <= x(i)
        d = 1;
        strc(i+1) = strc(i) + del;
    else
        d = 0;
        strc(i+1) = strc(i) - del;
    end
    y = [y d];
end

% Plot the staircase approximation
stairs(t, strc);
title('Message Signal and Staircase Approximation');
legend('Message Signal', 'Staircase Approximation');
hold off;

% Mean Squared Error calculation
MSE = sum((x - strc).^2) / length(x);
disp(['Mean Squared Error (MSE): ', num2str(MSE)]);

% Plot delta modulated signal
figure;
subplot(3,1,1);
plot(t, y(1:length(t)));  % Ensure y and t are the same length
title('Delta Modulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');

% Delta Demodulation
y_demod = 0;       % Initialize demodulated signal
strc_demod = 0;    % Initialize staircase approximation for demodulation

for i = 2:length(y)
    if y(i) == 1
        strc_demod = strc_demod + del;
    else
        strc_demod = strc_demod - del;
    end
    y_demod = [y_demod strc_demod];
end

% Plot delta demodulated signal (before filtering)
subplot(3,1,2);
plot(t, y_demod(1:length(t)));  % Ensure y_demod and t are the same length
title('Delta Demodulated Signal (Before Filtering)');
xlabel('Time (s)');
ylabel('Amplitude');

% Apply Lowpass filter
filter_order = 20;
lowpass_filter = fir1(filter_order, fm/(fs/2), 'low');
filtered_demod_signal = filter(lowpass_filter, 1, y_demod);

% Plot the filtered demodulated signal
subplot(3,1,3);
plot(t, filtered_demod_signal(1:length(t)));  % Ensure filtered_demod_signal and t are the same length
title('Filtered Demodulated Signal');
xlabel('Time (s)');
ylabel('Amplitude');
