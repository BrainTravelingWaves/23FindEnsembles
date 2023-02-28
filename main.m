%% Create matrices of MEG channels. 
% MM - No set words. dTime-window of analis
MM=1;
dTime=1000;
CreateChMEGmatrix(MM,dTime)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Create matrix filtres for word
% SaveMGG - 0/1, SaveFig - 0/1
SaveMGG=0;
SaveFig=0;
CreateFiltrMatrix(SaveMGG,SaveFig) 
%% Word recognition using matrix masks
%  MM - No set words. corsumW-matrix masks, SaveFig-0/1,ShowFig-0/1.
WordsRecognition(MM,corsumW,SaveFig,ShowFig) 
%% Show links in sensor space for words
% MM - No set words (1-3). IndexWord - Number of word (0-8), ShowNumChan - 0/1, 
% sens - MEG sensors, corsum - common links for set, corsumW - masks for words
MM=1; 
IndexWord=1;
ShowNumChan=1; 
sens=e;
ShowLinksWords(MM,IndexWord,ShowNumChan,sens,corsum,corsumW) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Search for channels clusters
% MM - No set words. Ncls-maximum number of clusters =< Nchn
MM=1;
Ncls=10;
FindClasters(MM,Ncls) 
%% Show clusters MEG channels for compare
% ClasterCh - channel clasters, sigMGG - MEG signal,wordname - a word name
wordname='zavitoy';
ShowCorrChMEG(ClasterCh,sigMGG,wordname) 
%% Show links in sensor space for clasters
% ClasterCh - channel clasters. ShowNumChan - 0/1, % sens - MEG sensors.
ShowNumChan=1; 
sens=e;
ShowLinksClasters(ClasterCh,ShowNumChan,sens); 
%% MEG sensors table: number channel,triplet numbers,channel names
sens=e;
noSave=1;
TabChnTriplet(sens,noSave)
%% Looking for the number of gradiometers and magnetometers in the corsumW matrix 
iword=0; % All words 1-8 one word
[mag,gr1,gr2] = FindSensorTypeWRD(corsumW,triplch,iword);
%% Looking for the number of gradiometers and magnetometers in the corr matrix 
thresh=0.7; % All words 1-8 one wor
corrmtr=corrsig;
mgg=zeros(9,1);
[mgg(2),mgg(3),mgg(4)] = FindSensorTypeMTR(corrmtr,triplch,thresh);
thresh=-0.7;
[mgg(6),mgg(7),mgg(8)] = FindSensorTypeMTR(corrmtr,triplch,thresh);
stem(mgg)
%% 