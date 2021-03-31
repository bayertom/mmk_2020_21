function[]= myGlobeFace(ub, vb, u1, u2, v1, v2, Du, Dv, du, dv, R, fproj, uk, vk)
axis equal
hold on

%Load boundary points
[sb, db] = uv_to_sd(ub, vb, uk, vk);
[xb, yb] = fproj(R, sb, db);
plot(xb, yb, 'ro');

%Create graticule
[XM, YM, XP, YP] = mygraticule(u1, u2, v1, v2, Du, Dv, du, dv, R, fproj, uk, vk);

%Draw graticule
plot(XM',YM','k');
plot(XP',YP','k');

%Continents: Europe
drawContinents('eur.txt', uk, vk, fproj, 5);
drawContinents('amer.txt', uk, vk, fproj,5);
drawContinents('austr.txt', uk, vk, fproj, 5);
drawContinents('anta.txt', uk, vk, fproj, 5);

%Set limits for drawing
cmin = -2*R;
cmax = -cmin;
xlim([cmin, cmax]); ylim([cmin, cmax]); 