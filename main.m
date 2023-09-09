clc
clear
%三维锥束正投影模拟 by dly————————————————————————————————————————————
%设置模体
phan = double(phantom3dAniso('modified shepp-logan', 256));
%设置参数
views=360;
da=2*pi/views;
Detector_xnum=512;
Detector_xpixel=7.4*1e-3;%mm
Detector_ynum=512;
Detector_ypixel=7.4*1e-3;%mm
sod=330;%mm
sdd=680;%mm
img_xnum=256;
img_xpixel=(sod/sdd)*(Detector_xnum*Detector_xpixel/img_xnum);
img_ynum=256;
img_ypixel=(sod/sdd)*(Detector_ynum*Detector_ypixel/img_ynum);
img_znum=256;
img_zpixel=img_xpixel;
%设置探测器坐标——————————————————————————————————————————————————
temp=[-Detector_xnum*Detector_xpixel/2+Detector_xpixel/2:Detector_xpixel:Detector_xnum*Detector_xpixel/2-Detector_xpixel/2];
temp1=[-Detector_ynum*Detector_ypixel/2+Detector_ypixel/2:Detector_ypixel:Detector_ynum*Detector_ypixel/2-Detector_ypixel/2];
[detY,detX]=meshgrid(temp1,temp);
detZ=ones(Detector_xnum,Detector_ynum).*sdd;
%设置图像坐标————————————————————————————————————————————————————————————
itempx=[-img_xnum*img_xpixel/2+img_xpixel/2:img_xpixel:img_xnum*img_xpixel/2-img_xpixel/2];
itempy=[-img_ynum*img_ypixel/2+img_ypixel/2:img_ypixel:img_ynum*img_ypixel/2-img_ypixel/2];
itempz=[-img_znum*img_zpixel/2+img_zpixel/2:img_zpixel:img_znum*img_zpixel/2-img_zpixel/2]+sod;
[imgY,imgX,imgZ]=meshgrid(itempy,itempx,itempz);

%设置采样点坐标——————————————————————————————————————————————————————————
dz=0.5*img_zpixel;
zvalue_point=[sod-img_znum*img_zpixel/2:dz:sod+img_znum*img_zpixel/2];
%计算探测器上的点到中心的距离,sin,cos值
distance_array=compute_distance(0,0,detX,detY);
sinValue=detX./distance_array;
cosValue=detY./distance_array;
distance1=zeros(Detector_xnum,Detector_ynum,length(zvalue_point));
for i=1:1:length(zvalue_point)
    distance1(:,:,i)=(zvalue_point(i)/sdd).*distance_array;
end
intX=distance1.*sinValue;
intY=distance1.*cosValue;
zvalue_point1=reshape(zvalue_point,1,1,length(zvalue_point));
intZ=zvalue_point1.*ones(Detector_xnum,Detector_ynum);
tmp=intZ(:,:,128);
%正投影——————————————————————————————————————————————————————————————
proj=zeros(Detector_xnum,Detector_ynum,views);
lay_proj=zeros(views,Detector_ynum);
%旋转的时候，采样点的x坐标不变
tmp_intZ=intZ-sod;
for view=0:1:views-1
    disp(view)
    phi=da*view;
    intY1=intY.*cos(phi)-tmp_intZ.*sin(phi);
    intZ1=intY.*sin(phi)+tmp_intZ.*cos(phi);
    intZ1=intZ1+sod;
   value= interp3(imgY,imgX,imgZ,phan,intY1,intX,intZ1,'linear',0);
   proj(:,:,view+1)=sum(value,3).*dz;
   tmp=sum(value,3).*dz;
   lay_proj(view+1,:)=tmp(50,:);
end
