%设置参数
param.views=360;
param.da=2*pi/param.views;
param.Detector_xnum=512;
param.Detector_xpixel=7.4*1e-3;%mm
param.Detector_ynum=512;
param.Detector_ypixel=7.4*1e-3;%mm
param.sod=330;%mm
param.sdd=680;%mm
param.img_xnum=256;
param.img_xpixel=(param.sod/param.sdd)*(param.Detector_xnum*param.Detector_xpixel/param.img_xnum);
param.img_ynum=256;
param.img_ypixel=(param.sod/param.sdd)*(param.Detector_ynum*param.Detector_ypixel/param.img_ynum);
param.img_znum=256;
param.img_zpixel=param.img_xpixel;
%设置探测器坐标——————————————————————————————————————————————————
temp=[-param.Detector_xnum*param.Detector_xpixel/2+param.Detector_xpixel/2:param.Detector_xpixel:param.Detector_xnum*param.Detector_xpixel/2-param.Detector_xpixel/2];
temp1=[-param.Detector_ynum*param.Detector_ypixel/2+param.Detector_ypixel/2:param.Detector_ypixel:param.Detector_ynum*param.Detector_ypixel/2-param.Detector_ypixel/2];
[param.detY,param.detX]=meshgrid(temp1,temp);
param.detZ=ones(param.Detector_xnum,param.Detector_ynum).*param.sdd;
%设置图像坐标————————————————————————————————————————————————————————————
itempx=[-param.img_xnum*param.img_xpixel/2+param.img_xpixel/2:param.img_xpixel:param.img_xnum*param.img_xpixel/2-param.img_xpixel/2];
itempy=[-param.img_ynum*param.img_ypixel/2+param.img_ypixel/2:param.img_ypixel:param.img_ynum*param.img_ypixel/2-param.img_ypixel/2];
itempz=[-param.img_znum*param.img_zpixel/2+param.img_zpixel/2:param.img_zpixel:param.img_znum*param.img_zpixel/2-param.img_zpixel/2]+param.sod;
[param.imgY,param.imgX,param.imgZ]=meshgrid(itempy,itempx,itempz);
