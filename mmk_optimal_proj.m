clc
clear
format long g

%Body na ortodrome (kartograficky rovnik)
u1 = 29.3772 * pi / 180;
v1 = 81.0166 * pi / 180;
u2 = 27.0181 * pi / 180;
v2 = 87.2089 * pi / 180;

%Bod na okraji
u3 = 27.9378 * pi / 180;
v3 = 88.0767 * pi / 180;

%Kartograficky pol
v_k = atan2(tan(u1)*cos(v2)-tan(u2)*cos(v1),...
     tan(u2)*sin(v1)-tan(u1)*sin(v2));
v_k_deg = v_k *180/pi;
u_k = atan(-(cos(v1-v_k)/tan(u1)));
u_k_deg = u_k*180/pi;

%Prevod (u, v) -> s, K = [uk, vk]
s_1 = asin(sin(u1)*sin(u_k) + cos(u1)*cos(u_k)*cos(v1 - v_k));
s_1_deg = s_1*180/pi;
s_2 = asin(sin(u2)*sin(u_k) + cos(u2)*cos(u_k)*cos(v2 - v_k));
s_2_deg = s_2*180/pi;
s_3 = asin(sin(u3)*sin(u_k) + cos(u3)*cos(u_k)*cos(v3 - v_k));
s_3_deg = s_3*180/pi;

%Nezkreslena rovnobezka
s_0=acos(2*cos(s_3)/(1+cos(s_3)));
s_0_deg=s_0*180/pi;

%Meritka (rovnik a okraj)
mr_1 = cos(s_0)/cos(s_1);
mr_2 = cos(s_0)/cos(s_2);
mr_3 = cos(s_0)/cos(s_3);

%Zkresleni (rovnik a okraj)
ny_1 = mr_1 - 1;
ny_2 = mr_2 - 1;
ny_3 = mr_3 - 1;









