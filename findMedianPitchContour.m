function [med] = findMedianPitchContour(word)
%findMedianPitchContour Returns the median pitch contour for the given
%word.
%   Given a word find all native speaker examples of that word, convert
%   them to their corresponding PitchContour, order them by their rms,
%   return the median.

    %Path to samples to be used
    inputPath = 'audio_samples/native_speaker/single_syllable_samples/';
    %Build the file pattern to search for
    filePattern = fullfile(inputPath, strcat('*', word, '.wav'));
    %The actual files found
    theFiles = dir(filePattern);
 
    pitchContours = PitchContour(zeros(1: length(theFiles)));
    
    for k = 1:length(theFiles)
        baseFileName = theFiles(k).name;
        fullFileName = fullfile(inputPath, baseFileName);
        fprintf(1, 'Now reading %s\n', fullFileName);
        
        pitchContours(k) = PitchContour(fullFileName);
    end
    
    med = median(pitchContours)
end

