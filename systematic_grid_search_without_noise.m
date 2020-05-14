%SYSTEMATIC GRID SEARCH
%WITHOUT NOISE
%Febriani F R / 12315002
clear all
%ruang model
x=0:1:100;
y=0:1:100;

%posisi stasiun
xs=[20,70,34,24,89,50];
ys=[56,34,76,89,78,20];

%posisi gempa
xg=50;
yg=45;
vp=4;

%perhitungan tobs
for i=1:length(xs)
    dx=xg-xs(i);
    dy=yg-ys(i);
    tobs(i)=sqrt((dx*dx)+(dy*dy))/vp;
end
ssum=0;
%systematic grid search
for i=1:1:100
    for j=1:1:100
        for k=1:length(xs)
             dx=i-xs(k);
             dy=j-ys(k);
             tcal(k)=sqrt((dx*dx)+(dy*dy))/vp;
             er(k)=(tobs(k)-tcal(k)).^2;
             ssum=ssum+er(k);
        end
        erms(i,j)=sqrt(ssum/4);
        ssum=0;
    end
end

contourf(erms)
colorbar
hold on
plot(xs,ys,'og')
plot(xg,yg,'*r')