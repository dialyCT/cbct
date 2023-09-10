function [filter_proj] = RL_filter(proj,dNum,dSize)
%对投影补dNum-1个零，长度变为2*dNum-1————————————
pproj=[proj,zeros(1,dNum-1)];
%生成滤波器——————————————————
H1=zeros(1,dNum);
for i=0:1:dNum-1
   if (i)==0
       H1(1,i+1)=1/(4*dSize^2);
   elseif mod(i,2)==0
       H1(1,i+1)=0;
   elseif mod(i,2)==1
       H1(1,i+1)=-1/(i*pi*dSize)^2;
   end
end
plot(real(H1))
H2=H1(1,dNum:-1:1);
H=[H1,H2(1,1:dNum-1)];
H=real(fft(H));
plot(H)
filter_pproj=real(ifft(fft(pproj).*H));
filter_proj=filter_pproj(1,1:dNum);
end

