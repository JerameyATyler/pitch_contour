function bulkProcess(inPath, outPath)
    if ~isdir(inPath)
        errorMessage = sprintf('Error: The following folder does not exist:\n%s', inPath);
        uiwait(warndlg(errorMessage));
        return;
    end
    
    filePattern = fullfile(inPath, '*.wav');
    theFiles = dir(filePattern);
    
    for k = 1 : length(theFiles)
        baseFileName = theFiles(k).name;
        fullFileName = fullfile(inPath, baseFileName);
        fprintf(1, 'Now reading %s\n', fullFileName);
        
        [ ~ , name, ~] = fileparts(fullFileName);
        
        pc = PitchContour(fullFileName);
       
        fig = pc.plotContour();
        
        outFileName = [outPath  name  '.jpg'];
        saveas(fig, outFileName);
        close(fig);
    end
end