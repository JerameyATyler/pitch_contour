%{
inputF = fopen('bytes/bytes.txt', 'r');
content = fread(inputF);
content;
fclose(inputF);

btext = fileread('bytes/bytes.txt');
bbtext = unicode2native(btext);

Fs = bbtext(25:28);
Fs = typecast(Fs, 'uint32')

channel = bbtext(23:24);
channel = typecast(channel, 'uint16');
channel;

data = bbtext(45:end);
data = typecast(data, 'int16');
length(data)

index = 1:(length(data)/channel);

monodata = data(index)
filename = 'recover.wav';
audiowrite(filename, monodata, Fs);

[y, Fs] = audioread(filename);
y;
sound(y, Fs);
%}

% Native speaker
file = 'words/0013m1.wav';
[y, Fs] = audioread(file);
[nF, t] = toPitchContour(y, Fs);
[json] = WriteIntoJSON('??', t, nF, 'toUnity3.txt');

%{
y = {};
for n = 1:channel
    y(n) = data(index + (n-1));
end

y
%}

%{
outputF = fopen('bytes/bytes.wav', 'w');
fwrite(outputF, content);
fclose(outputF);
%}

%{
test = [nan, 212, 2, nan, 42, 34, 767, nan, nan, nan, 565];
testy = 1:11;
index = find(isnan(test))

xs = {};
ys = {};

i = 1;
for n=1:length(index)
    if  n==length(index) 
        if index(n)~=length(test)
            % index(n)+1 to test.end
            keep = index(n)+1 : length(test);
            xs{i} = test(keep);
            ys{i} = testy(keep);
            i = i+1;
        end
    else 
        if index(n+1)~=(index(n)+1)
            keep = index(n)+1 : index(n+1)-1;
            xs{i} = test(keep);
            ys{i} = testy(keep);
            i = i+1;
        end
    end
end

s = length(xs)
s(1)
xs
xs'
xs{1}'
xs{2}'
xs{3}'
table(xs, ys)
%}

%{
% Start recording
prevY = [];
prevF = [];
prevT = [];

outF = [];
outT = [];

myFigure = figure('name', 'record');
Fs = 44100;
recObj = audiorecorder(44100, 8, 1);
recObj.StartFcn = 'disp(''Start speaking.'');';
recObj.StopFcn = 'disp(''End of recording.''); figure(myFigure); y = getaudiodata(recObj); [nF, t] = toPitchContour(y, Fs); outF = nF; outT = t; subplot(2,1,2); plot(t, nF); xlim([1/Fs,length(y)/Fs]);';
%recObj.StopFcn = 'disp(''End of recording.'');';
recObj.TimerPeriod = 0.2;
recObj.TimerFcn = 'y = getaudiodata(recObj); t = [1: length(y)]./Fs; subplot(2,1,1); plot(t, y); xlim([t(1),t(end)]); ylim([-1,1]); ';
%recObj.TimerFcn = 'y = getaudiodata(recObj); tmpY = y(length(prevY)+1 : end); prevY = y; yt = [1: length(y)]./Fs; subplot(2,1,1); plot(yt, y); xlim([yt(1),yt(end)]); ylim([-1,1]); [nF, t] = toPitchContour(tmpY, Fs); prevT = appendTime(prevT, t); prevF = [prevF, nF]; subplot(2,1,2); plot(prevT, prevF); xlim([yt(1),yt(end)]); ';
record(recObj);

command = 'node transcribe.js';
[status, cmdout] = system(command);

stop(recObj);
fname = 'output.json';
fid = fopen(fname, 'r', 'n', 'UTF-8');
raw = fread(fid, 'char');
str = char(raw');
str
fclose(fid);

data = JSON.parse(str);
text = data.result.alternatives{1}.transcript;
text
length(text);

%{
% Write data into JSON
length(outT)
length(outF)

x = outT';
y = outF';

word = struct('Word', text);
points = struct('Points', table(x, y));
Live = {word, points};
%json = jsonencode(table(Live));
json = jsonencode(struct('Live', Live));
json
%}

[json] = WriteIntoJSON(text, outT, outF, 'toUnity.txt');
%}