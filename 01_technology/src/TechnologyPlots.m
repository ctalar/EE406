% File: TechnologyPlots.m

clearvars;
clear all;
clc;
close all;

addpath('~/ihome/class/gmidLUTs;~/ihome/class/gmidTECHs')
load ('sg13_lv_nmos.mat')
load ('sg13_lv_pmos.mat');

% gm/ID and fT versus VGS for L=0.13um and VDS=0.6
gmid_n = look_up(nch, 'GM_ID', 'VDS', 0.6, 'VGS', nch.VGS, 'L',min(nch.L));
gmid_p = look_up(pch, 'GM_ID', 'VDS', 0.6, 'VGS', pch.VGS,'L',min(nch.L));
ft_n = 1e-9/2/pi*look_up(nch, 'GM_CGG', 'VDS', 0.6, 'VGS', nch.VGS, ...
   'L',min(nch.L));
ft_p = 1e-9/2/pi*look_up(pch, 'GM_CGG', 'VDS', 0.6, 'VGS', pch.VGS, ...
    'L',min(pch.L));
figure;
yyaxis left
plot(nch.VGS, gmid_n)
hold on;
plot(pch.VGS, gmid_p)
ylabel('g_m/I_D (S/A)','FontSize',12)
xlabel('V_G_S (V)','fontsize',12)
yyaxis right
plot(nch.VGS, ft_n)
title('L=0.13\mum , V_D_S=0.6V','FontSize',14)
hold on;
plot(pch.VGS, ft_p)
ylabel('f_T (GHz)', 'fontsize',12)
grid off;
legend('lv_nmos', 'lv_pmos', 'lv_nmos', 'lv_pmos', ...
    'location', 'southwest', 'interpreter','none','fontsize',12)
saveas(gcf, 'gm_ID-VGS.png')
hold off;

% product gm/ID*fT vs. gm/ID
figure;
plot(gmid_n, gmid_n.*ft_n)
hold on;
plot(gmid_p, gmid_p.*ft_p)
title('L=0.13\mum , V_D_S=0.6V','Fontsize',14)
xlabel('g_m/I_D (S/A)', 'Fontsize',12)
ylabel('g_m/I_D*f_T (S/A*GHz)','fontsize',12)
xlim([3 25]);
grid off;
legend('lv_nmos', 'lv_pmos', 'location', 'northeast', ...
    'interpreter','none','Fontsize',12)
saveas(gcf, 'gm_IDfT-gm_ID.png')

% sweep gm_id and L
gm_id = 5:1:25;
% Lvec = [.13:.02:.17 0.2 0.3 0.4 0.5]
Lvec = nch.L;

% fT vs. gm/ID for various L @ VDS=0.6V
figure;
fT = look_up(nch, 'GM_CGG', 'GM_ID', gm_id, 'L', Lvec, 'VDS', 0.6)/2/pi;
plot(gm_id,fT*1e-9,'LineWidth',1)
xlabel('\itg_m/I_D (S/A)', 'FontSize',12)
ylabel('\itf_T (GHz)', 'FontSize',12)
for i=1:length(Lvec)
   lestr{i} = ['L = ',num2str(Lvec(i),'%.2f'),' \it\mum'];
end
legend(lestr,'location','best','fontsize',12,'box','off');
title('lv\_nmos , V_D_S = 0.6 V','fontsize',14,'FontWeight','bold')
saveas(gcf, 'fT-gm_ID.png')

% Aintr vs. gm/ID for various L @ VDS=0.6V
figure;
Aintr = look_up(nch, 'GM_GDS', 'GM_ID', gm_id, 'L', Lvec, 'VDS', 0.6);
plot(gm_id,Aintr,'LineWidth',1)
xlabel('\itg_m/I_D (S/A)', 'FontSize',12)
ylabel('\itg_m/g_d_s ', 'FontSize',12)
for i=1:length(Lvec)
   legst{i} = ['L = ',num2str(Lvec(i),'%.2f'),' \it\mum'];
end
legend(legst,'location','northeastoutside','fontsize',12,'box','on');
title('lv\_nmos , V_D_S = 0.6 V','fontsize',14,'FontWeight','bold')
saveas(gcf, 'Aintr-gm_ID.png')

% JD vs. gm/ID for various L @VDS=0.6
figure
id_w = look_up(nch, 'ID_W', 'GM_ID', gm_id, 'L', Lvec, 'VDS', 0.6); 
semilogy(gm_id,id_w,'LineWidth',1)
xlabel('g_m/I_D (S/A)','fontsize',12)
ylabel('I_D/W \it( A/\mum )','fontsize',12)
for i=1:length(Lvec)
   legstr{i} = ['L = ',num2str(Lvec(i),'%.2f'),' \it\mum'];
end
legend(legstr,'location','northeastoutside','fontsize',12,'box','off');
title('lv\_nmos , V_D_S = 0.6 V','fontsize',14,'FontWeight','bold')
saveas(gcf, 'JD-gm_ID.png')

