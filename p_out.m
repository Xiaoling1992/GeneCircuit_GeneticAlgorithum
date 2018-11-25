function [ ki ] = p_out(pars)

k0 = pars(1);
km = pars(2);
Kj = pars(3);
nj = pars(4);
Nj = pars(5);

%Promoter production rate
%   Detailed explanation goes here

ki = k0 + km ./ ( 1 + (Nj ./ Kj).^nj );

end

