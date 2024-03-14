
## Differential Pair with Resistive input Drivers and Resistive Loads

Design the amplifier to achieve $|A_{VO}| = 4$. Assume $C_L = 50fF$, $R_D = 1k\Omega$, $R_S = 10k\Omega$ and $V_{DD} = 1.2V$.<br>
Size the transistors assuming $L = 0.13 \mu m$ and $g_m/I_D = 15$ $S/A$

---

#### matlab's design script (ex3_13.m)
```
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
Cgg = W.*look_up(nch, 'CGG_W', 'GM_ID',gm_id, 'L',L);
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
fprintf('CGS    = %.2f (fF)\n',Cgs*1e15)
fprintf('CGD    = %.2f (fF)\n',Cgd*1e15)
fprintf('CDD    = %.2f (fF)\n',Cdd*1e15)
fprintf('CDB    = %.2f (fF)\n',Cdb*1e15)
fprintf('CLtot  = %.2f (fF)\n',CLtot*1e15)
fprintf('fp1    = %.2f (MHz)\n',fp1*1e-6)
fprintf('fp2    = %.2f (GHz)\n',fp2*1e-9)
fprintf('fT     = %.2f (GHz)\n', 1e-9*gm/Cgg/2/pi)
```

#### Summary of the design results
`gm     = 5.26e-03 (S)`<br>
`gm_gds = 16.68`<br>
`gds    = 3.15e-04 (S)`<br>
`ID     = 3.5077e-04 (A)`<br>
`IT     = 7.0155e-04 (A)`<br>
`W      = 58.11 (um)`<br>
`CGS    = 48.34 (fF)`<br>
`CGD    = 34.74 (fF)`<br>
`CDD    = 53.80 (fF)`<br>
`CDB    = 19.06 (fF)`<br>
`CLtot  = 69.06 (fF)`<br>
`fp1    = 68.47 (MHz)`<br>
`fp2    = 4.99 (GHz)`<br>
`fT     = 9.74 (GHz)`<br>

#### Post-processing the simulation results (ex3_13_sim.m)
```
% ex3_13_sim.m

clearvars;
clear all;
clc;
close all;

addpath('~/ihome/class/gmidLUTs;~/ihome/class/gmidTECHs')
addpath('~/ihome/HspiceToolbox');
load ('sg13_lv_nmos.mat')

x = loadsig('./simulations/ex3_13_ac.raw')
lssig(x)

freq = evalsig(x,'FREQUENCY');
vod = evalsig(x, 'vod');
mag = abs(vod);
phase = (180/pi)*unwrap(angle(vod));
magdb = 20*log10(mag);
idx = find(magdb < magdb(1) - 3, 1, 'first');
f3db = freq(idx);
Av0 = mag(1);
str = sprintf('|A_{V0}|= %3.2f dB (= %3.2f V/V) and f_{3dB}= %3.2f MHz', ...
    magdb(1), Av0, f3db*1e-6);

figure(1);
semilogx(freq, magdb, 'linewidth', 2);
title('Differential Pair Frequency Reponse','fontsize',14)
xlabel('Frequency [Hz]','fontsize',12);
ylabel('Magnitude [dB]','fontsize',12);
axis([1e1 1e11 -80 20]);
text(1e2, -40, str, 'color', 'm', 'fontSize',12)
grid;
print(figure(1), '-dpng', 'ex3_11_plot.png')

  
fprintf('spice simulation (results summary) \n');
fprintf('-----------------------------------\n');
fprintf('gain: %.3f dB (%.3f V/V) \n', magdb(1), mag(1));
fprintf('bw: %.3f MHz \n', f3db*1e-6);


% estimate the poles and zeros from the simulation data
np = 2;
nz = 1;
data = frd(vod,freq);
sys = tfest(data,np,nz)  % System Identification Toolbox
[p,z] = pzmap(sys);      % Control Toolbox
np = length(p);          % number of poles
nz = length(z);          % number of zeros
fprintf('\nextracted TF\n');
fprintf('-------------\n')';
fprintf('The T.F. has %d pole(s) and %d zero(s)', np, nz)
if np >= 1
    for i=1:np
        fprintf('\nThe pole is at P(%d): %.4f + %.4fj (GHz)',i, ...
        real(p(i)*1e-9), imag(p(i)*1e-9));
    end
end
if nz >= 1
    for i=1:nz
        fprintf('\nThe zero is at Z(%d): %.4f + %.4fj (GHz)',i, ...
        real(z(i)*1e-9), imag(z(i)*1e-9));
    end
end
```
