clear all;close all;clc
%curstal field Bx at Martian surface (nT)'
jg=180;
wg=90;
jing=linspace(-pi,pi,jg);
wei=linspace(-pi/2,pi/2,wg);
rm=6371;
time=1950-40977;
r=rm+00;
for i=1:jg-1
    for j=1:wg-1
       
        [x,y,z] = sph2cart(jing(i),wei(j),r);
        
        Bping(i,j,:)=LSMOD2_r([x y z]',time);
        
        
    end
end
    bt=(Bping(:,:,1).^2+Bping(:,:,2).^2+Bping(:,:,3).^2).^0.5;
    
    btz=bt';
    hb=[btz(:,90:179) btz(:,1:89)];
    
    x1=2:2:358;
    y1=-88:2:88;
    
    
    
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


title(['LSMOD2 Bt ',num2str(time),' BC'])
caxis([0 20000]);
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
     
    
%print('-djpeg','-r600',[ '/Users/gaojiawei/Desktop/','LSM_Bt_-40ka.jpg'])

print('-depsc','-r600',[ '/Users/gaojiawei/Desktop/','LSM_Bt_-40ka.eps'])



