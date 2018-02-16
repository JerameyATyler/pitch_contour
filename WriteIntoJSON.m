function [ json ] = WriteIntoJSON( text, t, f, outputFile )
%WriteIntoJSON Summary of this function goes here
%   Convert input data to specific JSON format

% Write data into JSON
length(t)
length(f)

x = t;
y = f;

%sub-group x and y depends on NaN
index = find(isnan(y))
length(y)

xs = {};
ys = {};

i = 1;
for n=1:length(index)
    if n==1 && index(n) ~= 1
        keep = 1 : index(n)-1;
        xs{i} = x(keep);
        ys{i} = y(keep);
        i = i+1;
    end
    if  n==length(index) 
        if index(n)~=length(y)
            % index(n)+1 to test.end
            keep = index(n)+1 : length(y);
            xs{i} = x(keep);
            ys{i} = y(keep);
            i = i+1;
        end
    else
        if index(n+1)~=(index(n)+1)
            keep = index(n)+1 : index(n+1)-1;
            xs{i} = x(keep);
            ys{i} = y(keep);
            i = i+1;
        end
    end
end
i
xs
%y(isnan(y)) = -200;

text1 = text(find(~isspace(text)));
%word = struct('Word', text1);
Points = {};

for n=1:length(ys)
    x = xs{n}';
    y = ys{n}';
    Points{n} = table(x, y);
end

maxx = max(xs{length(xs)})

characters = {};
for n = 1:length(text1)
    %char = struct('character', text1(n));
    %start = struct('start', 0);
    %endd = struct('end', 0);
    
    charn = containers.Map({'character','start','end'},{text1(n),(n-1)*maxx/ length(text1),n*maxx/ length(text1)});
    characters{n} = charn;
    %{
    if isempty(characters)
        characters = {charn};
    else
        vertcat(characters, {charn});
    end
    %}
end
%Live = {word, containers.Map({'Segments'}, {struct('Points', Points)}), containers.Map({'characters'}, {characters})};
Live = containers.Map({'word','segments','characters'},{text1, {struct('points', Points)}, characters});

% Write native speaker's data
nativeFile = 'words/0013m1.wav';
[y, Fs] = audioread(nativeFile);
[f, t] = toPitchContour(y, Fs);

length(t)
length(f)

x = t;
y = f;

%sub-group x and y depends on NaN
index = find(isnan(y))
length(y)

xs = {};
ys = {};

i = 1;
for n=1:length(index)
    if n==1 && index(n) ~= 1
        keep = 1 : index(n)-1;
        xs{i} = x(keep);
        ys{i} = y(keep);
        i = i+1;
    end
    if  n==length(index) 
        if index(n)~=length(y)
            % index(n)+1 to test.end
            keep = index(n)+1 : length(y);
            xs{i} = x(keep);
            ys{i} = y(keep);
            i = i+1;
        end
    else
        if index(n+1)~=(index(n)+1)
            keep = index(n)+1 : index(n+1)-1;
            xs{i} = x(keep);
            ys{i} = y(keep);
            i = i+1;
        end
    end
end
i
xs
%y(isnan(y)) = -200;

text1 = '??';%text(find(~isspace(text)));
%word = struct('Word', text1);
Points = {};
for n=1:length(ys)
    x = xs{n}';
    y = ys{n}';
    Points{n} = table(x, y);
end

maxx = max(xs{length(xs)})

characters = {};
for n = 1:length(text1)
    %char = struct('character', text1(n));
    %start = struct('start', 0);
    %endd = struct('end', 0);
    
    charn = containers.Map({'character','start','end'},{text1(n),(n-1)*maxx/ length(text1),n*maxx/ length(text1)});
    characters{n} = charn;
    %{
    if isempty(characters)
        characters = {charn};
    else
        vertcat(characters, {charn});
    end
    %}
end
%Live = {word, containers.Map({'Segments'}, {struct('Points', Points)}), containers.Map({'characters'}, {characters})};
Native = containers.Map({'word','segments','characters'},{text1, {struct('points', Points)}, characters});

json = jsonencode(containers.Map({'live', 'native_speaker'}, {Live, Native}));

%fid = fopen(fname, 'r', 'n', 'UTF-8')
fid = fopen(outputFile, 'w', 'n', 'UTF-8');
fprintf(fid, json);
fclose(fid);
json

end