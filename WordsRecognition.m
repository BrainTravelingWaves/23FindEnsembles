function [] = WordsRecognition(MM,corsumW,SaveF,ShowFig)
%% Words recognition
Nchn=306;
Nstr=8;
Nwrd=5;
%treshC=0.7;
%treshP=0.01;
%treshM=-0.7;
%MM=1;
%SaveF=0;
%%
wrds={'zavitoy','vozmojn','vzaimny';
      'kudryav','dostupn','dvoyaky';
      'petlaus','pravdop','dvukrat';
      'kurchav','pronicm','sdvoeny';
      'vyazany','sudohod','dvoichn';
      'pleteny','realizm','oboudny';
      'volnist','osushes','dvuliky';
      'kruchen','vypolnm','dvoistv'};
%%
%corsumW=zeros(Nchn,Nchn,Nstr);
%load('MGG-')
for ii=1:Nstr
corsum=corsumW(:,:,ii);
weight_w=zeros(Nstr,Nwrd);
jj=1;
for ns=1:Nstr
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
        load(numst); % corrsig
        for i=1:Nchn
            for j=1:Nchn
                if (i==j) || (corrsig(i,j)<0.7) % clean
                    corrsig(i,j)=0; 
                end
                if corsum(i,j)>0
                   weight_w(ns,nw)=weight_w(ns,nw)+corrsig(i,j);
                end
            end
        end
        jj=jj+1;    
    end
end
  figure(ii)
  imagesc(weight_w)
  name=wrds{ii,MM};
  title(name)
  colorbar
  name=strcat(num2str(ii),name,'.fig');
  if SaveF==1
      savefig(name)
  end
  pause(1)
  if ShowFig==0
      close(ii)
  end    
end
end