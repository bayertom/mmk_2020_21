clc
clear

format long g

%Input point
fi = 50*pi/180;
lam = 15*pi/180;

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
b_b = 6356078.963;
e2_b = (a_b^2 - b_b^2)/(a_b^2);

%(X,Y,Z)_Bess -> (lat, lon)_Bess
lam_b = atan2(Y_B,X_B);
lam_b_deg = lam_b * 180 / pi;

fi_b = atan2(Z_B,(1-e2_b)*sqrt(X_B^2 + Y_B^2));
fi_b_deg = fi_b * 180 / pi;

% (lat, lon)_Bess -> (u, v)_sphere









