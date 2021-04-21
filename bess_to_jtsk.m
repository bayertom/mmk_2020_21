function [x, y] = bess_to_jtsk(fi_b_deg, lam_b_deg)
fi_b = fi_b_deg*pi/180;
lam_b = lam_b_deg*pi/180;

%Bessel ellipsoid
a_b = 6377397.155;
b_b = 6356078.9633;
e2_b = (a_b^2 - b_b^2)/(a_b^2);

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