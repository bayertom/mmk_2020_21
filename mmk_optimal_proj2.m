clc
clear
format long g

%Meshgrid
u_min = -90;
u_max = 90;
v_min = -180;
v_max = 180;
% u_min = 50;
% u_max = 50;
% v_min = 15;
% v_max = 15;
du = 10;
dv = 10;
R = 6380;

[u,v] = meshgrid(u_min:du:u_max, v_min:dv:v_max);

%Sinusoidalni zobrazeni
[X,Y] = sinu(R,u,v,0);

%Zkresleni
mp_2=((v/180*pi).*sin(u/180*pi)).^2+1;
mr_2 = 1;
p = -2.*(v/180*pi).*sin(u/180*pi);

mp = sqrt(mp_2);
mr = sqrt(mr_2);

%Azimuty extremnich zkresleni
A1 = atan(-2./((v/180*pi).*sin(u/180*pi)))/2;
A2 = A1 + pi/2;

%Tissotova elipsa
a_2 = mp_2 .* (cos(A1)).^2 + mr_2 .* (sin(A1)).^2 +  p.*sin(A1).*cos(A1);
b_2 = mp_2 .* (cos(A2)).^2 + mr_2 .* (sin(A2)).^2 +  p.*sin(A2).*cos(A2);
a = sqrt(a_2);
b = sqrt(b_2);
m2_max = max(a_2,b_2);

%Airy kriterium
h_2A = ((a-1).^2 + (b-1).^2)/2;

%Komplexni kriterium
h_2C= (abs(a-1)+ abs(b-1))/2+abs(a./b -1);

%Globalni kriteria, ctverce
[m,n]=size(mp);
s = m*n;
H1_2_A = sum(sum(h_2A))/s;
H1_2_C = sum(sum(h_2C))/s;

P = cos(u*pi/180);
H2_2_A = sum(sum(P.*h_2A))/sum(sum(P));
H2_2_C = sum(sum(P.*h_2C))/sum(sum(P)); 

%Globalni kriteria
H1_A = sqrt(H1_2_A);
H1_C = sqrt(H1_2_C);
H2_A = sqrt(H2_2_A);
H2_C = sqrt(H2_2_C);

%Kresba geograficke site
Du = 10; Dv = 10;
du = Du/20; dv = Dv/20;
fproj = @sinu
u_k =90; v_k = 0;
u_0= 0;

[XM, YM, XP, YP] = mygraticule(u_min, u_max, v_min, v_max, Du, Dv,...
                               du, dv, R, fproj, u_k, v_k, u_0);
hold on
plot(XM',YM', 'k');
plot(XP',YP', 'k');

%Kresba kontinentu
draw_continents('eur.txt',R, fproj);
draw_continents('amer.txt',R, fproj);
draw_continents('austr.txt',R, fproj);
draw_continents('anta.txt',R, fproj);

%Izocary a s krokem 0.5
[C_a, h_a] =contour(X, Y, sqrt(m2_max), [1:0.3:5], 'LineColor', 'r', 'LineWidth', 2);
clabel(C_a, h_a, 'Color','r', 'labelspacing', 1000);

%Vypocet meritkoveho cisla
M = 100000000./sqrt(m2_max);

%Izocary M s krokem 10 000 000
[C_M, h_M] =contour(X, Y, M, [20000000:10000000:100000000], 'LineColor', 'g', 'LineWidth', 2);
clabel(C_M, h_M, 'Color','g', 'labelspacing', 1000);

%Vypocet maximalniho uhloveho zkresleni
delta_omega = 2*asin(abs(b-a)./(b+a))*180/pi;

%Izocary maximalniho uhloveho zkresleni s krokem 10 deg + popis
[C_d, h_d] = contour(X, Y, delta_omega, [0:10:180], 'LineColor', 'm', 'LineWidth', 2);
clabel(C_d, h_d, 'Color', 'm','labelspacing', 700);

axis equal



axis equal




