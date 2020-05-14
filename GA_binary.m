%GENETIC ALGORTIHM WITH BINARY 

%create dummy problem
x=-5:0.1:5;
y=peak_1D(x)
plot(x,y);
hold on
npop=20;
xmin=-5;
xmax=5;
ngen=100; %number of generation
p_crs=0.8; %probability of crossover

%generate population
    for ipop=1:npop
        for ibit=1:4
            r = rand;
            if r < 0.5
                model_bin(ipop,ibit)=1;
            else
                model_bin(ipop,ibit)=0;
            end
        end
    end

%convert binary to decimal
model_dec=binaryVectorToDecimal(model_bin);

%convert decimal to model and calculate misfit
bin_max=15;
    for ipop=1:npop
        a=model_dec(ipop);
        model(ipop)=xmin+a/bin_max*(xmax-xmin);
        misfit(ipop)=peak_1D(model(ipop));
    end

plot(model,misfit,'*')


for igen=1:ngen
    fprintf('Generation %3d \n',igen);
%selection based on fitness
sums=0;
for ipop=1:npop 
    misfit(ipop)=peak_1D(model(ipop));
    fitness(ipop)=1/misfit(ipop);
    sums=sums+fitness(ipop);
end

%normalizing fitness
probs=fitness./sums;

%cumulative probability and summing data
ssum = 0;
for ipop = 1:npop
    ssum = ssum + probs(ipop);
    p_cumulative(ipop) = ssum;
    fprintf('model %2d %5.2f %5.2f %5.2f %5.3f \n', ...
    ipop, misfit(ipop), fitness(ipop), probs(ipop), p_cumulative(ipop));
end

%roullete wheel to choose parent
for ipop = 1:npop/2     %number of parent
    R1 = rand;          %iterasi pemilihan parent 1
    for i = 1:npop
        if R1 < p_cumulative(i)
            idx_par1 = i;
            break
        end
    end
    
    R2 = rand;          %iterasi pemilihan parent 2
    for j = 1:npop
        if R2 < p_cumulative(j)
            idx_par2 = j;
            break
        end
    end
      fprintf('parent 1 model %2d ,parent 2 model %2d \n', ...
    idx_par1,idx_par2); %showing the parents

    %cross over
     ioff = npop/2 + ipop;
    R = rand;
    if R > p_crs    %tidak terjadi cross-over
        off_spr(ipop) = model(idx_par1);
        off_spr(ioff) = model(idx_par2);
    else
        R1 = rand;
        off_spr(ipop) = model(idx_par1)*R1 + model(idx_par2)*(1-R1);
        off_spr(ioff) = model(idx_par1)*(1-R1) + model(idx_par2)*R1;
    end
end

model=off_spr;
for i=1:length(model)
    a=model(i);
    offs(i)=peak_1D(a);
end
clf
plot(x,y)
hold on
plot(model,offs,'*')%plot hasil model 
xlabel('X')
ylabel('Y')
legend('peak 1D','offsprings')
title('Genetic Algorithm')
pause(1)
end
