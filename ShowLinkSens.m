function [] = ShowLinkSens(IndexWord,ShowNumChan,sens,corsumW)
%% Link sensors
%IndexWord=6; % 0 %1 % 2 % 3 % 4 % 5 % 6 % 7 % 8
%ShowNumChan=1;

wrdl={'zavitoy','vozmojn','vzaimny';
      'kudryav','dostupn','dvoyaky';
      'petlaus','pravdop','dvukrat';
      'kurchav','pronicm','sdvoeny';
      'vyazany','sudohod','dvoichn';
      'pleteny','realizm','oboudny';
      'volnist','osushes','dvuliky';
      'kruchen','vypolnm','dvoistv'};
Nchn=306;
% Read channel location
x=zeros(Nchn,1);
y=x;
z=x;
x1=zeros(fix(Nchn/3),1);
y1=x1; % MAG1 red
z1=x1;
x2=x1; % GRAD2 green
y2=x1;
z2=x1; % GRAD3 blue
x3=x1;
y3=x1;
z3=x1;
i1=1;
i2=1;
i3=1;
for i=1:Nchn  % Load MEG GRAD All location
    nameS=char(sens.Channel(i).Name);
    if nameS(7)=='1'
      x1(i1)=sens.Channel(i).Loc(1,1);
      y1(i1)=sens.Channel(i).Loc(2,1);
      z1(i1)=sens.Channel(i).Loc(3,1);
      i1=i1+1;  
    end
    if nameS(7)=='2'
      x2(i2)=sens.Channel(i).Loc(1,1);
      y2(i2)=sens.Channel(i).Loc(2,1);
      z2(i2)=sens.Channel(i).Loc(3,1);
      i2=i2+1;  
    end
    if nameS(7)=='3'
      x3(i3)=sens.Channel(i).Loc(1,1);
      y3(i3)=sens.Channel(i).Loc(2,1);
      z3(i3)=sens.Channel(i).Loc(3,1);
      i3=i3+1;  
    end
    x(i)=sens.Channel(i).Loc(1,1);
    y(i)=sens.Channel(i).Loc(2,1);
    z(i)=sens.Channel(i).Loc(3,1);
end

% Set figure
hf=figure;
if IndexWord==0
    hf.Name='zavitoy';
else    
    hf.Name=wrdl{IndexWord,1};
end
%% Show sensors
% Load MAG
hold on
h1=plot3(x1,y1,z1,'o');
h1.Color='red';
h2=plot3(x2,y2,z2,'o');
h2.Color='blue';
h3=plot3(x3,y3,z3,'o');
h3.Color='green';


%h1.Color='r';
%h1.LineWidth=3;
%h2=line(x(5:6),y(5:6),z(5:6));
%%
Nl=0;
for i=1:Nchn
    for j=1:Nchn
        if IndexWord>0
            if corsumW(i,j,IndexWord)>0
               Nl=Nl+1;
            end
        else
           if corsum(i,j)>0
               Nl=Nl+1;
           end
       
        end
    end
end
xy=zeros(Nl,2);
k=1;
for i=1:Nchn
    for j=1:Nchn
        if IndexWord>0
        if corsumW(i,j,IndexWord)>0
           xy(k,1)=i;
           xy(k,2)=j;
           k=k+1;
        end
        else
        if corsum(i,j)>0
           xy(k,1)=i;
           xy(k,2)=j;
           k=k+1;
        end    
        end    
    end
end
%Ns=size(xy,1);
for i=1:Nl
    ch1=xy(i,1);
    ch2=xy(i,2);
    for j=i+1:Nl
        if xy(j,2)==ch1
           if xy(j,1)==ch2
               xy(j,:)=0;
           end    
        end
    end
end
%
i=1;
%Ns=size(xy,1);
while(i < Nl+1)
  if xy(i,1)==0
      xy(i,:)=[];
      Nl=Nl-1;
  else
      i=i+1;
  end  
end    
hold on
xx=zeros(2,1);
yy=xx;
zz=xx;
for i=1:Nl
   ch1=xy(i,1);
   ch2=xy(i,2);
   xx(1)=x(ch1);
   yy(1)=y(ch1);
   zz(1)=z(ch1);
   xx(2)=x(ch2);
   yy(2)=y(ch2);
   zz(2)=z(ch2);
   hh=line(xx,yy,zz);
   %if rem(i,2)==0
   %   hh.Color='yellow';
   %else
      hh.Color='magenta'; 
   %end
   hh.LineWidth=1;
end
%%
if ShowNumChan==1
for i=1:Nchn
    text(x(i),y(i),z(i),num2str(i));
end
end
grid
end
%%
% a=e.Channel(1).Name;
% b=char(a);
% c=b(6);
% d=str2num(c);