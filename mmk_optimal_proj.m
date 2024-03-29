clc
clear
format long g
 
%Analyzovane uzemi: Nepal

% *** ZOBRAZENI 1: MERCATOR ***

%Body na ortodrome (kartograficky rovnik)
u_1 = 29.3772 * pi / 180;
v_1 = 81.0166 * pi / 180;
u_2 = 27.0181 * pi / 180;
v_2 = 87.2089 * pi / 180;

%Bod na okraji
u_3 = 27.9378 * pi / 180;
v_3 = 88.0767 * pi / 180;

%Kartograficky pol
v_k = atan2(tan(u_1)*cos(v_2)-tan(u_2)*cos(v_1),...
     tan(u_2)*sin(v_1)-tan(u_1)*sin(v_2));
v_k_deg = v_k *180/pi;
u_k = atan(-(cos(v_1-v_k)/tan(u_1)));
u_k_deg = u_k*180/pi;

%Prevod (u, v) -> s, K = [uk, vk]
s_1 = asin(sin(u_1)*sin(u_k) + cos(u_1)*cos(u_k)*cos(v_1 - v_k));
s_1_deg = s_1*180/pi;
s_2 = asin(sin(u_2)*sin(u_k) + cos(u_2)*cos(u_k)*cos(v_2 - v_k));
s_2_deg = s_2*180/pi;
s_3 = asin(sin(u_3)*sin(u_k) + cos(u_3)*cos(u_k)*cos(v_3 - v_k));
s_3_deg = s_3*180/pi;

%Nezkreslena rovnobezka
s_0=acos(2*cos(s_3)/(1+cos(s_3)));
s_0_deg=s_0*180/pi;

%Meritka (rovnik a okraj)
mr_1 = cos(s_0)/cos(s_1);
mr_2 = cos(s_0)/cos(s_2);
mr_3 = cos(s_0)/cos(s_3);

%Zkresleni (rovnik a okraj) v m
ny_1 = (mr_1 - 1)*1000;
ny_2 = (mr_2 - 1)*1000;
ny_3 = (mr_3 - 1)*1000;

% *** ZOBRAZENI 2: LCC ***
R = 6380

%Kartograficky pol
u_k = 42.8925/180*pi;
v_k = 92.1783/180*pi;

%Okrajove body
u_1 = 28.6883/180*pi;
v_1 = 80.1414/180*pi;
u_2 = 29.3125/180*pi;
v_2 = 83.9951/180*pi;

%Prevod (u, v) -> s, K = [uk, vk]
s_1 = asin(sin(u_1)*sin(u_k) + cos(u_1)*cos(u_k)*cos(v_1 - v_k));
s_1_deg = s_1*180/pi;
s_2 = asin(sin(u_2)*sin(u_k) + cos(u_2)*cos(u_k)*cos(v_2 - v_k));
s_2_deg = s_2*180/pi;

%Konstanta c
c = (log10(cos(s_2))-log10(cos(s_1)))/...
    (log10(tan(s_1/2+pi/4))- log10(tan(s_2/2+pi/4)));

%Vypocet s0
s_0 = asin(c);
s_0_deg = s_0*180/pi;

%Vypocet ro0
ro_0_cit = 2*R*cos(s_0)*cos(s_2)*(tan(s_2/2+pi/4))^c;
ro_0_jme = c*(cos(s_0)*(tan(s_0/2+pi/4))^c +...
              cos(s_2)*(tan(s_2/2+pi/4))^c);
ro_0 = ro_0_cit/ro_0_jme;

%Polomer severni a jizni rovnobezky
ro_1 = ro_0*(tan(s_0/2+pi/4)/tan(s_1/2+pi/4))^c;
ro_2 = ro_0*(tan(s_0/2+pi/4)/tan(s_2/2+pi/4))^c;

