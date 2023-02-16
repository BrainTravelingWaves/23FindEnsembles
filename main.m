%% Create matrices of MEG channels. 
% MM - No set words. dTime-window of analis
MM=1;
m=m1;
t0=0; %-2000;
dTime=1000; %2000;
mode=1; % 0 - only sig 1 - all sig+corrmtr+pvalmtr  
CreateChMEGmatrix(MM,m,t0,dTime,mode)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Create matrix masks for word
% SaveMGG - 0/1, SaveFig - 0/1
SaveMGG=1;
SaveFig=0;
MM=1;
CreateMaskMatrix(MM,SaveMGG,SaveFig) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Word recognition using matrix masks
%  MM - No set words. corsumW-matrix masks, SaveFig-0/1,ShowFig-0/1.
MM=1;
SaveFig=0;
ShowFig=1;
load('MGG-.mat')
WordsRecognition(MM,corsumW,SaveFig,ShowFig) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Show word MEG channels for compare
% ClasterCh - channel clasters, sigMGG - MEG signal,wordname - a word name,
% SaveF=1/0; save figure
%MM=1; 
IndexWord=1;
SaveFile=0;
StdDelta=0.01;
NameSig='001MGGs_zavitoy1.mat';
load(NameSig)
load('MGG-.mat');
load('MGG+.mat');
stdMEG=ShowWrdChMEG(NameSig,IndexWord,sigMGG,StdDelta,corsum,corsumW,SaveFile);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Show links in sensor space for words
% MM - Num words set (1-3). IndexWord - Number of word (0-8), ShowNumChan - 0/1, 
% sens - MEG sensors, corsum - common links for set, corsumW - masks for words
MM=1; 
indexW=1;
ShowCh=1; 
sns=s;
load('MGG-.mat')
load('MGG+.mat')
sM=stdMEG;
sD=0.9; %StdDelta;
ShowLinksWords(MM,indexW,ShowCh,sns,sM,sD,corsum,corsumW); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Search for channels clusters
% MM - Num set words.
MM=1;
St=FindClasters(MM); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Show clusters MEG channels for compare
% ClasterCh - channel clasters, sigMGG - MEG signal,wordname - a word name,
% SaveF=1/0; save figure
nameword='zavitoy1';
SaveFile=1;
StdDelta=0.5;
load('001MGGs_zavitoy1.mat');
load('001CLSm_zavitoy1.mat');
ShowClsChMEG(ClasterCh,sigMGG,StdDelta,nameword,SaveFile);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Show MEG channels for compare
% Ch1,Ch2 - channels, sigMGG - MEG signal,wordname - a word name,
% SaveF=1/0; save figure
wordname='zavitoy1';
SaveF=0;
Ch1=233; % 1-306
Ch2=282; % 1-306
ShowChanMEG(Ch1,Ch2,sigMGG,wordname,SaveF); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Show links in sensor space for clasters
% ClasterCh - channel clasters. ShowNumChan - 0/1, % sens - MEG sensors.
ShowNumChan=1; 
sens=s;
wordname='zavitoy1';
StdDelta=0.5;
sgMGG=sigMGG';
stdMEG=std(sgMGG)';
ShowLinksClasters(ClasterCh,stdMEG,StdDelta,ShowNumChan,sens,wordname); 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MEG sens table: number channel,triplet numbers,channel names
sens=s;
noSave=1;
TabChnTriplet(sens,noSave)
%%
