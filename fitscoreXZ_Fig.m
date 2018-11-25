function score=fitscoreXZ_Fig(A,in_vector,out_vector,dimen)
ye = [1 200/255 0];

% parameter=[
%             0.2    3.8     0.09    1.4
%             0.06    3.8     0.07    1.6
%             0.07    3.8     0.41    2.4
%           0.004    0.5     0.04    3.4
%           0.07    2.5     0.19    2.6
%           0.08    2.2      0.1    1.4
%             0.07    4.3     0.05    1.7
%              0.2    2.2     0.18    2.1
%             0.01    3.9     0.03      4
%              0.2    5.9     0.19    1.8
%             0.01    2.4     0.05    2.7
%            0.003    1.3     0.01    2.9
%     ];
% k0=parameter(1:dimen,1);
% k1=parameter(1:dimen,2)-parameter(1:dimen,1);
% Z=parameter(1:dimen,3);
% H=parameter(1:dimen,4);
% gamma=0.2*ones(dimen,1);

k0=0.001*ones(dimen,1);
k1=3*ones(dimen,1);
Z=1*ones(dimen,1);
H=4*ones(dimen,1);
gamma=0.2*ones(dimen,1);

% k0=0.2*ones(dimen,1);
% k1=3.8*ones(dimen,1);
% Z=0.09*ones(dimen,1);
% H=1.4*ones(dimen,1);
% gamma=0.2*ones(dimen,1);

% network=randi([0,1],3,3);
% network=[0 0 1;1 0 0;0 1 0];
% in_vector=[1,zeros(1,dimen-1)]';
% out_vector=[0,1,1]';
% out_vector=[zeros(1,dimen-1),1]';
% A=network;

TimLen=200;
f_in=@(t)[0.0013+(4.4-0.0013)*heaviside(t-TimLen/2)];
%f_in=@(t)[0.0013+(4.4-0.0013)*heaviside(t-100)-(4.4-0.0013)*heaviside(t-120)];
%f_desire=@(t)[0.001+(2-0.001)*heaviside(t-TimLen/2)-(2-0.001)*heaviside(t-TimLen/2-50)];
f_inhibit=@(p0,p1,p2,p3,xx)[p0+p1./(1+(xx./p2).^p3)];
%f_desire=@(t)[0.001+(2-0.001)*heaviside(t+10)-(2-0.001)*heaviside(t-TimLen/2)];
%f_desire=@(t)[0.001+(2-0.001)*heaviside(t-100)];
f_desire=@(t)[0.001+(2-0.001)*heaviside(t-TimLen/2)-(2-0.001)*heaviside(t-TimLen/2-50)];
%f_desire=@(t)[0.001+(2-0.001)*heaviside(t-40)-(2-0.001)*heaviside(t-80)+(2-0.001)*heaviside(t-120)-(2-0.001)*heaviside(t-160)];
%f_desire=@(t)[0.001+(2-0.001)*heaviside(t-100)-(2-0.001)*heaviside(t-125)+(2-0.001)*heaviside(t-150)-(2-0.001)*heaviside(t-175)];




X0 = zeros(dimen,1);
tspan = [0 TimLen]; % min
[t1a,X1a] = ode15s(@(t,X) modelXZ_F(t,X,A,in_vector,k0,k1,Z,H,gamma,f_in,f_inhibit),tspan,X0);

for i=1:length(t1a)
out(i)=sum(out_vector.*f_inhibit(k0,k1,Z,H,X1a(i,:)'));
end

in=f_in(t1a);
out=out';
in=in;

A1=[A,in_vector];
out_vector2=[out_vector',0]';
A2=[A1',out_vector2]';

% 3. Summary figure
figure; clf
fs = 9; fs2 = 7; lw = 2;
% A: One cell, plot T for the two protocols (like Fig 3d)
subplot(4,2,1)
imagesc(A2);
colorbar;
title('Netrowrk, input and output');

subplot(4,2,[3,5,7]);
m=0;
for i=[1:1:dimen]
    m=m+1;

if(i==dimen+2)
    semilogy(t1a,out,'r--');
    StrLen{m}=['Ouput'];
    hold on
elseif (i==dimen+1)
    semilogy(t1a,in,'b-.');
    StrLen{m}=['in'];
    hold on
else
    StrLen{m}=['X',num2str(i)];
    semilogy(t1a,X1a(:,i),'linewidth',lw);
hold on;
end
end


%xlim([0 70])
ylim([0.001 100])
xlabel('Time (min)','fontsize',fs)
ylabel('concentration','fontsize',fs)
legend(StrLen,'Location','northwest');
 %   'location','se','fontsize',fs)
%title('Traces','fontsize',fs)
set(gca,'fontsize',fs2)
xlabel('t');
ylabel('concentration');
%text(-15,20,'A','fontsize',fs2)

% C: Many cells, plot T for protocol b
subplot(4,2,[4,6,8])
h=semilogy(t1a,in,':',t1a,out,t1a,f_desire(t1a),'--');
%set(h,'color',ye);
set(h,'linewidth',lw);
%xlim([0 70])
%ylim([-40 60])
ylim([0.001 100])
xlabel('t','fontsize',fs)
ylabel('promoter activity','fontsize',fs)
legend('Input','Output','Desired Output','Location','northwest');

%title('Transform curve','fontsize',fs)
set(gca,'fontsize',fs2)
%text(-15,60,'C','fontsize',fs2)

%score=fitness_step(t1a,out);
%function score=fitness_same(t,out,HalfTime,middle)
score=fitness2log(t1a,out,f_desire(t1a));
%print(gcf,'-depsc2',['../figure/biofilm1RecPhi40Rho63.eps']);
%print('-clipboard','-dbitmap');

%figure(2)
%print(gcf,'curve_Nsci_Rstep_step_12.png','-dpng','-r300');
%figure(1)
%print(gcf,'distribution_Nsci_Rstep_step_12.png','-dpng','-r300');
%figure(999)
%print(gcf,'generation_Nsci_Rstep_step_12.png','-dpng','-r300');

end
