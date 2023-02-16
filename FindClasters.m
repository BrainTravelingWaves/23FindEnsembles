function [St] = FindClasters(MM)
%% Find Clasters
Nchn=306;
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
        St=std(sigMGG');
        [St,Nst]=sort(St,'descend');
        Nst=Nst';
        St=Nst;
        %% Test
        cnn=zeros(Nchn);
        for i=1:Nchn
            for j=1:Nchn
                if (corrsig(i,j)>treshC) && (corpval(i,j)<treshP) && (i~=j)
                   cnn(i,j)=corrsig(i,j);
                end
            end   
        end       
        %% Create claster plus
        cn=zeros(Nchn);
        for i=1:Nchn
            cn(i,1)=i;
            k=2;
            for j=i+1:Nchn-2
                if (corrsig(i,j)>treshC) && (corpval(i,j)<treshP) 
                   cn(i,k)=j;
                   k=k+1;
                end
            end   
        end
        ClasterCh=zeros(Nchn);
        for i=1:Nchn
            ClasterCh(i,:)=cn(Nst(i),:);
        end
        j=1;
        for i=1:Nchn
            if ClasterCh(j,2)==0
                ClasterCh(j,:)=[];
                j=j-1;
            end
            j=j+1;
        end        
        if size(ClasterCh,1)>0
        save(strcat(numst,'CLSp_',namewrds,num2str(nw)),'ClasterCh')
        end
        %% Create claster minus
        cn=zeros(Nchn);
        for i=1:Nchn
            cn(i,1)=i;
            k=2;
            for j=i+1:Nchn-2
                if corrsig(i,j)<treshM && (corpval(i,j)<treshP)
                   cn(i,k)=j;
                   k=k+1;
                end
            end   
        end
        ClasterCh=zeros(Nchn);
        for i=1:Nchn
            ClasterCh(i,:)=cn(Nst(i),:);
        end
        j=1;
        for i=1:Nchn
            if ClasterCh(j,2)==0
                ClasterCh(j,:)=[];
                j=j-1;
            end
            j=j+1;
        end        
        ClasterCh=ClasterCh*-1;
        if size(ClasterCh,1)>0
        save(strcat(numst,'CLSm_',namewrds,num2str(nw)),'ClasterCh')
        end
        %%
        jj=jj+1;
    end
end