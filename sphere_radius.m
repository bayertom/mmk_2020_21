clc
clear
format long g

%WGS-84
a_w = 6378137;
b_w = 6356752.3142;

%Point
fi = 50/180*pi;
lam = 15/180*pi;

%1. Local approximation R = sqrt(M * N)
e2_w = (a_w^2-b_w^2)/a_w^2;
W_w = sqrt(1-e2_w*(sin(fi))^2);
N_w = a_w/W_w;
M_w = a_w*(1-e2_w)/W_w^3;

R1 = sqrt(M_w*N_w)

%2. Analogous volume: Ve = Vs
R2 = (a_w^2*b_w)^(1/3)

%3. Average of semi-axes
R3 = (2*a_w+b_w)/3

%4. Semi-axis of ellipsoid
R4 = a_w
R5 = b_w

%5. Analogous area: Se = Ss
R6 = b_w*(1+2/3*e2_w+3/5*e2_w^2+4/7*e2_w^3+5/9*e2_w^4)^(1/2)



