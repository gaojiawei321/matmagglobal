function [g_dict,h_dict] = LSM2_get_gh_at_t(time)
%GUFM_GET_GH_AT_T Summary of this function goes here
%   get G H at a given time

%filename='gufm1_data.txt';

%[gt,tknts,lmax,nspl]=read_gufm_all(filename);



load LSM_coeffs.mat
load LSM_knots.mat

lmax=10;

if time<LSM_knots(3)|time>LSM_knots(end-3)
   %warning('Time is not in the time range!') 
   error('The time you chosen is outside this model')
end
    

sp1 = spmak(LSM_knots,LSM_coeffs');  

data=fnval(sp1,time);

[g_dict,h_dict]=convert_data_to_gh(data,lmax);
%convert_data_to_gh


end

