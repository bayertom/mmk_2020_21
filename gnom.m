function [x, y]=gnom(R, u, v)
x = R * tan((90-u)*pi/180) .* cos(v*pi/180);
y = R * tan((90-u)*pi/180) .* sin(v*pi/180);
end