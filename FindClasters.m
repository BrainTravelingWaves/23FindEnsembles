function [] = FindClasters(MM,Ncls) % Ncls<Nchn
%% Find Clasters
%Nchn=306;
Nstr=8;
Nwrd=5;
%Ncls=10;
treshC=0.7;
treshP=0.01;
treshM=-0.7;
%MM=1;
%% word list
wrds={'zavitoy','vozmojn','vzaimny';
      'kudryav','dostupn','dvoyaky';
      'petlaus','pravdop','dvukrat';
      'kurchav','pronicm','sdvoeny';
      'vyazany','sudohod','dvoichn';
      'pleteny','realizm','oboudny';
      'volnist','osushes','dvuliky';
      'kruchen','vypolnm','dvoistv'};
%%    
jj=1;
for ns=1:Nstr % 1-8
    for nw=1:Nwrd % 1-5
        nullstr='';
        if jj<100
           nullstr='0';
        end
        if jj<10
           nullstr='00';
        end
        namewrds=wrds{ns,MM}; 
        numst=strcat(nullstr,num2str(jj));
        load(strcat(numst,'MGGs_',namewrds,num2str(nw))) % sigMGG        
        load(strcat(numst,'MGGc_',namewrds,num2str(nw))) % corrsig
        load(strcat(numst,'MGGp_',namewrds,num2str(nw))),% corpval
        %% Sort std sig
        %
        St=std(sigMGG');
        [St,Nst]=sort(St,'descend');
        Nst=Nst';
        %}
        %% Create claster plus
        ClasterChP=zeros(Ncls,Ncls+1);
        flagsave=0;
        for i=1:Ncls
            k=2;
            for j=1:Ncls
                if (corrsig(Nst(j),Nst(i))>treshC) && (corpval(Nst(j),Nst(i))<treshP)
                   ClasterChP(i,1)=Nst(i);
                   ClasterChP(i,k)=Nst(j);
                   k=k+1;
                   flagsave=1;
                end
            end   
        end 
        if flagsave==1
        save(strcat(numst,'CLSp_',namewrds,num2str(nw)),'ClasterChP')
        end
        %% Create claster minus
        ClasterChM=zeros(Ncls,Ncls+1);
        flagsave=0;
        for i=1:Ncls
            k=2;
            for j=1:Ncls
                if corrsig(Nst(j),Nst(i))<treshM && (corpval(Nst(j),Nst(i))<treshP)
                   ClasterChM(i,1)=-Nst(i);
                   ClasterChM(i,k)=-Nst(j);
                   k=k+1;
                   flagsave=1;
                end
            end   
        end
        if flagsave==1
        save(strcat(numst,'CLSm_',namewrds,num2str(nw)),'ClasterChM')        %%
        end
        jj=jj+1;
    end
end