function [ output_dir ] = Binary2WavFile( binary )
% Convert binary data into wav file and return file dir
%   Detailed explanation goes here

Fs = binary(25:28);
Fs = typecast(Fs, 'uint32')

channel = binary(23:24);
channel = typecast(channel, 'uint16')

%chunck2Size = binary(41:44);
%chunck2Size = typecast(chunck2Size, 'int32');

data = binary(45:end);
data = typecast(data, 'int16');
length(data);

indexBase = 1:(length(data)/channel);

rIndex = indexBase * channel;

monodata = data(rIndex);
filename = 'recover.wav';

audiowrite(filename, monodata, Fs);

[y, Fs] = audioread(filename);
sound(y, Fs);

output_dir = filename;
end