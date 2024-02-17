% File: igs_ex3_1_sim.m
% post processing ngspice simulation results
% for basic IGS (sizing for given gm/ID=15 and L=130nm)


clear all; clearvars; close all; clc;

addpath('~/ihome/HspiceToolbox');
% AC analysis
x = loadsig('./simulations/igs_ex3_1_ac.raw')
% lssig(x)

freq = evalsig(x, 'FREQUENCY');
vout = evalsig(x, 'out');
mag = abs(vout);
magdb = 20*log10(mag);

gaindb = max(magdb);
gain = max(mag);
% bandwidth
idx1 = find(magdb <= gaindb-3, 1, 'first');
f3db = freq(idx1);
% fu
idx2 = find(magdb <= 0, 1, 'first');
fu = freq(idx2);

figure(1);
semilogx(freq,magdb,'LineWidth',2);
grid on;
xlabel('frequency (Hz)','fontsize',14);
ylabel('magnitude (dB)', 'FontSize',14);
xlim([1e1,1e10])
ylim([-5 30])
hold on;
% annotate fu
yline(0); % unit gain (0 dB)
plot(fu,0,'o','MarkerSize',12,'Linewidth',2);
str = ['fu \approx ',num2str(fu*1e-9,'%.4f'), ' GHz'];
text(1e7,1,str,'fontsize',12)
% annotate avo
str = ['a_{vo} \approx ',num2str(gaindb,'%.4f'), ' dB (= ',...
    num2str(gain,'%.2f'), ' V/V)'];
text(2e1,26,str,'fontsize',12)
% annotate f3db
str = ['f_{3dB} \approx ',num2str(f3db*1e-6,'%.2f'), ' MHz \rightarrow'];
text(2e5,gaindb-3, str, 'fontsize',12)

% DC analysis
x = loadsig('./simulations/igs_ex3_1_dc.raw')
% lssig(x)

ids = evalsig(x,'ids_n');
vgs = evalsig(x,'vgs_n');
vds = evalsig(x,'vds_n');
vth = evalsig(x,'vth_n');
gm = evalsig(x,'gm_n');
gds = evalsig(x,'gds_n');
gm_id = gm/ids;
avo = gm/gds;
vdsat = 2/gm_id; % approx

fprintf('ID = %.4e (A)\n',ids)
fprintf('VGS = %.4f (V)\n',vgs)
fprintf('VTH = %.4f (V)\n',vth)
fprintf('VDS = %.4f (V)\n',vds)
fprintf('VDSAT = %.4f (V)\n',vdsat)
fprintf('gm = %.4e (S)\n',gm)
fprintf('gm/ID = %.2f (S/A)\n',gm_id);
fprintf('gds = %.4e (S)\n',gds);
fprintf('avo=gm/gds = %.2f (V/V)\n',avo);



