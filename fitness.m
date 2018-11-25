function score=fitness(t,out_signal,f_desire)  %f_desire(t) is the desired output functin. 2*heaviside(t-100) is a step function.
 out_desire=f_desire(t);              %out_desire(t) is the vector of desired output.         
 diff=abs(out_signal-out_desire); 
  delta_t=t(2:end)-t(1:end-1);
   score=sum(delta_t.*diff(2:end));
end
 
 
 
 
