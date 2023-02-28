function [] = CreateFiltrMatrix(SaveMGG,SaveFig)
%% Create Mask Matrix
Nchn=306;
Nstr=8;
Nwrd=5;
%Ncls=10;
treshC=0.7;
%treshP=0.01;
%treshM=-0.7;
MM=1;
SaveF=1;
%%
wrds={'zavitoy','vozmojn','vzaimny';
      'kudryav','dostupn','dvoyaky';
      'petlaus','pravdop','dvukrat';
      'kurchav','pronicm','sdvoeny';
      'vyazany','sudohod','dvoichn';
      'pleteny','realizm','oboudny';
      'volnist','osushes','dvuliky';
      'kruchen','vypolnm','dvoistv'};
%% Differences
corsum=zeros(Nchn);
corsumW=zeros(Nchn,Nchn,Nstr);
jj=1;
for ns=1:Nstr
    corsumS=zeros(Nchn);
    for nw=1:Nwrd
        nullstr='';
        if jj<100
           nullstr='0';
        end
        if jj<10
           nullstr='00';
        end
        namewrds=wrds{ns,MM}; 
        numst=strcat(nullstr,num2str(jj));
        corrsig=zeros(Nchn);
        numst=strcat(numst,'MGGc_',namewrds,num2str(nw),'.mat');
        load(numst);
        % Filtr corrsig
        for i=1:Nchn
            for j=1:Nchn
                if (i==j) || (corrsig(i,j) < treshC)
                   corrsig(i,j)=0; 
                end
            end
        end
        corsum=corsum+corrsig;
        corsumS=corsumS+corrsig;
        jj=jj+1;
    end
    corsumW(:,:,ns)=corsumS/Nwrd;
end
corsum=corsum/Nstr/Nwrd;
%% Filtr tresh Save MGG+
for j=1:Nchn
    for i=1:Nchn
        if corsum(i,j) < treshC
            corsum(i,j)=0;
        end
    end
end
if SaveMGG==1
save('MGG+','corsum')
end
figure(1)
imagesc(corsum)
name='MGG+';
title(name)
colorbar
name=strcat(name,'.fig');
if SaveF==1
  savefig(name)
end
pause(1)
close(1)
%% Save MGG minus
for ns=1:Nstr
    corsumW(:,:,ns)=corsumW(:,:,ns)-corsum;
    for j=1:Nchn
        for i=1:Nchn
            if corsumW(i,j,ns) < treshC
              corsumW(i,j,ns)=0;
            end
        end
    end
end
if SaveMGG==1
   save('MGG-','corsumW')
end
%%
for ns=1:Nstr
    corsum=corsumW(:,:,ns);
    figure(ns)
    imagesc(corsum)
    name=strcat('MGG-',wrds{ns,MM});
    title(name)
    colorbar
    name=strcat(name,'.fig');
    if SaveFig==1
        savefig(name)
    end
    pause(1)
    close(ns)
end
end
%{
Nchn=306;
figure(1)

    for j=1:Nchn
        for i=1:Nchn
            if (i==j) || (corsum1(i,j)<0.7)
              corsum1(i,j)=0;
            end
        end
    end    
imagesc(corsum1)
figure(2)
imagesc(corsum)
%}
