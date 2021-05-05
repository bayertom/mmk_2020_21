clc
clear
format long g

%Meshgrid
u_min = -90;
u_max = 90;
v_min = -180;
v_max = 180;
u_min = 50;
u_max = 50;
v_min = 15;
v_max = 15;
du = 10;
dv = 10;
R = 6380;

[u,v] = meshgrid(u_min:du:u_max, v_min:dv:v_max);

%Sinusoidalni zobrazeni
[x,y] = sinu(R,u,v,0);

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
m2 = max(a_2,b_2);

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



