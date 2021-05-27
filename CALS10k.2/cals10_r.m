function [bpcsph] = cals10_r(pc_xyz,time)
%cals10_r Summary of this function goes here
%cals10_r model to calculate magnetic field model
%Timing range is （8000 BC - 1990 AD)
%   Detailed explanation goes here

% get the Gaussian coefficient

    
[g,h] =cals10_get_gh_at_t(time);


%Earth radii is 6371.2
rplanet=6371.2; 

sz=size(pc_xyz);
num=sz(2); % get data num

%calculate nmax

% Azimuth Elevation r

[pcp, pct, pcr]=cart2sph(pc_xyz(1,:),pc_xyz(2,:),pc_xyz(3,:));
%Transform spherical coordinates to Cartesian
pct=pi/2-pct;
%pct is colatitude location 

bpcsph=zeros(num,3);
for i=1:num
    ans=sph_b(g,h,rplanet/pcr(i),pct(i),pcp(i));% calculate magnetic field using SH coefficient
    bpcsph(i,:)=ans;
end

bpcsph=bpcsph';
%bpcsph = 【Br Bt Bp】
             %colatitude
             
%bpc_xyz=datas2c(bpcsph(:,1),bpcsph(:,2),bpcsph(:,3),pct,pcp);

%bpc_xyz is magnetic field data in Cartesian coordinate

%bt=(bpc_xyz(1,:).^2+bpc_xyz(2,:).^2+bpc_xyz(3,:).^2).^0.5;


end

