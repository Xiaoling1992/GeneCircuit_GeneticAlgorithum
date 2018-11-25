function score=fitscoreXZ(A,in_vector,out_vector,dimen)
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
in=in';


score=fitness2log(t1a,out,f_desire(t1a));
end
