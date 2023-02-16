%% Show corr ch MEG
function [stdMEG] = ShowWrdChMEG(NameSig,IndexWord,sigMGG,StdDelta,corsum,corsumW,SaveF)
%% Pair search
stdMEG=std(sigMGG')';
Nchn=306;
Nl=0;
NameSg=NameSig;
NameSg(1:8)=[];
NameSg(end-3:end)=[];

for i=1:Nchn
    for j=1:Nchn
        if IndexWord>0
            if corsumW(i,j,IndexWord)>0
               Nl=Nl+1;
            end
        else
           if corsum(i,j)>0
               Nl=Nl+1;
           end     
        end
    end
end
xy=zeros(Nl,2);
k=1;
for i=1:Nchn
    for j=1:Nchn
        if IndexWord>0
        if corsumW(i,j,IndexWord)>0
           xy(k,1)=i;
           xy(k,2)=j;
           k=k+1;
        end
        else
        if corsum(i,j)>0
           xy(k,1)=i;
           xy(k,2)=j;
           k=k+1;
        end    
        end    
    end
end
ch=zeros(2,size(sigMGG,2));
for i=1:Nl
    ch1=xy(i,1);
    ch2=xy(i,2);
    ch(1,:)=sigMGG(ch1,:);
    ch(2,:)=sigMGG(ch2,:);  
    StdCh=std(ch');
    StdD=StdCh(1)-StdCh(2);
    flagsv=0;
    if (StdD > 0) && (StdCh(2)>(StdCh(1)*StdDelta))
        flagsv=1;
    end
    if (StdD < 0) && (StdCh(1)>(StdCh(2)*StdDelta))
        flagsv=1;
    end
    if flagsv==1    
    figure(i)
    plot(ch');
    NameFig=strcat(NameSg,' Chan1-',num2str(ch1),' Chan2-',num2str(ch2));
    title(NameFig);
    pause(1)
    if SaveF==1
       savefig(NameFig)
    end
    close(i)
    end
end