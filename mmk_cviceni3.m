clc
clear
format long g

%Point
lat = 0 * pi / 180;
lon = 15 * pi / 180;

%WGS-84
a_w = 6378137;
b_w = 6356352.3142;

%Bessel elipsoid
a_B = 6377397.155;
b_B = 6356078.963;
e2_B = (a_B*a_B - b_B*b_B)/(a_B*a_B);

%Local approximation
e2_w = (a_w*a_w-b_w*b_w)/(a_w*a_w);
W_w = sqrt(1-e2_w*(sin(lat))^2);
M_w = a_w * (1-e2_w) / W_w^3;
N_w = a_w/W_w;

R1 = sqrt(M_w * N_w);

%Analogous volume
R2 = (a_w^2 * b_w)^(1/3);

%Analogous area
R3 = b_w * (1 + 2/3 * e2_w + 3/5 * e2_w^2 + 4/7 * e2_w^3 + 5/9 * e2_w^4)^(0.5);

%Average
R4 = (2 * a_w + b_w) / 3;