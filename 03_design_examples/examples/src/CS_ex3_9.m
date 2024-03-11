% File: cs_ex3_9.m
% source: Jesper and Murmann textbook
% example 3_9 pp. 98-99
% large signal characteristic of CS with active p-channel load

% ================== PART 1 ===============================

clear all
close all
clc
addpath('~/ihome/class/gmidLUTs;~/ihome/class/gmidTECHs')

load ('sg13_lv_nmos.mat');
load ('sg13_lv_pmos.mat');

% specs ===========
VDD = 1.2;
CL  = 1e-12;
fT = 10e9; 
FO = 10;

gm_ID2 = 10;     % VDSat2 = 0.2V
L2 = 0.5;

% compute gain ========
VDS = .6;     	
LL  = .13: .01: .5;

gm_ID1  = look_up(nch,'GM_ID','GM_CGG',2*pi*fT,'VDS',VDS,'L',LL);
gds_ID1 = look_up(nch,'GDS_ID','GM_CGG',2*pi*fT,'VDS',VDS,'L',LL);
gds_ID2 = look_up(pch,'GDS_ID','GM_ID',gm_ID2,'VDS',VDD - VDS,'L',L2);

% maximize gain =========
Av = gm_ID1./(gds_ID1 + gds_ID2);
[a b] = max(Av);   % find L1 making Av max
L1  = LL(b);
Avo = Av(b)

% de-normalize and introduce parasitc cap ===========
JDn    = look_up(nch,'ID_W','GM_ID',gm_ID1(b),'VDS',VDS,'L',L1);
Cdd_Wn = look_up(nch,'CDD_W','GM_ID',gm_ID1(b),'VDS',VDS,'L',L1);
JDp    = look_up(pch,'ID_W','GM_ID',gm_ID2,'VDS',VDD - VDS,'L',L2);
Cdd_Wp = look_up(pch,'CDD_W','GM_ID',gm_ID2,'VDS',VDD - VDS,'L',L2);

Cdd = 0;
for k = 1:5,
    gm = 2*pi*fT/FO*(CL+Cdd);
    ID = gm/gm_ID1(b);
    Wn = ID/JDn;
    Wp = ID/JDp;
    Cdd = Wn*Cdd_Wn + Wp*Cdd_Wp;
end

% results ==============
L1
Wn
L2
Wp
ID
gm_id1 = gm_ID1(b)
gm_ID2

VGS1 = look_upVGS(nch,'GM_ID',gm_ID1(b),'VDS',VDS,'L',L1)
VGS2 = look_upVGS(pch,'GM_ID',gm_ID2,'VDS',VDD - VDS,'L',L2);
VG2 = VDD - VGS2
fu = gm/(2*pi*(CL+Cdd))
Cdd


% ================== PART 2 ===============================

VDS1 = .05: .01: 1.15;
ID2 = Wp*look_up(pch,'ID_W','VGS',VGS2,'VDS',VDD-VDS1,'L',L2);
ID1 = Wn*look_up( nch,'ID_W','VGS',nch.VGS,'VDS',VDS1,'L',L1)';
for m = 1:length(VDS1),
 	 UGS1(:,m) = interp1(ID1(m,:),nch.VGS,ID2(m),'pchip');
end
 
% plot ===
UGS1o = interp1(VDS1,UGS1,VDD/2) % value of UGS1 for which VOUT = VDD/2
h = figure(1);
plot(UGS1,VDS1,'color', 0.7*[1 1 1], 'linewidth',4); 
hold on;
plot(UGS1o,VDD/2,'ko');
xlabel('{\itv_I_N}   (V)','FontSize',12);
ylabel('{\itv_O_U_T}   (V)','FontSize',12);
 
% Add Spice simulation results
load('ex3_9_spice.mat')
plot(data.vin_spice, data.vout_spice,'r')

% mark output swing
V_high = VDD - 2/gm_ID2;
V_low  = 2/gm_id1;
str = ['\it V_D_D ' char(8211) ' V_D_s_a_t_2 '];
yline(V_high,'color', 'k', 'linestyle', '--','Label',str,'FontSize',12);
yline(V_low,'color', 'k', 'linestyle', '--', 'Label',...
    'V_D_s_a_t_1','FontSize',12);

text(0.52, 0.6,['(', num2str(UGS1o,'%.4f'),' V, 0.6 V)'], 'fontsize',12)

legend('Matlab', 'OP point', 'Spice','location','best','fontsize',12)

% ===== for fun derive gain also from d(VDS1)/d(UGS1) =====
A = diff(VDS1)./diff(UGS1);
% compute the gain as follows:
% return the value of A for which the mid point of the segments 
% approximating VOUT is 0.6
gain = interp1((VDS1(1:end-1)+VDS1(2:end))/2,A,.6)
