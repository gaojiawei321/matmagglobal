clear all;close all;clc
%curstal field Bx at Martian surface (nT)'
jg=180;
wg=90;
jing=linspace(-pi,pi,jg);
wei=linspace(-pi/2,pi/2,wg);
rm=6371;

%% calculate CALS7K2 model at surface year=-750
r=rm+00;
for i=1:jg-1
    for j=1:wg-1
       
        [x,y,z] = sph2cart(jing(i),wei(j),r);
        
        Bping(i,j,:)=CALS7k2_r([x y z]',-750);
        
        
    end
end
    bt=Bping(:,:,1);
    
    btz=bt';
    hb=[btz(:,90:179) btz(:,1:89)];
    
    x1=2:2:358;
    y1=-88:2:88;
    
 %{   
    
pcolor(x1,y1,hb)
shading interp 
colormap jet
xlabel('longitude')
ylabel('latitude')
title('curstal field Bx at Martian surface (nT)')
pos=[0 0 30 15];
colorbar

set(gca,'FontSize',20)


set(gcf,'PaperPositionMode','manual','PaperUnits','centimeters',...
        'PaperPosition',pos,'units','centimeters','position',pos);

%print('-dtiff ','-r600',[ 'C:\Users\Dell\Desktop\','surface_x.tiff'])
%}
%%
figure
ax1=axes('position',[0.1,0.1,0.8,0.8])  ;
axesm apianus; 
framem;
gridm;
axis off


aj=2
geoidrefvec=[1/aj,90,180];  
%B=geoshow(hb, geoidrefvec, 'DisplayType', 'texturemap'); hold on;

B1=geoshow(hb, geoidrefvec, 'DisplayType', 'texturemap'); hold on;


title('CALS7K.2 Br 750 BC')
caxis([-50000 50000]);
colormap jet

c1=colorbar

set(get(c1,'Xlabel'),'String','B (nT)','FontSize',10)


load topo
axesm apianus; 

[c,h] = contourm(topo,[1,90,180],-40000:20000:40000,'k'); hold on;



   pos=[1 1 20 15];
set(gcf,'unit','centimeters','position',pos)


  set(gcf,'PaperPositionMode','manual','PaperUnits','centimeters',...
        'PaperPosition',pos);
     
    
print('-dtiff ','-r600',[ '/Users/gaojiawei/Desktop/','7k2_750.tiff'])


%%
%{

close all; clear; clc
load coast;


Long=long;

z1=find(long<0);
Long(z1)=360+long(z1);



%绘制中国岸线
plot(Long,lat,'color',[0,0,0],'LineWidth',1);hold on;
axis equal;axis tight;grid on;
set(gca,'fontname','Time New Romans','fontsize',10,...
 'tickdir','out','ticklength',[0.02,0.02],...
 'gridlinestyle','-.','linewidth',0.1,...
'xtick',[70:20:140],'ytick',[0:10:60],...
'xticklabel',{'70E ','90E','110E','130E'},...
 'yticklabel',{'0 ','10N','20N','30N','40N','50N','60N'});
xlabel('Longitude');
ylabel('Latitude');
%设置只显示中国范围
%xlim([70 140]);


%%


load topo
axesm apianus; 

[c,h] = contourm(topo,[1,90,180],-40000:20000:40000,'k'); hold on;


%}

