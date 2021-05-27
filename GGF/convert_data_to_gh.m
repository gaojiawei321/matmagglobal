function [g_dict,h_dict]=convert_data_to_gh(data,lmax)
%CONVERT_DATA_TO_GH Summary of this function goes here
%   Detailed explanation goes here


g=zeros(lmax+1,lmax+1);
h=zeros(lmax+1,lmax+1);

g(1,2)=data(1);

g(2,2)=data(2);

h(1,2)=0;

h(2,2)=data(3);

i=3;

for l=2:lmax
   
    g(1,l+1)=data(i+1);
    i=i+1;
    
    h(1,l+1)=0;
    
    
    for m=1:l
        
        g(m+1,l+1)=data(i+1);
        i=i+1;
        
        h(m+1,l+1)=data(i+1);
        i=i+1;
    end

end


g_dict=g;
h_dict=h;

end



