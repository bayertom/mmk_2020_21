function[xm, ym, xp, yp] = mygraticule(u1, u2, v1, v2, Du, Dv, du, dv, R, proj)

%parallels
vp = v1:dv:v2;
up = u*ones(1,length(vp));


