% File: igs_ex3_2.m
% source: Jesper and Murmann textbook
% example 3_2 pp. 71-73
% basic IGS - sizing for constant gm/ID=15 to achieve fu = 1GHz

clear all; clearvars; close all; clc;

addpath('~/ihome/class/gmidLUTs;~/ihome/class/gmidTECHs')
load ('sg13_lv_nmos.mat');

% specs
% -----
fu = 0.1e9;
CL = 1e-12;
gm_id = 15;
VSB = 0;
VDD = 1.2;
VDS = VDD/2;

% computations
% ------------
% Since gm/ID is constant and gm (i.e., fu and CL) is fixed by spec. the
% drain current ID is also constant, regardless of the chosen L
gm = 2*pi*fu*CL;
ID = gm/gm_id;

NL = length(nch.L);
Lvec = linspace(nch.L(1),nch.L(NL)); % slice L in 100 points

JD = look_up(nch,'ID_W', 'GM_ID', gm_id, 'L',Lvec);
W = ID./JD;
gm_ID = look_up(nch,'GM_ID','ID_W',JD,'L',Lvec)';
fT = look_up(nch,'GM_CGG','GM_ID',gm_id,'L',Lvec)/(2*pi);
FO = fT/fu;
Avo = look_up(nch,'GM_GDS','GM_ID',gm_id,'L',Lvec);


% acceptable FO >= 10
M = FO >= 10;          % index vector of usable L range
Lmax = max(Lvec(M))    % the largest achievable gain is for Lmax
Lmin = min(Lvec(M))    
N = find(M,1,'last');     % index of Lmax
% P = max(find(M==1));    % number of usable L - same as N :-)

Avo_m = look_up(nch,'GM_GDS','GM_ID', gm_id,'L',Lvec(M));
L_m   = Lvec(M);
fT_m  = fT(M);
W_m = ID./look_up(nch,'ID_W','GM_ID', gm_id,'L',L_m);

L = linspace(min(Lvec(M)), max(Lvec(M)),4); % take 4 of the usable L

GM_ID = look_up(nch,'GM_ID','ID_W',JD,'L',L)';
AV0 = look_up(nch,'GM_GDS','GM_ID',GM_ID,'L',L)';
FT = 1e-9*look_up(nch,'GM_CGG','GM_ID',GM_ID,'L',L)';

% mark L
for k = 1: length(L)
    %fT1(k,1)  = interp1(GM_ID(:,k),FT(:,k), 15,'spline');  % gm_id = 15
    %Av01(k,1) = interp1(GM_ID(:,k),AV0(:,k), 15,'spline'); % gm_id = 15
    fT1(k,1)  = interp1(GM_ID(:,k),FT(:,k), 15.01);      % gm_id = 15.01
    Av01(k,1) = interp1(GM_ID(:,k),AV0(:,k), 15.01);     % gm_id = 15.01
end

% NOTE: the default interpolation method ('linear') causes a few NaN.
%       Use 'spline' to solve the issue.
%       Increasing gm_id just a bit (15.01) does also solve the issue.

%===== Plots =====
figure(1);
g1 = semilogy(GM_ID, AV0, 'b--','linewidth',2);
hold on;
g2 = semilogy(GM_ID, FT, 'k-.', 'linewidth',2); 
legend([g1(1) g2(2)], {'|{\itA_V_0}|', '{\itf_T} (GHz)'}, ...
    'location', 'northeast','FontSize',12,Box='off');
xline(gm_id,'r','linewidth',2,'HandleVisibility','off')
xlabel('g_{m}/I_{D} (S/A)','FontSize',12)
semilogy(15,fT1,'ko',15,Av01,'bs', 'linewidth', 1.2, ...
    'markersize',8,'HandleVisibility','off');
str1 = "{\itL} = " + num2str(Lmin,'%.2f' + " µm");
text(15.5,4.5,str1, 'fontsize',12);
str2 = "{\itL} = " + num2str(Lmax,'%.2f' + " µm");
text(15.5,65,str2, 'fontsize',12);
text(22,37,str1, 'fontsize',12,'Color','blue');
hold off;

figure(2);
plot(L_m,Avo(M),'--',L_m,W_m,'-',L_m,fT_m/fu,'-.', 'linewidth', 2);
legend('|A_{vo}|','W (\mum)','FO','fontsize',12,'box','off')
xlim([min(L_m),max(L_m)]);
% d = listfonts
xlabel('L (\mum)','FontSize',12)
str = newline + ...
    "Parameters: f_{u}=100 MHz, C_{L}=1 pF, g_{m}/I_{D}=15 S/A," + ...
    " V_{DS}= 0.6V, V_{SB}= 0V " + newline;
title(str,'FontSize',12,'FontWeight','normal', 'FontName','Menlo')

% compute the required VGS
VGS = look_upVGS(nch,'GM_ID',gm_id,'L',Lmax,'VDS',VDS,'VSB',VSB);

% === results
fprintf("\n------ Results ------\n")
fprintf('VGS = %.4f (V)\n',VGS);
fprintf('ID = %.4f (uA)\n',ID*1e6);
fprintf('gm = %.2e (S)\n',gm);
fprintf('gm/ID = %.2e (S/A)\n',gm/ID);
fprintf('L = %.2f (um)\n',Lvec(N))
fprintf('W = %.2f (um)\n',W(N));
fprintf('avo = gm/gds = %.2f (V/V)\n',Avo(N));
fprintf('gds = %.2e (S)\n',gm/Avo(N));
fprintf('fT = %.4e (Hz)\n',fT(N))
fprintf('FO = fT/fu = %.2f\n',FO(N))

