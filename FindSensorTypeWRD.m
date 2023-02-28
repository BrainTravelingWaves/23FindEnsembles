function [mag,gr1,gr2] = FindSensorTypeWRD(corsumW,triplch,iword)
%looking for the number of gradiometers and magnetometers in the matrix of
%words
Nchn=306;
Nword=8;
numch=zeros(1,Nchn*Nchn);
m=0;
if iword==0
for k=1:Nword
for j=1:Nchn
for i=1:Nchn
    if corsumW(i,j,k)>0
        m=m+1;
        numch(m)=i;
    end
end
end
end
else
k=iword;    
for j=1:Nchn
for i=1:Nchn
    if corsumW(i,j,k)>0
        m=m+1;
        numch(m)=i;
    end
end
end
end
mag = 0;
gr1 = 0;
gr2 = 0;

numch=unique(numch);
numch(1)=[];
N=size(numch,2);
for i=1:N
    mg=triplch(numch(i),3);
    nmg=num2str(mg);
    mmg=str2num(nmg(:))';
    ng=size(mmg,2);
    if mmg(ng)==1
        mag=mag+1;
    end
    if mmg(ng)==2
        gr1=gr1+1;
    end
    if mmg(ng)==3
        gr2=gr2+1;
    end
end
end

