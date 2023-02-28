%% Show corr ch MEG
function [] = ShowCorrChMEG(ClasterCh,sigMGG,wordname)
Ncls=size(ClasterCh);
ch=zeros(2,1000);
k=1;
  for i=1:Ncls(1)
    for j=2:Ncls(2)
        ch1=ClasterCh(i,1);
        ch2=ClasterCh(i,j);
        if (ch1~=ch2) && (ch2>0)
            ch(1,:)=sigMGG(ch1,:);
            ch(2,:)=sigMGG(ch2,:);  
            figure(k)
            plot(ch')
            title(strcat(wordname,' Chan1-',num2str(ch1),' Chan2-',num2str(ch2)));
            k=k+1;
            pause(1)
        end
    end
  end 
end