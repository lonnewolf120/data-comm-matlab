clc;
clear all;
close all;

fs = 10000;
fm = 1000;

t = 0:1/fs:1000/fs;  % Time Duration = 1000/10000 = 0.1s
% Am = 5
x = 5*sin(2*pi*fm*t); % Define message signal with peak voltage 5V

plot(t,x);
hold on

y=0; % output DM signal i.e stream 0 to 1
strc=0; % Ourput of integrater i.e Staircase approx. 
del=0.1; % Stepsize

for i = 1:length(x)-1
    if strc(i) <= x(i)
        d=1;
        strc(i+1) = strc(i)+del;
    else
        d=0;
        strc(i+1) = strc(i)-del;
    end
    y = [y d];
end

stairs(t,strc); %Show the staircase approx. signal
title('Staircase Approx.')
hold off 

MSE = sum((x-strc).^2) / length(x); % Mean Squared Error (MSE)
disp(['Mean Squared Error (MSE) :', num2str(MSE)]);

figure;

% Delta Modulation
subplot(3,1,1);
plot(t,y);  % Show the staircase approximated signal
title('Delta Modulated Signal');


% Delta Demodulation
y_demod = [0];
strc_demod = 0;

for i = 2:length(y)
    if y(i)==1
        strc_demod = strc_demod + del;
    else
        strc_demod = strc_demod - del;
    end 
    y_demod = [y_demod strc_demod];
end
subplot(3,1,2);
plot(t,y_demod);
title('Delta Demodulated Signal (Before Filtering)');

% Apply Low pass filter

filter_order = 20;
lowpass_filter = fir1(filter_order, fm/(fs/2),'low');
filtered_demod_signal = filter(lowpass_filter, 1, y_demod);

% Plot the filtered demodulated signal
subplot(3,1,3);
plot(t,filtered_demod_signal);
title('Filtered Demodulated Signal'); 