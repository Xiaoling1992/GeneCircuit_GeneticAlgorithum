function dXdt =modelXZ_F(t,X,A,in_vector,k0,k1,Z,H,gamma,f_in,f_inhibit)
Kin=f_in(t);
dXdt =A*f_inhibit(k0,k1,Z,H,X)+in_vector*Kin-gamma.*X;
end


