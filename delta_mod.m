clc;
clear all;

fs = 10000;
fm = 1000;
t = 0:2*pi/100:2*pi;
Am = 5;
message = Am* sin(2*pi*fm .* t);
plot(message);
hold on;

y = 0;
strc = 0;
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
    y=[y d]
end

stairs(strc)
hold off
MSE = 
    
        
