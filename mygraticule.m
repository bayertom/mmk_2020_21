function[XM, YM, XP, YP] = mygraticule(u1, u2, v1, v2, Du, Dv, du, dv, R, fproj, uk, vk, s0)

%Parallels
XP =[]; YP =[];
for u=u1:Du:u2
    %Create parallel
    vp = v1:dv:v2;
    up = u*ones(1,length(vp));
    
    %Oblique aspect
    [sp,dp] = uv_to_sd(up,vp,uk,vk);

    %Project parallel
    [xp,yp] = fproj(R,sp,dp,s0);
    
    %Append row
    XP = [XP;xp];
    YP = [YP;yp];
end

%Meridians
XM =[]; YM =[];
for v=v1:Dv:v2
    %Create meridians
    um = u1:du:u2;
    vm = v*ones(1,length(um));
    
    %Oblique aspect
    [sm,dm] = uv_to_sd(um,vm,uk,vk);
    
    %Project meridian
    [xm,ym] = fproj(R,sm,dm,s0);
    
    %Append row
    XM = [XM;xm];
    YM = [YM;ym]; 
end
