% source Jesper and Murmann
% Fig 3.15 Sizing in weak inversion: 
% gm/ID versus JD
% gm_gds versus JD
% fT versus JD
clear all
close all

addpath('~/ihome/class/gmidLUTs;~/ihome/class/gmidTECHs')
load ('sg13_lv_nmos.mat');

% data ==============
L = [0.13 0.15 0.2 0.5 1 3];   % (µm)

% compute =================
JD     = look_up(nch,'ID_W','VGS',nch.VGS,'L',L); % note the sweep of VGS
gm_ID  = look_up(nch,'GM_ID','VGS',nch.VGS,'L',L);
gm_gds = look_up(nch,'GM_GDS','VGS',nch.VGS,'L',L);
fT     = look_up(nch,'GM_CGG','VGS',nch.VGS,'L',L)/2/pi;

% plot ====================
h = figure(1);
semilogx(JD', gm_ID','linewidth',1); 
grid; 
axis([1e-10 1e-3 5 35]);
ylabel('{\itg_m}/{\itI_D}  (S/A)','fontsize',12);
xlabel('{\itJ_D}  (A/µm)','FontSize',12);
legend('0.13 \mum','0.15 \mum', '0.20 \mum', '0.50 \mum', '1.00 \mum', ...
    '3.00 \mum','fontsize',12,'box','off')

k = figure(2);
semilogx(JD', gm_gds','linewidth',1);  
grid; 
axis([1e-10 1e-3 0 70]);
xlabel({'{\itJ_D}  (A/µm)'; ''},'fontsize',12);
ylabel('{\itg_m}/{\itg_d_s}','FontSize',12);
legend('0.13 \mum','0.15 \mum', '0.20 \mum', '0.50 \mum', '1.00 \mum', ...
    '3.00 \mum','fontsize',12,'box','off')

j = figure(3);
loglog(JD', fT','linewidth',1);  
grid; 
axis([1e-11 1e-3 1e4 1e11]);
xlabel({'{\itJ_D}  (A/µm)'; ''},'fontsize',12);
ylabel('{\itf_T}  (Hz)','FontSize',12);
legend('0.13 \mum','0.15 \mum', '0.20 \mum', '0.50 \mum', '1.00 \mum', ...
    '3.00 \mum','fontsize',12,'box','off','location','northwest')
