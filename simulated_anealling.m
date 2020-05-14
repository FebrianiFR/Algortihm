clc
clear all
%simmulated anealling

%ruang model
x=-5:0.1:5;
xmin=-5;
xmax=5;

%fungsi yang digunakan
y=peak_1D(x)

ssum=0;
iter=1;
%pilih model acak mn sama mn+1 
    mn1=xmin+rand(1)*(xmax-xmin);
    mn2=xmin+rand(1)*(xmax-xmin);
    
while iter<=5000
    t=5;
    %menghitungh hasil
    y1=peak_1D(mn1);
    y2=peak_1D(mn2);
    d=y2-y1;%perhitungan error
    
    if d<=0
        mn1=mn2;%maka mn+1 dipilih
        mn2=xmin+rand(1)*(xmax-xmin);%perbaharui nilai mn2
    elseif d>0
        %evaluasi mn1 dengan cek probabilitas acceptance
        pa=exp(-d/t);
        r=rand(1);
        if r<pa
            mn2=mn1;%kalau masuk nilai mn nya balik lagi ke awal
        end
    end
       % if iter==5*iter
            t=t-0.0001;
        %end
        iter=1+iter;
    clf
    plot(x,y)
    hold on
    plot(mn1,y1,'og',mn2,y2,'or')
    %pause(1)

end
