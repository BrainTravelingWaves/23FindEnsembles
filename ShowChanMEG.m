%% Show chan MEG
function [] = ShowChanMEG(Ch1,Ch2,sigMGG,wordname,SaveF)
%% Show and save
    ch(1,:)=sigMGG(Ch1,:);
    ch(2,:)=sigMGG(Ch2,:);  
    figure
    plot(ch')
    namefig=strcat(wordname,' Chan1-',num2str(Ch1),' Chan2-',num2str(Ch2));
    title(namefig);
    if SaveF==1
      savefig(namefig)
    end
end