function [] = draw_continents(file, R, fproj)
%Load data
uv = load(file);
u = uv(:,1);
v = uv(:,2);

%Project
[XC, YC] = fproj(R, u, v, 0);

%Draw
plot(XC, YC, 'b', 'LineWidth', 2);
