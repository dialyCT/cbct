%FDK_main
set_rebuild_param;
rec=zeros(param.img_xnum,param.img_ynum,param.img_znum);
for view=0:1:param.views-1
    disp(view)
    rec=rec+ FDK(proj(:,:,view+1),view,param).*(param.da*param.Detector_ypixel);
end
rec(rec<0)=0;