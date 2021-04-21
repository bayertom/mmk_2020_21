clc
clear
format long g

%Input points
fi_1 = 50;
lam_1 = 15;

fi_2 = 50.1;
lam_2 = 15.2;

%Wgs to jtsk
[x_1, y_1] = wgs_to_jtsk(fi_1, lam_1);
[x_2, y_2] = wgs_to_jtsk(fi_2, lam_2);
d1 = sqrt((x_2-x_1)^2+(y_2-y_1)^2);

%Bessel to jtsk
[x_3, y_3] = bess_to_jtsk(fi_1, lam_1);
[x_4, y_4] = bess_to_jtsk(fi_2, lam_2);
d2 = sqrt((x_4-x_3)^2+(y_4-y_3)^2);

