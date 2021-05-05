function [] = drawContinents(file_text, R, uk, vk, fproj, s_min)
data = load(file_text);
u = data(:,1); v = data(:,2);

%Convert to oblique aspect
[s, d] = uv_to_sd(u, v, uk, vk);

%Find points close to equator and remove
idx = find(s<s_min);
s(idx) = []; d(idx) = [];

%Project
[x,y] = fproj(R, s, d); 

%Plot continents
plot(x, y,'b', 'LineWidth', 3);