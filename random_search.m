clc
clear all
%random grid search 
%data stasiun dan time
xs=[20 50 40 10];
ys=[10 25 50 40];
%posisi gempa (model sintetik)
xg=40;
yg=30;
v=6; %km/s

%forward modelng t stasiun

for i = 1:length(xs);
    tobs(i)=((xs(i)-xg)^2+(ys(i)-yg)^2)^0.5/v;
    %tobs(i)=tsin(i)+(1-rand)*0.01;%noise
end

%ruang model
x = 0:1:100;
y = 0:1:100;

%random search for xx times
xx=round(100*rand(1,25));
yy=round(100*rand(1,25));
ssum=0;
iter=1;
while iter<=25
sum=0;
        for k =1:length(xs)
            tcal(k)=sqrt(((xx(iter)-xs(k)).^2+(yy(iter)-ys(k)).^2))/v;
            e(k)=(tcal(k)-tobs(k)).^2;
            sum=sum+e(k);
        end
     a=sqrt(sum/length(xs));
     c(iter)=a;
iter=iter+1;
end


[xxx,yyy]=meshgrid(0:1:100, 0:1:100);
zz=griddata(xx,yy,c,xxx,yyy,'cubic');
figure 
surfc(xxx,yyy,zz)
title('3D Hypocenter Random Search')
c=colorbar;
c.Label.String='Error RMS';
xlabel('X')
ylabel('Y')
zlabel('Z')
figure 
contourf(zz)
c=colorbar;
c.Label.String='Error RMS';
hold on 
plot(xs,ys,'vw',xg,yg,'*r')
title('2D Hypocenter Random Search')
xlabel('X')
ylabel('Y')
