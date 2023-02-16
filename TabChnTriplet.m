function [triplch] = TabChnTriplet(sens,noSave)
Nchn=306;
triplch=zeros(Nchn,3);
j=1;
for i=1:Nchn 
    nameS=char(sens.Channel(i).Name); % Name of chan
    triplch(i,1)=i; % sequence number
    triplch(i,2)=j; % triplet number
    if rem(i,3)==0
       j=j+1;    
    end
    triplch(i,3)=str2num(nameS(4:7));
end
if noSave==0
    save('triplch.mat','triplch')
end
end
