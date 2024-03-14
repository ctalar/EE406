% ex3_13.m
% source: Jesper & Murmann textbook pp.111 - 113

clearvars;
clear all;
clc;
close all;

addpath('~/ihome/class/gmidLUTs;~/ihome/class/gmidTECHs')
% load 65nch.mat
load ('sg13_lv_nmos.mat')

% specs
AV0 = 4;
CL = 50e-15;
RD = 1e3;
RS = 10e3;
VC = 0.7;
VDD = 1.2;
gm_id = 15;
% L = 0.1;      % 65nch
L = min(nch.L); % sg13_lv_nmos

gm_gds = look_up(nch, 'GM_GDS', 'GM_ID', gm_id, 'L', L);
gm = 1/RD*(1/AV0 - 1./gm_gds).^-1;
gds = gm/gm_gds;
ID = gm/gm_id;
IT = 2*ID;

ID_W = look_up(nch,'ID_W','GM_ID',gm_id,'VDS',VDD/2,'L',L);
W = ID/ID_W;

Cgs = W.*look_up(nch, 'CGS_W','GM_ID', gm_id,'L',L);
Cgd = W.*look_up(nch, 'CGD_W','GM_ID', gm_id,'L',L);
Cdd = W.*look_up(nch, 'CDD_W','GM_ID', gm_id,'L',L);
Cgg = W.*look_up(nch, 'CGG_W', 'GM_ID',gm_id, 'L',L)
Cdb = Cdd - Cgd;
CLtot = CL + Cdb;

b1 = RS*(Cgs + Cgd*(1+AV0)) + RD*(CLtot+Cgd);
fp1 = 1/b1/2/pi;
b2 = RS*RD*(Cgs*CLtot + Cgs*Cgd + CLtot*Cgd);
fp2 = b1/b2/2/pi;

% Summary of the design parameters
fprintf('gm     = %.2e (S)\n',gm)
fprintf('gm_gds = %.2f\n',gm_gds)
fprintf('gds    = %.2e (S)\n', gds)
fprintf('ID     = %.4e (A)\n',ID)
fprintf('IT     = %.4e (A)\n',IT)
fprintf('W      = %.2f (um)\n',W)
fprintf('CGG    = %.2f (fF)\n', Cgg*1e15)
fprintf('CGS    = %.2f (fF)\n',Cgs*1e15)
fprintf('CGD    = %.2f (fF)\n',Cgd*1e15)
fprintf('CDD    = %.2f (fF)\n',Cdd*1e15)
fprintf('CDB    = %.2f (fF)\n',Cdb*1e15)
fprintf('CLtot  = %.2f (fF)\n',CLtot*1e15)
fprintf('fp1    = %.2f (MHz)\n',fp1*1e-6)
fprintf('fp2    = %.2f (GHz)\n',fp2*1e-9)
fprintf('fT     = %.2f (GHz)\n', 1e-9*gm/Cgg/2/pi)

