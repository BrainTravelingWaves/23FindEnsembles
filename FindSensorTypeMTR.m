function [mag,gr1,gr2] = FindSensorTypeMTR(corrmtr,triplch,thresh)
%looking for the number of gradiometers and magnetometers in the matrix
Nchn=306;

numch=zeros(1,Nchn*Nchn);
m=0;
if thresh>0
for j=1:Nchn
for i=1:Nchn
    if (corrmtr(i,j)>thresh) && (i~=j)
        m=m+1;
        numch(m)=i;
    end
end
end
else
for j=1:Nchn
for i=1:Nchn
    if corrmtr(i,j)<thresh
        m=m+1;
        numch(m)=i;
    end
end
end
end
numch=unique(numch);
numch(1)=[];
mag=0;
gr1=0;
gr2=0;
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

