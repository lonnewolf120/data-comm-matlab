clc;
clear all;

%{
1. Modulation:
The code generates a message signal and modulates it.

2. Mean Squared Error (MSE):
Calculates the mean squared error between the original message and the reconstructed signal.

3. Demodulation:
Reconstructs the signal from the modulated data.

4.Lowpass Filtering:
Applies a lowpass filter to the demodulated signal to smooth it.

5. Error Signal:
Calculates the error signal as the difference between the original message and the filtered demodulated signal.
Plots the original message, modulated signal, demodulated signal, and error signal.

%}

fs = 10000;
fm = 1000;
t = 0:2*pi/100:2*pi;
Am = 5;
message = Am* sin(2*pi*fm * t);
%plot(message);
%hold on;

y = [0];
strc = [0];
del = 0.1;

% Demodulate

for i=1:length(message)-1
    if message(i) >= strc(i)
        d=1;
        strc(i+1) = strc(i)+del;
    else
        d=0;
        strc(i+1)=strc(i)-del;
    end
    y=[y d];
end

stairs(t,strc);  % display the staircase approx. figure
hold off
MSE = sum((message-strc) .^ 2)/length(message);
disp(['Mean Squared Error: ',num2str(MSE)]);

y_demod = [0];
strc_demod = [0];

% demodulation
for i=2:length(y)
    if y(i) == 1
        strc_demod = strc_demod+del;
    else
        strc_demod = strc_demod-del;
    end
    y_demod = [y_demod strc_demod];
end

% apply lowpass filter
order = 20;
lowpass_filter = fir1(order, fm/(fs/2), 'low');
filtered_signal = filter(lowpass_filter, 1, y_demod);

% Calculate error signal
error_signal = message - filtered_signal(1:length(message));
%{
To plot the error signal, you need to calculate the difference between 
the original message and the filtered signal (which should be the demodulated signal after filtering
%}

% Plot results
%figure;
subplot(4,1,1);
plot(t, message);
title('Message');

subplot(4,1,2);
stairs(t, strc);
title('Modulated signal');

subplot(4,1,3);
plot(t, filtered_signal(1:length(t)));
title('Demodulated signal');

subplot(4,1,4);
plot(t, error_signal);
title('Error signal');

