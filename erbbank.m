function erbbank(infile,outfile)

% function erbbank(infile,outfile)
%
% filters StimCat with ErbFilterbank
% and saves files for single directions
%
% Jonas Braasch
% Institut fuer Kommunikationsakustik
% Ruhr-Universitaet Bochum
% 44780 Bochum 
% e-mail: braasch@ika.ruhr-uni-bochum.de
% 
% 20.07.00


file_in=[modeldir('stimcat') infile '.sct'];
eval(['load ' file_in ' -mat']);
file_out=[modeldir('bpbank') outfile];
fcoefs=erb_est(Fs);
%fcoefs=MakeERBFilters(Fs,36,100);
%fcoefs=fcoefs(36:-1:5,:);

for i=1:N_DIR
   StimErb_l=ERBFilterbank(StimCat(:,i*2-1),fcoefs)';
   StimErb_r=ERBFilterbank(StimCat(:,i*2),fcoefs)';
   disp(['erbfile: ' int2str(MAP(2,i)) '° azi']);
   azi=MAP(2,i);
   ele=0;
   eval(['save ' file_out '_' int2str_(MAP(2,i),3,'0')  '.erb Fs azi ele StimErb_l StimErb_r ']);
end % of for

