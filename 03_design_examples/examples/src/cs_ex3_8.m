% File: cs_ex3_8.m
% source: Jesper and Murmann textbook
% example 3_8 pp. 95-98
% design of CS with active p-channel transistor load

clear all; clearvars; close all; clc;

addpath('~/ihome/class/gmidLUTs;~/ihome/class/gmidTECHs')
load ('sg13_lv_nmos.mat');
load ('sg13_lv_pmos.mat');

% specs
CL = 1e-12;
VSB = 0;
VDD = 1.2;
VDS = VDD/2;
FT = 10e9;
FO = 10;
fu = FT/FO;

% ============= PART 1 ================

% Gaining intuition about the impact of L2
% == data
L2 = [0.13 .2*(1:5)];  % L = [0.13 0.2 0.4 0.6 0.8 1.0] um 
gm_ID2 = 3:28;  % (S/A)
% == compute
gds_ID2 = look_up(pch,'GDS_ID','GM_ID',gm_ID2,'L',L2);
% == plot
h = figure(1);
plot(gm_ID2,gds_ID2,'linewidth',1); 
grid off;
xlabel('({g_m}/{I_D})_p   (S/A)','FontSize',12);
ylabel('({g_d_s}/{I_D})_p   (S/A)','fontsize',12);
% "automate" the creation of the legend
for i=1:length(L2)
   legstr{i} = ['L_p = ',num2str(L2(i),'%.2f'),' \mum'];
end
legend(legstr,'location','best','fontsize',12,'box','on');


% ============= PART 2 ================

% sweep L1
L1 = [min(nch.L):0.01:max(nch.L)];
gm_ID1 = look_up(nch,'GM_ID','GM_CGG',2*pi*FT,'L',L1);
% remove the values of gm_ID1 and the corresponding L1 for which the 
% required FT is not achievable (i.e., remove the NaN from the vectors)
gm_ID1 = gm_ID1(~isnan(gm_ID1));
L1 = L1(1:length(gm_ID1));
gds_ID1 = diag(look_up(nch,'GDS_ID','GM_ID',gm_ID1,'L',L1));

% set the gm_ID2 so that VDsatp is not larger than 0.2V 
gm_ID2 = 10; % gm_ID2 should not drop below 10 S/A

% search for the largest L2 that enables us to still meet the desired fu
% sweep L2
L2 = [min(pch.L):0.01:max(pch.L)];
gds_ID2 = look_up(pch,'GDS_ID','GM_ID',gm_ID2,'L',L2);
for k = 1:length(L2)
     Av0(:,k) = gm_ID1./(gds_ID1 + gds_ID2(k));
end
% AV0 is a matrix of dimension L1 x L2
% length(L1) = 41
% length(L2) = 288
% size(Av0)  = 41 288
[a b] = max(Av0);
maxgain = a';
% L1(b) gate lengths of M1 making Av0 max
% gm_ID1(b);


% == denormalize while accounting for self loading
Cself = 0;
for k = 1:10
      gm = 2*pi*fu*(CL+Cself); % gm_1
      ID = gm./gm_ID1(b);
      W1 = ID./diag(look_up(nch,'ID_W','GM_ID',gm_ID1(b),'L',L1(b)));
      W2 = ID./look_up(pch,'ID_W','GM_ID',gm_ID2,'L',L2);
      Cdd2 = W2.*look_up(pch,'CDD_W','GM_ID',gm_ID2,'L',L2); 
      Cdd1 = W1.*diag(look_up(nch,'CDD_W','GM_ID',gm_ID1(b),'L',L1(b)));  
      Cself = Cdd1 + Cdd2; 
end

% plot ==========================
k = figure(2);
ax = plot(L2,[W1(:,end) W2(:,end) 1e3*L1(b)']);
xlim([0.13 1])
xlabel({'{\itL_p} (µm)',''},'fontsize', 12)
legend('W_n (\mum)', 'W_p (\mum)','L_n (nm)','location','best',...
    'fontsize',12,'box','off')

m = figure(3);
ax = plot(L2,[1e6*ID 10*maxgain]);
xlim([0.13 1])
xlabel({'{\itL_p} (µm)',''},'fontsize', 12)
text(.8,1200,'{\itI_D} (µA)','fontsize', 12,'Color',"#0072BD")
text(.8,250,'10 x |{\itA_v_0_m_a_x}|','fontsize', 12,'Color',"#D95319")

% [maxgain ID gm_ID1 L1 W1 W2] @ L2 = 0.5um
recap = interp1(L2,[maxgain 1e6*ID gm_ID1(b) L1(b)' W1 W2],.5);

VG1 = look_upVGS(nch,'GM_ID',recap(3),'L',recap(4)); % don't forget L !!!
VGS2 = look_upVGS(pch,'GM_ID',gm_ID2,'L',0.5);       % don't forget L !!!
VG2 = VDD - VGS2;

fprintf("------------- Results --------------\n")
fprintf("|Av0| = %.2f\n",recap(1));
fprintf("(gm/ID)_p = %.2f S/A\n",gm_ID2)
fprintf("(gm/ID)_n = %.2f S/A\n",recap(3));
fprintf("ID = %.2f uA\n",recap(2));
fprintf("VG_p = %.4f V\n",VG2)
fprintf("L_p = %.2f um\n",0.5)
fprintf("W_p = %.2f um\n",recap(6))
fprintf("VG_n = %.4f V\n",VG1)
fprintf("L_n = %.2f um\n",recap(4))
fprintf("W_n = %.2f um\n",recap(5))
fprintf("-------------------------------------\n")

