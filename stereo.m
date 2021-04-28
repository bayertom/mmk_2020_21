function [X,Y]=stereo(R, u, v, u_0)
%Substitution
psi= 90-u;
psi_rad= psi*pi/180;
psi_0= 90-u_0;
psi_0_rad= psi_0*pi/180;

%Constant value c
c = 2*R*(cos(psi_0_rad/2))^2;
ro = c * tan(psi_rad/2);
eps = v * pi/180;

%Coordinates
X = ro.*sin(eps);
Y = -ro.*cos(eps);

end