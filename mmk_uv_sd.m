clc
clear

%Quadrant I.
u = 50;
v = 15;
uk = 60;
vk = 20;
[s1,d1] = uv_to_sd(u, v, uk, vk);

%Quadrant II.
uk = 40;
[s2,d2] = uv_to_sd(u, v, uk, vk);

%Quadrant III.
u = 60;
v = 20;
uk = 50;
vk = 15;
[s3,d3] = uv_to_sd(u, v, uk, vk);

%Quadrant IV.
uk  = 65;
[s4,d4] = uv_to_sd(u, v, uk, vk);

