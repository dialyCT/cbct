function [delta_img] = FDK(proj,deg,param)
%proj:某一角度的投影图像
%对投影值加权--------------------------------------------------------------------------
weight_array=(param.sdd)./sqrt(param.sdd^2+(param.detY).^2+(param.detX).^2);
weight_proj=weight_array.*proj;
%对加权投影每行分别作滤波操作--------------------------------------------------------------------------------------
filter_weight_proj=zeros(size(weight_proj));
for i=1:1:param.Detector_xnum
     filter_weight_proj(i,:)=RL_filter(proj(i,:),param.Detector_ynum,param.Detector_ypixel);
end
%反投影操作-----------------------------------------------------------------------------------------------------
%计算图像像素点旋转后的坐标,imgX不变
phi=param.da*deg;
tmp_imgZ=param.imgZ-param.sod;
imgY1=param.imgY.*cos(phi)-tmp_imgZ.*sin(phi);
imgZ1=param.imgY.*sin(phi)+tmp_imgZ.*cos(phi);
imgZ1=imgZ1+param.sod;
%射线驱动反投影，计算对应的探测器坐标然后插值
D=(param.sdd./imgZ1).*sqrt(param.imgX.^2+imgY1.^2);
imgSin=param.imgX./sqrt(param.imgX.^2+imgY1.^2);
imgCos=imgY1./sqrt(param.imgX.^2+imgY1.^2);
img_detX=D.*imgSin;
img_detY=D.*imgCos;
delta_img = interp2(param.detY,param.detX,filter_weight_proj,img_detY,img_detX, 'linear', 0);
%对反投影加权
delta_img=delta_img.*(param.sdd^2./(param.sdd+imgY1).^2);
end