%Meritka na severnim/jiznim okraji a ve stredu
mr_1 = c*ro_1/(R*cos(s_1));
mr_2 = c*ro_2/(R*cos(s_2));
mr_0 = c*ro_0/(R*cos(s_0));

%Zkresleni na severnim/jiznim okraji a ve stredu v m
ny_1 = (mr_1-1)*1000;
ny_2 = (mr_2-1)*1000;
ny_0 = (mr_0-1)*1000;

% *** ZOBRAZENI 3: STEREOGRAFICKA PROJEKCE ***
u_k = 28.0824 * pi / 180;
v_k = 84.2206 * pi / 180;
u_1 = 28.8564 * pi / 180;
v_1 = 80.0834 * pi / 180;

%Prevod (u, v) -> s, K = [uk, vk]
s_1 = asin(sin(u_1)*sin(u_k) + cos(u_1)*cos(u_k)*cos(v_1 - v_k));
s_1_deg = s_1*180/pi;

%Doplnek kart. sirky do 90°
psi_1 = pi/2 - s_1;
psi_1_deg = psi_1 * 180 / pi;

%Multiplikacni konstanta
mju = (2*(cos(psi_1/2))^2)/(1+(cos(psi_1/2))^2);

%Nezkreslena rovnobezka
psi_0 = 2*acos(sqrt(mju));
psi_0_deg = psi_0 *180/pi;

s_0 = pi/2 - psi_0;
s_0_deg = s_0 *180/pi;

%Meritko na jiznim okraji, polu a nezkreslene rovnobezce
mr_1 = mju/(cos(psi_1/2))^2;
mr_2 = mju/(cos(0/2))^2;
mr_0 = mju/(cos(psi_0/2))^2;

%Zkresleni na jiznim okraji, polu a nezkreslene rovnobezce
ny_1 = (mr_1-1)*1000;
ny_2 = (mr_2-1)*1000;
ny_0 = (mr_0-1)*1000;

% *** GENEROVANI IZOCAR: STEREOGRAFICKA PROJEKCE ***
%Min-max box
umin = 26; umax = 31;
vmin = 80; vmax = 89;
Du = 0.5; Dv = 0.5;
du = Du/10; dv = Dv/10;
fproj = @stereo
u_k_deg = u_k * 180/pi;
v_k_deg = v_k * 180/pi; 

%Sit poledniku, rovnobezek
[XM, YM, XP, YP] = mygraticule(umin, umax, vmin, vmax, Du, Dv, du, dv, R, fproj, u_k_deg, v_k_deg, s_0_deg)

%Vykresleni site
plot(XM',YM', 'black');
hold on;
plot(XP',YP', 'black');

%Vytvoreni meshgridu
[u,v] = meshgrid(umin:du:umax,vmin:dv:vmax);

%Prevod (u, v) -> s, K = [uk, vk]
[s_deg,d_deg] = uv_to_sd(u,v,u_k_deg, v_k_deg);
psi_deg = 90 - s_deg;
psi = psi_deg * pi/180;

%Stereograficka projekce
[X_c,Y_c] = stereo(R, s_deg, d_deg, s_0_deg);

%Meritko a zkresleni
mr_c = mju./(cos(psi/2)).^2;
ny_c = (mr_c-1)*1000;

%Izocary s krokem 0.1 + popis
[C, h] = contour(X_c, Y_c,ny_c, [-1:0.1:1], 'LineColor', 'r');
clabel(C, h, 'Color', 'r');

%Nacteni souradnic Nepalu
uv = load('nepal.txt');
u_n = uv(:, 1);
v_n = uv(:, 2);

%Prevod (u, v) -> s, K = [uk, vk]
[s_n,d_n] = uv_to_sd(u_n, v_n, u_k_deg, v_k_deg);

%Stereograficka projekce
[X_n,Y_n] = stereo(R, s_n, d_n, s_0_deg);

%Vykresleni
plot(X_n',Y_n', 'b', 'LineWidth', 2);

axis equal
