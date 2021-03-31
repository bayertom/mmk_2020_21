clc
clear

syms R u v

%Gnomonic projection
x = R*tan(pi/2-u)*cos(v);
y = R*tan(pi/2-u)*sin(v);

%Partial derivatives
fu = simplify(diff(x,u), 'Steps', 20);
fv = simplify(diff(x,v), 'Steps', 20);
gu = simplify(diff(y,u), 'Steps', 20);
gv = simplify(diff(y,v), 'Steps', 20);

%Scales (symbolic)
mp2=simplify((fu*fu + gu*gu)/(R*R),'Steps', 20);
mr2=simplify((fv*fv + gv*gv)/(R*R*cos(u)*cos(u)),'Steps', 20);
mr = simplify(sqrt(mr2), 'Steps',20);
mp = simplify(sqrt(mp2), 'Steps',20);
p=2*(fu*fv+gu*gv);

P1 = simplify((gu*fv - fu*gv)/(R^2*cos(u)), 'Steps',20);
P2 = simplify(mp * mr, 'Steps',50);
d_omega =simplify(2*asin (abs(mr-mp)/(mr+mp)), 'Steps',50);

%Numerical parameters
Rn = 6380;
un = 35.2644 * pi /180;
vn = 0;

%Substitution
xn = double(subs(x, {R, u, v}, {Rn, un, vn}));
yn = double(subs(y, {R, u, v}, {Rn, un, vn}));

%Partial derivatives, substitution
fun = double(subs(fu, {R, u, v}, {Rn, un, vn}));
fvn = double(subs(fv, {R, u, v}, {Rn, un, vn}));
gun = double(subs(gu, {R, u, v}, {Rn, un, vn}));
gvn = double(subs(gv, {R, u, v}, {Rn, un, vn}));

%Locl linear scales
mpn = double(subs(mp, {R, u, v}, {Rn, un, vn}));
mrn = double(subs(mr, {R, u, v}, {Rn, un, vn}));
pn = double(subs(p, {R, u, v}, {Rn, un, vn}));

%Area scale
Pn = double(subs(P1, {R, u, v}, {Rn, un, vn}));
Pn1 = double(subs(P2, {R, u, v}, {Rn, un, vn}));

%Direction (sigma_p)
sigma_p = vn;
sigma_r = pi/2-un;

%Maximum angular distortion
d_omegan = double(subs(d_omega, {R, u, v}, {Rn, un, vn}))*180/pi;

%Create and plot graticule
hold on
fproj = @gnom
Du = 10; Dv = 10;
du = 1; dv = 1;
uk = 90; vk = 0;
u1 = 20; u2 = 90;
v1 = -180; v2 = 180;

[XM,YM,XP,YP]=mygraticule(u1,u2,v1,v2,Du,Dv,du,dv,Rn,fproj,uk,vk);
plot(XM',YM','k');
plot(XP',YP','k');

%Ellipse
t = 0:pi/10:2*pi;
xe = mpn*cos(t)*1000;
ye = mrn*sin(t)*1000;
E = [xe; ye];

%Rotation matrix
ROT = [cos(sigma_p) -sin(sigma_p); sin(sigma_p) cos(sigma_p)];

%Rotated ellipse
ER = ROT*E; 

%Shifted and rotated ellipse
plot(ER(1, :) + xn,ER(2, :) + yn, 'r');

axis equal