clearvars; close all; clc; clear all;

s.VDS = (0.6:0.6:1.2)'
s.W = [0.15 0.25 0.35 0.45 0.55 0.65 0.75 0.85 0.95 ...
    1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 ...
    25 30 35 40 45 50]'

t = readtable('./simulations/vt_W_n.txt')
a = table2array(t)

% column vector from ngspice
% 1 v-sweep
% 2 @n.xm1.nsg13_lv_nmos[ids]
% 3 @n.xm1.nsg13_lv_nmos[vth]
% 4 v-sweep

d1 = length(s.VDS)
d2 = length(s.W)
s.VT = reshape(a(:, 3), d1, d2)
s.ID = reshape(a(:, 2), d1, d2)

plot(s.W, s.VT(1,:))
xlabel('W (um)','Fontsize',12)
ylabel('V_{TH} (V)','Fontsize',12)
xlim([0, 10])
hold on;
plot(s.W, s.VT(2,:))
title('V_{TH} vs. W for L=0.13um @ V_{GS}=0.6V',"FontSize",14)
legend('V_{DS} = 0.6V','V_{DS} = 1.2V','Fontsize',12)
hold off;

figure
semilogy(s.W, s.ID(1,:))
hold on;
semilogy(s.W, s.ID(2,:))
xlabel('W (um)','Fontsize',12)
ylabel('I_{D} (A)','Fontsize',12)
title('I_{D} vs. W for L=0.13um @ V_{GS}=0.6V',"FontSize",14)
legend('V_{DS} = 0.6V','V_{DS} = 1.2V','Fontsize',12,'location','best')