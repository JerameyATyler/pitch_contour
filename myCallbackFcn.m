function myCallbackFcn(hObject, eventData)

%{
    n = 1;
    bFile = char(strcat('receive/', num2str(n), '.txt'));
    while exist(bFile, 'file') ~= 2
       n = n+1; 
       bFile = char(strcat('receive/', num2str(n), '.txt'));
    end
    
    fileID = fopen(bFile, 'w');
    fwrite(fileID, eventData.message);
    fclose(fileID);
%} 
    
    %eventData.message
    
    
    % Native speaker's data
    %text = fileread('native/test2.txt');
	%mqwrapper.MessagePublisher.send(text,'amq.topic', '129.161.106.19', 'CIR.pitchtone.analysis', true, 'guest', 'guest');
    
    %
    c = char(eventData.message);
    
    bFile = 'native.txt';
    fileID = fopen(bFile, 'w');
    fwrite(fileID, c);
    fclose(fileID);
    
    d = unicode2native(c);
    
    [filedir] = Binary2WavFile(d);
    
    [y, Fs] = audioread(filedir);
    
    tFs = 48000;
    [P,Q] = rat(tFs/Fs);
    [y] = resample(y, P, Q);
    
    tFs
    
    [nF, t] = toPitchContour(y, double(tFs));
    plot(t, nF);
    
    % Extract recognized text
    javaFile = 'bytes/java.txt';
    fid = fopen(javaFile, 'r', 'n', 'UTF-8');
    raw = fread(fid, 'char');
    json = char(raw');
    json
    fclose(fid);
    data = JSON.parse(json);
    text = data.result.alternatives{1}.transcript;
    text
    
    [json] = WriteIntoJSON(text, t, nF, 'toUnity2.txt');
    mqwrapper.MessagePublisher.send(json,'amq.topic', '129.161.106.19', 'CIR.pitchtone.analysis', true, 'guest', 'guest');
    %{
    [nF, t] = toPitchContour(y, double(Fs));
    nF
    [json] = WriteIntoJSON('test', t, nF, 'native\test.txt');
    %}
    
    %{
    word = 'words\0013m1.wav';
    [y, Fs] = audioread(word);
    [nF, t] = toPitchContour(y, Fs);
    [json] = WriteIntoJSON('??', t, nF, 'native\??.txt');
    str = java.lang.String.valueOf(json);
    %}
    
    %waveName = 'test.wav';
    %audiowrite(waveName, y, Fs);
    
   % binary = reshape(dec2bin(eventData.message, 8).'-'0',1,[])
    %binary = dec2bin(eventData.message)
    %length(binary)

    %str = java.lang.String.valueOf(java.lang.System.currentTimeMillis());
    %obj = java.lang.StringBuilder('Receieved Time [').append(str).append(']').append(eventData.message);
    %disp(obj.toString);
end  %myCallbackFcn