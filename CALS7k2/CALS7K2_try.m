clear;close;clc


t=-750;  %year 。（ -98050 to 1990  )


ge=14;

rm=3480*ones(1,ge);   %calculate B at CMB in KM

Az=10*ones(1,ge);   % longitude is -10 deg

El=linspace(-80,90,ge);% latitude [-90 - 90]

%El=-90:1:90;   

az=Az/180*pi;   % change to arc
el=El/180*pi;

h=0;

[lx,ly,lz] = sph2cart(az,el,h+rm); 
%Transform spherical coordinates to Cartesian


a=[lx;ly;lz];
% a is the location.

bpc=CALS7k2_r(a,t)';
% calculate magnetic field B and location a in year t.

col=90-El;
plot(col,bpc(:,1))
%xlim([-90 90])

%set(gca,'XDir','reverse'); 

grid on;

title('R=3480 km Meridional Slice of Br,  10deg W, Time=-750 year')


xlabel('colatitude')
ylabel('Br (nanotesla)')

%%
   
   pos=[1 1 20 15];
set(gcf,'unit','centimeters','position',pos)


  set(gcf,'PaperPositionMode','manual','PaperUnits','centimeters',...
        'PaperPosition',pos);
     
    
print('-dtiff ','-r600',[ '/Users/gaojiawei/Desktop/','7k2_cmb1.tiff'])

%print('-dtiff ','-r600',[ '/Users/gaojiawei/Desktop/','ggf1_sur1.tiff'])








