function [X,Y]=sinu(R, u, v, u0)

u_rad = u*pi/180;
v_rad = v*pi/180;

X = R*v_rad.*cos(u_rad);
Y = R*u_rad;

end
