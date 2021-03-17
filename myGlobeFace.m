function[]= myGlobeFace(ub, vb, u1, u2, v1, v2, Du, Dv, du, dv, R, fproj, uk, vk)
axis equal
hold on

%Load boundary points
[sb, db] = uv_to_sd(ub, vb, uk, vk);
[xb, yb] = fproj(R, sb, db);
plot(xb,yb, 'rO');

%Create graticule
[XM, YM, XP, YP] = mygraticule(u1, u2, v1, v2, Du, Dv, du, dv, R, fproj, uk, vk);

%Draw graticule
plot(XM',YM','k');
plot(XP',YP','k');

%Continents: Europe
eu = load('eur.txt');
u_eu = eu(:,1); v_eu = eu(:,2);
[s_eu, d_eu] = uv_to_sd(u_eu, v_eu, uk, vk);
idx = find(s_eu<5);
s_eu(idx) = []; d_eu(idx) = [];
[x_eu,y_eu] = fproj(R, s_eu, d_eu); 
plot(x_eu,y_eu,'b', 'LineWidth', 3);

%Continents: America
am = load('amer.txt');
u_am = am(:,1); v_am = am(:,2);
[s_am, d_am] = uv_to_sd(u_am, v_am, uk, vk);
idx = find(s_am<5);
s_am(idx) = []; d_am(idx) = [];
[x_am,y_am] = fproj(R, s_am, d_am); 
plot(x_am,y_am,'b', 'LineWidth', 3);

%Continents: Australia
au = load('austr.txt');
u_au = au(:,1); v_au = au(:,2);
[s_au, d_au] = uv_to_sd(u_au, v_au, uk, vk);
idx = find(s_au<5);
s_au(idx) = []; d_au(idx) = [];
[x_au,y_au] = fproj(R, s_au, d_au); 
plot(x_au,y_au,'b', 'LineWidth', 3);

%Continents: Antarctis
an = load('anta.txt');
u_an = an(:,1); v_an = an(:,2);
[s_an, d_an] = uv_to_sd(u_an, v_an, uk, vk);
idx = find(s_an<5);
s_an(idx) = []; d_an(idx) = [];
[x_an,y_an] = fproj(R, s_an, d_an); 
plot(x_an,y_an,'b', 'LineWidth', 3);

%Set limits for drawing
cmin = -2*R;
cmax = -cmin;
xlim([cmin, cmax]); ylim([cmin, cmax]); 