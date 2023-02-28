%% CreateMatrixChMEG
Nchn=306;
dTime=1000;
treshC=0.7;
treshP=0.001;
MM=1; % 1 2 3
%% word list
wrds={'zavitoy','vozmojn','vzaimny';
      'kudryav','dostupn','dvoyaky';
      'petlaus','pravdop','dvukrat';
      'kurchav','pronicm','sdvoeny';
      'vyazany','sudohod','dvoichn';
      'pleteny','realizm','oboudny';
      'volnist','osushes','dvuliky';
      'kruchen','vypolnm','dvoistv'};
 %% Numbers of stimulus
 wrd1=[4,10,15,17,19;  % 104 110....
     9,27,36,40,42;
     5,14,23,28,43;
     6,12,29,37,38;
     7,16,21,22,33;
     8,20,30,35,41;
     11,13,25,26,39;
     18,24,31,32,34];
 %%
 wrd2=[7,18,20,22,34; % 207 218....+++3
       9,17,21,39,40;
       11,14,28,29,32;
       4,24,35,41,42;
       5,13,15,27,43;
       6,19,26,30,38;
       8,10,12,16,37;
       23,25,31,33,36];
  %%
 wrd3=[12,22,29,35,43; % 312 322....+++3
       11,21,24,25,33;
       5,20,27,30,31;
       4,8,18,32,40;
       6,7,19,36,41;
       9,10,16,23,28;
       13,14,17,26,39;
       15,34,37,38,42];
%% Labeles of words
if MM==1 
    Nstr=8;
    Nwrd=5;
    wrd=wrd1;
    stimulus=m1.Events(1).times; % Start word
    %behavir=m1.Events(2).times(1,4:end); % Reaction
    timeSig=m1.Time;     % Signal time
    sig=m1.F(1:Nchn,:);  % Signal of MEG
end
%%
if MM==2 
    Nstr=8;
    Nwrd=5;
    wrd=wrd2;
    stimulus=m2.Events(1).times; % Start word
    %behavir=m2.Events(2).times(1,2:end); % Reaction
    timeSig=m2.Time;     % Signal time
    sig=m2.F(1:Nchn,:);  % Signal of MEG
end
%%
if MM==3 
    Nstr=8;
    Nwrd=5;
    wrd=wrd3;
    stimulus=m3.Events(1).times; % Start word
    %behavir=m3.Events(2).times(1,2:end); % Reaction
    timeSig=m3.Time;     % Signal time
    sig=m3.F(1:Nchn,:);  % Signal of MEG
end 
%% Find labeles numbers 
Nsignal=size(timeSig,2);
tTime=zeros(Nstr,Nwrd);
for i=1:Nstr
    for j=1:Nwrd
        jj=1;
        while jj < Nsignal+1
          if timeSig(jj) > stimulus(wrd(i,j))
            break  
          end
          jj=jj+1;
        end
        tTime(i,j)=jj;
    end
end
%% Matrix of correlation 306
%dTime=1000;
sigMGG=zeros(Nchn,dTime);
corrsig=zeros(Nchn);
corpval=corrsig;
%tresh=0.7;
%%
jj=1;
for ns=1:Nstr % 1-8
    for nw=1:Nwrd % 1-5
        %% MEG1+GRD2+GRD3
        for i=1:Nchn
            sigMGG(i,:)=sig(i,tTime(ns,nw)+1:tTime(ns,nw)+dTime);
        end
        %% cor_MGG_MGG
        for i=1:Nchn
            sig1=sigMGG(i,:);
            for j=1:Nchn
                sig2=sigMGG(j,:);
                [corrsig(i,j),corpval(i,j)]=corr(sig1',sig2');
            end
        end
        %%
        nullstr='';
        if jj<100
           nullstr='0';
        end
        if jj<10
           nullstr='00';
        end
        %%
        numst=strcat(nullstr,num2str(jj));
        namewrds=wrds{ns,MM};
        save(strcat(numst,'MGGs_',namewrds,num2str(nw)),'sigMGG')
        save(strcat(numst,'MGGc_',namewrds,num2str(nw)),'corrsig')
        save(strcat(numst,'MGGp_',namewrds,num2str(nw)),'corpval')
        jj=jj+1;
     end
end
%%