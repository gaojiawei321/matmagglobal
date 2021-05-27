clear; close;clc


load LSM_knots
load LSM_coeffs

cp1=LSM_coeffs(:,1)';


sp1 = spmak(LSM_knots,LSM_coeffs');  

%fnplt(sp1,'b-'); hold on


f2=fnval(sp1,-30000)

f1=fnval(sp1,-39027)



