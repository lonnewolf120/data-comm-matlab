clc;
clear all;
close all;

fm=2000;
fc = 5000;
fs = 200000;
mi=2; % modulation index
t = (0:1/fs:0.01);
%t=0:0.001:0.1;

m=sin(2*pi*fm*t); % message signal

c=sin(2*pi*fc*t); % carrier signal

% modulated signal, Frequency changing w.r.t Message
y=sin(2*pi*fc*t+(mi.*sin(2*pi*fm*t))); 

% Demodulation
y=diff(y); %convert FM to AM
y=abs(y);  %rectification
[b,a]=butter(1,0.005);
z=filter(b,a,y);
z=10.*z;

subplot(4,1,1);
plot(t,m);
xlabel('Time');
ylabel('Amplitude');
title('Message Signal');
grid on;
subplot(4,1,2);
plot(t,c);
xlabel('Time');
ylabel('Amplitude');
title('Carrier Signal');
grid on;
subplot(4,1,3);
plot(t,y);
xlabel('Time');
ylabel('Amplitude');
title('FM Signal');
grid on;
subplot(4,1,4);
plot(z);
xlabel('Time');
ylabel('Amplitude');
title('FM demodulation Signal');
grid on;