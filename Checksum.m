clc;
clear;

% Example data
data = [7 11 12 0 6 5 4 4 1 5];

% Calculate the checksum
cs = sum(data);
csBin = dec2bin(cs);

% Calculate main and wrap parts
len = length(csBin);
mainBin = csBin(max(len-3, 1):len); 
wrapBin = csBin(1:max(len-4, 0));

mainDec = bin2dec(mainBin);
wrapDec = bin2dec(['0', wrapBin]); % Ensure wrapBin is not empty
wrappedSum = dec2bin(mainDec + wrapDec, 4);

% Calculate checksum
checksum = '';
for i = 1:4
    if wrappedSum(i) == '1'
        checksum = [checksum, '0'];
    else
        checksum = [checksum, '1'];
    end
end
checksumDec = bin2dec(checksum);

% Display results
disp(['Main Bin: ', mainBin]);
disp(['Wrap Bin: ', wrapBin]);
disp(['Wrapped Sum: ', wrappedSum]);
disp(['Checksum: ', checksum]);
disp(['Checksum Decimal: ', num2str(checksumDec)]);