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
            
            %Find and set the pitch contour and it's onset time.
            [pc, onsettime] = obj.computepitchcontour(midY, sampleRate);
            obj.contour = pc;
            obj.onsetTime = onsettime;
            
            %Get onset and offset times
            [onset, offset] = obj.computeOnOffTimes(sample, sampleRate);
            obj.onsetTime = onset;
            obj.offsetTime = offset;
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
            %handle this 
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
    end
end


