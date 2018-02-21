classdef PitchContour
    %PITCHCONTOUR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        %Adding/removing properties and editting names/descriptions can be
        % done later. For now I'm trying recreate what's currently needed
        % so I can easily batch process a directory of samples.
        sampleId      %Id (filename for now) of the sample
        sample        %Source sample (y)
        sampleRate    %The sample rate (Fs)
        speakerId     %Id of the speaker (Nullable for now)
        onsetTime     %The onset time
        offsetTime    %The offset time
        contour       %A vector representing the pitch contour
        t             %The time in seconds of the pitch contour
        rms           %The root mean square of the pitch contour
    end
    
    methods
        function obj = PitchContour(sampleId)
            %PITCHCONTOUR Construct an instance of this class
            %   Providing a valid .wav file name will create a
            %   PitchContour object.
            
            %Set the sampleId. Right now I'm assuming that the sampleId and
            % the filename are the same. This can be modified later to be
            % more robust.
            obj.sampleId = sampleId;
            [sample, sampleRate] = audioread(sampleId);
            
            %Set the sample and sample rate. 
            obj.sample = sample;
            obj.sampleRate = sampleRate;
            
            %Find the midY for the sample.
            midY = obj.filterSample(sample, sampleRate);
            
            %Find and set the pitch contour and it's time in seconds.
            [pc, t] = obj.computepitchcontour(midY, sampleRate);
            obj.contour = pc;
            obj.t = t;
            obj.rms = obj.computeRMS();
            
            %Get onset and offset times
            [onset, offset] = obj.computeOnOffTimes(sample, sampleRate);
            obj.onsetTime = onset;
            obj.offsetTime = offset;
        end
        
        function e = minus(obj1, obj2)
            % Operator overloading to allow for arithmetic operators to be used
            % on PitchContour objects. This will make the code a lot easier to
            % use. Overloading the operators can make things like sorting much
            % easier.
            % 
            % The minus operation, '-', should produce the "difference" of the two
            % PitchContours. Right now I am arbitrarily returning the difference
            % of the root mean square of the pitch contour of obj1 with the root
            % mean square of the pitch contour of obj2. My intention is that
            % obj1 will be a reference PitchContour (the median) used to compare
            % similarities.
            a = obj1.rms;
            b = obj2.rms;
            
            e = a - b;
        end
        
        function b = lt(obj1, obj2)
            % This allows the ability to sort a list of pitch contours on
            % their rms.
            b = obj1.rms < obj2.rms;
        end
    end
        
    methods (Access=private)
        function midY = filterSample(~, sample, sampleRate)
            % Filter the provided sample. Explainations of the constants
            % and and their purposes would be preferred.
            wn = [150 2000]/(sampleRate/2);
            [b, a] = butter(5, wn);
            midY = filter(b, a, sample);
            
            % Looks like it's checking that the axes are correct. Is this a
            % hack? It seems like this should be known before calling the
            % above functions.
            if size(midY) <= 2
                midY = midY';
            end
        end
        
        function [pitchContour, t] = computepitchcontour(obj, midY, sampleRate)
            tic
            [f0, t] = obj.computef0(midY, sampleRate);
            toc
            
            pitchContour = obj.psuedonormzscore(f0);
        end
        
        function [F, t] = computef0(~, y, Fs)
            
            % Speech Contour Analysis
            % J. Braasch
            %
            % filename: input filename
            % plotFlag: 1=plot figure, 0=don't plot figure
            % t: time in seconds
            % F: F0 Fundamental Frequency [Hz]
            % En: relative Energy
            % G: Pitch Strength
            % index1: valid time in seconds
            % y: signal from wav file
            % Fs: Sample rate

            tabs=4096;

            %{
            % Huang's code
            % Creating low-cut and high-cut filter
            bhi = fir1(34, 0.28, 'high', chebwin(35, 30));  % low-cut/high-pass
            blo = fir1(34, 0.58, chebwin(35, 30));  %high-cut/low-pass

            % Filtering signal
            y = filter(bhi, 1, y);
            y = filter(blo, 1, y);
            %}

            [Y]=OLAsplit2(y(:,1),tabs);
            t=(0:(length(Y(1,:))-1)).*0.5.*tabs./Fs;

            for n=1:length(Y(1,:))
                % Look into this. 
                [F(n),]=pitchmodel18(Y(:,n),48000);
            end
        end
        
        function [ ynormalized ] = psuedonormzscore( ~, y )
            %Normalize input signal with mean = 300 and sd = 50
            %   by Z-Score formular
            m = 300;
            s = 50;
            si = size(y);

            for i = 1:si(1)
                %This is reallocating every loop. There is probably a
                %better way to do this.
                ynormalized(i, :) = (y(i , :) - m(i))/s(i);
            end
        end
        
        function [onsetTime, offsetTime] = computeOnOffTimes(~, y, Fs2)
            Fs = 32000;
            y = resample(y(:, 1), Fs, Fs2);
            
            fcoefs=MakeERBFilters(Fs,24,50);
            fcoefs=fcoefs(24:-1:1,:);
            
            x=ERBFilterBank(y(:,1),fcoefs);
            %Not sure what this is. There is probably a better way to
            %handle this, it's reallocating every loop
            load midF32k.mat midFreq;
            for n=1:24               
                ye=calc_env(x(n,:),midFreq(n),Fs,'m2');

                ye2(:,n)=resample(ye',2000,Fs);
            end
            YE=sum(ye2');

            YES=conv(YE,hanning(100));
            index=find(YES/max(YES)>0.1);
            onsetTime=(index(1)-50)./2000.*Fs2;
            offsetTime=(index(length(index))+150)./2000.*Fs2;
        end
        
        function normalizedContour = normalizeContour(obj1, obj2)
            %Currently my intention is to normalize the student's pitch
            %contour to the median native speaker's contour with the reason
            %being that the native speaker's pitch contour length is more
            %likely to be correct than the non-native speaker's length.
            %More indepth analysis of this can be looked into later.
            normalizedContour = obj1.contour/norm(obj2.contour);           
        end
    end
    
    methods (Access=public)
        function fig = plotContour(obj)
            %Create parent panel
            fig = figure('visible', 'off');
            p = uipanel('Parent', fig, 'BorderType', 'line');
            p.Title = 'Sample Analysis';
            p.TitlePosition = 'centertop';
            p.FontSize = 12;
            
            %Create waveform subplot
            subplot(2, 1, 1, 'Parent', p);
            plot(obj.sample)
            
            %Add onset/offset times to waveform plot
            hold on;
            vline(obj.onsetTime, 'g', 'Onset Time')
            vline(obj.offsetTime, 'g', 'Offset Time')
            
            %Create pitch contour subplot
            subplot(2, 1, 2);
            plot(obj.contour)
        end
        
        function fig = compareContours(obj1, obj2)
            %get character from filename. Change this later to be a
            %property of the object or something passed in or something
            %beside this.
            char = obj1.sampleId(end - 5: end-4);
            
            %Create parent panel
            fig = figure('visible', 'on');
            p = uipanel('Parent', fig, 'BorderType', 'Line');
            p.Title = strcat("Practicing", char); %Change this to the character name
            p.TitlePosition = 'centertop';
            p.FontSize = 12;
            
            %Create waveform subplot
            subplot(2, 1, 1, 'Parent', p)
            plot(obj1.sample, '-k')
            xlabel('Time');
            ylabel('Amplitude');
            
            hold on
            vline(obj1.onsetTime, 'r', 'Onset Time')
            vline(obj1.offsetTime, 'r', 'Offset Time')
            
            subplot(2, 1, 2)
            plot(obj1.contour, '-k', 'LineWidth', 1)
            title('Pitch Contour Comparison');
            xlabel('Time');
            ylabel('Pitch');
            hold on
            plot(obj2.contour, '--b')
            hold off
        end
        
        function frms = computeRMS(obj)
            %Returns the root mean square of a PitchContour object. I'm
            %using this to determine the similarity of assign a numeric
            %value to this so I can sort them
            
            frms = sqrt(nanmean((obj.contour).^2));
        end
        
        function e = computeRMSE(obj1, obj2)
            %Returns the root mean square error of two PitchContour
            %objects. I'm assuming that both PitchContour objects have been
            %length normalized.
            e = sqrt(mean((obj1.contour - obj2.contour).^2));
        end
    end
end


