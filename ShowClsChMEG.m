%% Show corr ch MEG
function [stdMEG] = ShowClsChMEG(ClasterCh,sigMGG,StdDelta,wordname,SaveF)
%% Pair search

Nchn=306;
Ncls=size(ClasterCh);
Nl=0;
cn=zeros(2,Nchn*Nchn);

for i=1:Ncls(1)
    cch=ClasterCh(i,1);
    for j=1:Ncls(2)
        if (cch~=ClasterCh(i,j)) && (ClasterCh(i,j)~=0)
           Nl=Nl+1;
           cn(1,Nl)=cch;
           cn(2,Nl)=ClasterCh(i,j);
        end
    end
end
for i=1:Nl
    cni=cn(:,i); 
    if (cni(1,1)==cn(2,i)) && (cni(2,1)==cn(1,i)) && (cni(1,1)~=0)
        cn(:,i)=0;
    end
end
cn(cn==0)=[]; 
%colorlink='magenta'; 
if cn(1)<0
    cn=cn*-1;
    %colorlink='blue';
end
cn=cn';
Nl=fix(size(cn,1)/2);
%% Show and save
%Ncls=size(ClasterCh);
ch=zeros(2,size(sigMGG,2));
j=1;
for i=1:Nl
    ch1=cn(j);
    ch2=cn(j+1);
    j=j+2;
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
    plot(ch')
    namefig=strcat(wordname,' Chan1-',num2str(ch1),' Chan2-',num2str(ch2));
    title(namefig);
    pause(1)
    if SaveF==1
       savefig(namefig)
    end
    close(i)
    end
end 
end