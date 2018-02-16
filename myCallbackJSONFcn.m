function myCallbackJSONFcn(hObject, eventData)

    
    javaFile = 'bytes/java.txt';
    writer = java.io.FileOutputStream(javaFile);
    writer.write(eventData.message.getBytes());
%{
    fid = fopen(javaFile, 'r', 'n', 'UTF-8');
    raw = fread(fid, 'char');
    json = char(raw');
    json
    fclose(fid);
    
    data = JSON.parse(json);
    text = data.result.alternatives{1}.transcript;
    text
%}  
    %disp((eventData.message.getBytes('UTF-8'))');

    %{
    json = char(eventData.message);
    fname = 'bytes/jsonoutput.txt';
    fid = fopen(fname, 'w', 'n', 'UTF-8');
    %fprintf(fid, json);
    fwrite(fid, json);
    fclose(fid);
    
    jsonId = fopen('bytes/java.txt', 'r', 'n', 'UTF-8');
    fprintf(jsonId, json);
    fclose(jsonId);
    json

    data = JSON.parse(json);
    text = data.result.alternatives{1}.transcript;
    text
%}
    %{
    fname = 'bytes/output.txt';
    fid = fopen(fname, 'w', 'n', 'UTF-8');
    %fprintf(fid, text);
    fwrite(fid, text);
    fclose(fid);
    %disp(obj.toString);
    %}
end  %myCallbackFcn