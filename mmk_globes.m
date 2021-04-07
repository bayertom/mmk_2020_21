clc
clear
axis equal

%Input parameters
R = 6380 *1000;
fproj = @gnom;
u1 = 20;
u2 = 90;
v1 = -180;
v2 = 180;
Du = 10;
Dv = 10;
du = 5;
dv = 5;
uk = 90;
vk = 0;

% %Create graticule
% [XM, YM, XP, YP] = mygraticule(u1, u2, v1, v2, Du, Dv, du, dv, R, fproj, uk, vk);
% 
% %Draw graticule
% hold on;
% plot(XM',YM','k');
% plot(XP',YP','k');
% 
% %Continents
% eu = load('eur.txt');
% u_eu = eu(:,1);
% v_eu = eu(:,2);
% 
% %Oblique aspect
% [s_eu, d_eu] = uv_to_sd(u_eu, v_eu, uk, vk);
% 
% %Remove unsuitable points
% idx = find(s_eu<u1);
% s_eu(idx) = [];
% d_eu(idx) = [];
% 
% %Project and draw
% [x_eu,y_eu] = fproj(R, s_eu, d_eu); 
% plot(x_eu,y_eu,'b', 'LineWidth', 3);
% 
% %Set limits for drawing
% cmin = -2*R;
% cmax = -cmin;
% xlim([cmin, cmax]); ylim([cmin, cmax]); 

%Face 1 (90, 0)
uk = 90;
vk = 0;
ur = 35.2644;
urj = -ur;

%Boundary points + limits
u1b = ur; v1b = 0;
u2b = ur; v2b = 90;
u3b = ur; v3b = 180;
u4b = ur; v4b = 270;
ub = [u1b, u2b, u3b, u4b];
vb = [v1b, v2b, v3b, v4b];
u1 = 20; u2 = 90; v1 = -180; v2 = 180;

subplot(2, 3, 1);
myGlobeFace(ub, vb, u1, u2, v1, v2, Du, Dv, du, dv, R, fproj, uk, vk);

%Face 2 (0, 45)
uk = 0;
vk = 45;

%Boundary points + limits
u1b = ur; v1b = 0;
u2b = ur; v2b = 90;
u3b = urj; v3b = 0;
u4b = urj; v4b = 90;
ub = [u1b, u2b, u3b, u4b];
vb = [v1b, v2b, v3b, v4b];
u1 = -60; u2 = 60; v1 = -100; v2 = 100;

subplot(2, 3, 2);
myGlobeFace(ub, vb, u1, u2, v1, v2, Du, Dv, du, dv, R, fproj, uk, vk);
