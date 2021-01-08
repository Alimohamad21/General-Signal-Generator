X=[];
fs=input('Please enter the sampling frequency:');
start_time=input('Please enter the start time:');
end_time=input('Please enter the end time:');
breakpoints_count=input('Please enter the number of the breakpoints:');
breakpoints=zeros(1,breakpoints_count);
for i=1:breakpoints_count
    breakpoints(i)=input(sprintf('Please enter the position of breakpoint %d:',i));
    while breakpoints(i)<=start_time || breakpoints(i)>=end_time
        breakpoints(i)=input(sprintf('Please enter a valid position for breakpoint %d (between %d:%d) :',i,start_time,end_time));
    end
end
points=[start_time breakpoints end_time];
for i=1:length(points)-1 
   t_period=linspace(points(i),points(i+1),(points(i+1)-points(i))*fs);
   choice=input(sprintf('Please enter the number associated with the type of signal you want(1-DC 2-Ramp 3-General order polynomial 4-Exponential 5-Sinusoidal) for [%d:%d]:',points(i),points(i+1)));
   switch choice
       case 1
           amplitude=input('Please enter the amplitude of the DC signal:');
           X_period=amplitude*ones(1,((points(i+1)-points(i))*fs)); 
       case 2
           m=input('Please enter the slope of the ramp signal:');
           c=input('Please enter the intercept of the ramp signal:');
           X_period=m*t_period+c;
       case 3
           amplitude=input('Please enter the amplitude of the polynomial signal:');
           order=input('Please enter the order of the polynomial:');
           equation='';
           for j=order:-1:1
               coefficient=input(sprintf('Please enter the coefficeint of t^%d:',j));
               equation=strcat(equation,sprintf('%d*(t_period.^%d)+',coefficient,j));
           end
           c=input(sprintf('Please enter the intercept (coefficeint of t^0):'));
           equation=strcat(equation,sprintf('%d',c));
           X_period=amplitude*(eval(equation));
       case 4
           amplitude=input('Please enter the amplitude of the exponential signal:');
           a=input('Please enter the exponent of the exponential signal:');
           X_period=amplitude*exp(a*t_period);
       case 5
             amplitude=input('Please enter the amplitude of the sinusoidal signal:');
             f=input('Please enter the frequency of the sinusoidal signal:');
             phase=input('Please enter the phase of the sinusoidal signal (in degrees):');
             phase=(phase*pi)/180;
             X_period=amplitude*sin(2*pi*f*t_period+phase);
   end
   X=[X X_period]; 
end
t=linspace(start_time,end_time,(end_time-start_time)*fs);
original_t=t;
original_X=X;
plot(t,X);
while true
     choice=input('Please enter the number associated with the operation you want on the signal(1-Amplitude scaling 2-Time reversal 3-Time shift 4-Expansion 5-Compression 6-reset operations(restore original signal) 7-None(Exit) ):');
     switch choice
       case 1
           scale=input('Please enter the value of the amplitude scale:');
           X=X*scale;
           figure;
           plot(t,X);
       case 2
           t=-t;
           figure;
           plot(t,X);
       case 3
           shift=input('Please enter the value of the shift:');
           t=t+shift;
           figure;
           plot(t,X);
       case 4
           a=input('Please enter the value of the expansion:');
           t=t*a;
           figure;
           plot(t,X);
       case 5
           a=input('Please enter the value of the compression:');
           t=t/a;
           figure;
           plot(t,X);
       case 6
           t=original_t;
           X=original_X;
           figure;
           plot(original_t,original_X);
       case 7
           break
     end
end


