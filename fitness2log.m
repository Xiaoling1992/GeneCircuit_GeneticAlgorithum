function score=fitness2log(t,out_signal,f_desire)  %f_desire(t) is the desired output functin. 2*heaviside(t-100) is a step function.
 out_desire=f_desire;              %out_desire(t) is the vector of desired output.         
 diff=abs(log(out_signal+0.000001)-log(out_desire+0.000001)); 
  delta_t=t(2:end)-t(1:end-1);
   score=sum(delta_t.*diff(2:end));
end
 
 
 
 