% JD vs. gm/ID for L=0.13um at various VDS (dependency on VDS is weak)
figure;
L = min(nch.L);
VDS_vec = [0.4 0.6 0.8]';
id_w = look_up(nch, 'ID_W', 'GM_ID', gm_id, 'L', L, 'VDS', VDS_vec); 
semilogy(gm_id,id_w,'LineWidth',1)
xlabel('g_m/I_D (S/A)','fontsize',12)
ylabel('I_D/W \it ( A/\mum )','fontsize',12)
for i=1:length(VDS_vec)
   lstr{i} = ['V_D_S = ',num2str(VDS_vec(i),'%.1f'),' V'];
end
legend(lstr,'location','best','fontsize',12,'box','on');
title('lv\_nmos , L = 0.13 \mum','fontsize',14,'FontWeight','bold')
saveas(gcf, 'JD-gm_ID-for-VDS.png')

% dependence of VDsat on VGS (from weak to strong inversion)
figure;
VGS_vec = [0.2 0.4 0.6 0.8 1.2]';
gm_ID = look_up(nch,'GM_ID','VGS',VGS_vec,'L',L); 
VDsat = 2./gm_ID;
VDS_vec = nch.VDS;
JD = look_up(nch,'ID_W','VGS',VGS_vec,'VDS',VDS_vec);
semilogy(nch.VDS,JD,'linewidth',1)
JDsat = diag(look_up(nch,'ID_W', 'VDS', VDsat, 'VGS',VGS_vec,'L',L));
hold on;
for i=1:length(VDsat)
   semilogy(VDsat(i),JDsat(i),'ko','LineWidth',1)
end
semilogy(VDsat,JDsat,'-','Color',[0.7 0.7 0.7])
for i=1:length(VGS_vec)
   legs{i} = ['V_G_S = ',num2str(VGS_vec(i),'%.1f'),' V'];
end
legend(legs,'location','northeastoutside','fontsize',12,'box','on');
xlabel('V_D_S (V)','fontsize',12)
ylabel('I_D/W \it ( A/\mum )','fontsize',12)
title({['lv\_nmos , L=0.13\m' ...
    'um'];'Evolution of V_{Dsat} from weak to strong inversion.'},...
    'Fontsize',14)
saveas(gcf, 'JD-VDS.png')

% capacitances
cdd_w_n = 1e15*look_up(nch, 'CDD', 'VDS', nch.VDS, 'VGS', 0.6, ...
    'L', L)/nch.W;
cdd_w_p = 1e15*look_up(pch, 'CDD', 'VDS', pch.VDS, 'VGS', 0.6, ...
    'L', L)/pch.W;
CDD_CGG_n = look_up(nch, 'CDD_CGG', 'VDS', nch.VDS, 'VGS', 0.6, ...
    'L', L);
CDD_CGG_p = look_up(pch, 'CDD_CGG', 'VDS', pch.VDS, 'VGS', 0.6, ...
    'L', L);
CGD_CGG_n = look_up(nch, 'CGD_CGG', 'VDS', nch.VDS, 'VGS', 0.6, ...
    'L', L);
CGD_CGG_p = look_up(pch, 'CGD_CGG', 'VDS', pch.VDS, 'VGS', 0.6, ...
    'L', L);

figure;
plot(nch.VDS, cdd_w_n, pch.VDS, cdd_w_p);
title('L=0.13\mum , V_G_S=0.6V','FontSize',14)
xlabel('V_D_S (V)','FontSize',12)
ylabel('C_D_D/W (fF/\mum)','fontsize',12);
grid on;
legend('lv_nmos', 'lv_pmos', 'location', 'northeast', ...
    'fontsize',12,'interpreter','none')
saveas(gcf, 'Cdd_W-VDS.png')

figure;
plot(nch.VDS, CDD_CGG_n, '-k', pch.VDS, CDD_CGG_p,'--k', 'LineWidth',1);
grid;
hold;
plot(nch.VDS, CGD_CGG_n, '-b', pch.VDS, CGD_CGG_p,'--b', 'LineWidth',1);
xlabel('V_D_S (V)','fontsize',12)
xline(0.6,'Color',[0.7 0.7 0.7], 'LineWidth',2)
title('L=0.13\mum , V_G_S=0.6V','FontSize',14)
str = {'lv\_nmos C_D_D/C_G_G';'lv\_pmos C_D_D/C_G_G';...
    'lv\_nmos C_G_D/C_G_G';'lv\_pmos C_G_D/C_G_G'};
legend(str, 'fontsize',12)
saveas(gcf, 'Cdd_Cgg_and_Cgd_Cgg-VDS.png')

% Ratios at VDS =0.6
Kv_CDD_CGG_n = look_up(nch, 'CDD_CGG', 'VDS', 0.6, 'VGS', 0.6, ...
    'L', L)
Kv_CDD_CGG_p = look_up(pch, 'CDD_CGG', 'VDS', 0.6, 'VGS', 0.6, ...
    'L', L)
Kv_CGD_CGG_n = look_up(nch, 'CGD_CGG', 'VDS', 0.6, 'VGS', 0.6, ...
    'L', L)
Kv_CGD_CGG_p = look_up(pch, 'CGD_CGG', 'VDS', 0.6, 'VGS', 0.6, ...
    'L', L)
