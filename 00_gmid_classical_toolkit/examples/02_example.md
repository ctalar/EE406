#### NGspice Deck (dpair_basic_ee214.sp)

<p align="center">
   <img src="../img/dpair_basic_ee214_sch.png" width="600" >
</p>

```
* dpair_basic_ee214.sp
* basic differential pair with resistive load and resistive input drivers

* device models
.include ./ee214_hspice.mod

* parameters
.param Lx=0.18u
.param Wx=18.6u
.param supply=1.8

* circuit
vdd dd gnd dc 'supply'
vc vic gnd dc 1
vd vid gnd ac 1
x1 vid vic vip vim balun
x2 vod voc vop vom balun
rdum vod gnd 1gig
itail tail gnd 600u
m1 vop vgp tail gnd nch W={Wx} L={Lx}
m2 vom vgm tail gnd nch W={Wx} L={Lx}
rsp vip vgp 10k
rsm vim vgm 10k
rlp dd vop 1k
rlm dd vom 1k
clp vop gnd 50f
clm vom gnd 50f

.save all

.control
set wr_singlescale
.option numdgt = 3

ac dec 100 10 1e12
save v(vod)
meas ac av0db find vdb(vod) at=10
meas ac av0 find vm(vod) at=10
let av03db = av0db - 3
meas ac f3db when vdb(vod)=av03db
write dpair_basic_ac_ee214.raw v(vod)
plot vm(vod)
plot vdb(vod)
plot {180*vp(vod)/pi}

op
print v(tail)
.endc

.GLOBAL GND

* Hspice Pole/zero analysis
* fp1 ~ 214.865 MHz
* fp2 ~ 5.045 GHZ
* fz  ~ 70.9323 GHz
* Matlab Identification Toolbox
* fp1 ~ 214.6 MHz
* fp2 ~ 4.6815 GHz
* fz  ~ 70.5708 GHz
* percent error on fp2 ~ 7.2%

.end
```

#### Post processing the NGspice Simulation Data (dpair_basic_ee214_sim.m)
```
% dpair_basic_ee214_sim.m

clearvars;
clear all;
clc;
close all;

addpath('~/ihome/HspiceToolbox');

x = loadsig('./dpair_basic_ac_ee214.raw')
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
text(1e2, -40, str, 'color', 'b', 'fontSize',14)
grid;
print(figure(1), '-dpng', 'dpair_basic_ee214_plot.png')

  
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
fprintf('\n');
```
