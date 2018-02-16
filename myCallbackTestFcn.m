function myCallbackTestFcn(hObject, eventData)
    str = java.lang.String.valueOf(java.lang.System.currentTimeMillis());
    obj = java.lang.StringBuilder('Receieved Time [').append(str).append(']').append(eventData.message);
    disp(obj.toString);
end  %myCallbackFcn