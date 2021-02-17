function [s, d] = uv_to_sd(u, v, uk, vk)

%Convert degrees do radians
ur=u/180*pi;
vr=v/180*pi;
ukr=uk/180*pi;
vkr=vk/180*pi;

%Longitude difference
dv = vkr-vr;

%Cartographic latitude
s = asin (sin (ur)*sin (ukr)+ cos (ur)*cos (ukr)*cos(dv))/pi*180;

%Cartographic longtitude
num = cos(ur)*sin(dv);
denom = cos(ur)*sin(ukr)*cos(dv)-sin(ur)*cos(ukr);
d = atan2(num,denom)/pi*180;

end