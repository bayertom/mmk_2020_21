function [x, y] = wgs_to_jtsk(fi_deg, lam_deg)
fi = fi_deg*pi/180;
lam = lam_deg*pi/180;

%WGS-84
a_w = 6378137;
b_w = 6356752.3142;

%(fi, lam)_WGS-84 -> (X,Y,Z)_WGS-84 
e2_w = (a_w*a_w-b_w*b_w)/(a_w*a_w);
W_w = sqrt(1-e2_w*(sin(fi))^2);
N_w = a_w/W_w;

%Spatial coordinates, WGS-84
X_w = N_w*cos(fi)*cos(lam);
Y_w = N_w*cos(fi)*sin(lam);
Z_w = N_w*(1-e2_w)*sin(fi);

%Rotations (3)
om_x = 4.9984/3600*pi/180;
om_y = 1.5867/3600*pi/180;
om_z = 5.2611/3600*pi/180;

%Scale + shifts (4)
m = 1 - 3.5623e-6;
d_x = -570.8285;
d_y = -85.6769;
d_z = -462.8420;

%Rotation matrix
R = [1 om_z -om_y; -om_z 1 om_x; om_y -om_x 1];

%Shifts
D = [d_x; d_y; d_z];

%Point p
P_w= [X_w;Y_w;Z_w];

%Similarity transformation (Helmert)
P_B = m*R*P_w+D;

%Spatial coordinates, Bessel
X_B = P_B(1);
Y_B = P_B(2);
Z_B = P_B(3);

%Bessel ellipsoid
a_b = 6377397.155;
b_b = 6356078.9633;
e2_b = (a_b^2 - b_b^2)/(a_b^2);

%(X,Y,Z)_Bess -> (lat, lon)_Bess
lam_b = atan2(Y_B,X_B);
lam_b_deg = lam_b * 180 / pi;

fi_b = atan(Z_B/((1-e2_b)*sqrt(X_B^2 + Y_B^2)));
fi_b_deg = fi_b * 180 / pi;

% (lat, lon)_Bess -> (u, v)_sphere
lam_F_deg = lam_b_deg + 17 + 2/3;
lam_F = lam_F_deg * pi/180;
fi_0 = 49.5 * pi/180;

%Constant values
alpha = sqrt(1 + e2_b * (cos(fi_0))^4/(1 - e2_b));
u_0=asin(sin(fi_0)/alpha);
k_c=(tan(fi_0/2+pi/4)^alpha*((1-sqrt(e2_b)*sin(fi_0))/...
    (1+sqrt(e2_b)*sin(fi_0)))^(alpha*sqrt(e2_b)/2));
k_j=tan(u_0/2+pi/4);
k=k_c/k_j;
R_g = (a_b*sqrt(1-e2_b))/(1-e2_b*(sin(fi_0))^2);

%Gaussian conformal projection
u_r =((tan(fi_b/2 + pi/4)*((1-sqrt(e2_b)*sin(fi_b))/...
    (1+sqrt(e2_b)*sin(fi_b)))^(sqrt(e2_b)/2))^alpha)/k;
u = 2*atan(u_r)-pi/2;
u_deg = u * 180/pi;
v = alpha*lam_F;
v_deg = v * 180/pi;

%(u, v) -> (s, d)
uk = 59 + 42/60 + 42.6969/3600;
vk = 42 + 31/60 + 31.41725/3600;
[s_deg,d_deg]= uv_to_sd(u_deg, v_deg, uk, vk);
s = s_deg * pi/180;
d = d_deg * pi/180;

%Lambert conformal conic projection
s_0=78.5*pi/180;
c = sin(s_0);
ro_0 = 0.9999*R_g*cot(s_0);
ro = ro_0*((tan(s_0/2+pi/4))/(tan(s/2+pi/4)))^c;
eps = c*d;

%(ro, eps) -> (x, y)
x = ro*cos(eps);
y = ro*sin(eps);