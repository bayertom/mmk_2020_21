clc
clear
format long g

%Uzemi, Nepal

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


