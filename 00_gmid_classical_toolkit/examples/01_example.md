### NGSpice Deck (cs_basic_ee214.sp)
```
* cs_basic_ee214
* basic cs with resistive load and ideal input driver

* device models
.include ./ee214_hspice.mod

* parameters
.param supply=1.8

* circuit
vdd dd 0 'supply'
vin in 0 DC 0.788 AC 1 
RL dd out 796
CL out 0 200f
m1 out in 0 0 nch w=15.7u l=0.18u

.control
set wr_singlescale
.option numdgt = 3
save all

ac dec 1000 10 1000e9
save v(out)
meas ac av0db find vdb(out) at=10
meas ac av0 find vm(out) at=10
let av03db = av0db - 3
meas ac f3db when vdb(out)=av03db
write cs_basic_ac_ee214.raw v(out)
plot vm(out)
plot vdb(out)
plot {180*vp(out)/pi}
op
.endc

.GLOBAL GND

* Hspice Pole/zero analysis
* fp1 ~ 1.0640 GHz
* fz  ~ 128.226 GHz
* Matlab Identification Toolbox
* fp1 ~ 1.0425 GHz
* fz  ~ 127.3806 GHz

.end
```
### Post processing the NGSpice Simulation Data (cs_basic_ee214_sim.m)
```
% cs_basic_ee214_sim.m

clearvars;
clear all;
clc;
close all;

addpath('~/ihome/HspiceToolbox');

x = loadsig('./cs_basic_ac_ee214.raw')
lssig(x)

freq = evalsig(x,'FREQUENCY');
vout = evalsig(x, 'out');
mag = abs(vout);
phase = (180/pi)*unwrap(angle(vout));
magdb = 20*log10(mag);
idx = find(magdb < magdb(1) - 3, 1, 'first');
f3db = freq(idx);
Av0 = mag(1);
str = sprintf('|A_{V0}|= %3.2f dB (= %3.2f V/V) and f_{3dB}= %3.2f GHz', ...
    magdb(1), Av0, f3db*1e-9);

figure(1);
semilogx(freq, magdb, 'linewidth', 2);
title('Common Source Frequency Reponse','fontsize',14)
xlabel('Frequency [Hz]','fontsize',12);
ylabel('Magnitude [dB]','fontsize',12);
axis([1e1 1e12 -30 15]);
text(1e2, -40, str, 'color', 'b', 'fontSize',14)
grid;
print(figure(1), '-dpng', 'cs_basic_ee214_plot.png')

  
fprintf('spice simulation (results summary) \n');
fprintf('-----------------------------------\n');
fprintf('gain: %.3f dB (%.3f V/V) \n', magdb(1), mag(1));
fprintf('bw: %.3f GHz \n', f3db*1e-9);


% estimate the poles and zeros from the simulation data
np = 1;
nz = 1;
data = frd(vout,freq);
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
<p align="center">
   <img src="./img/cs_basic_ee214_plot.png" width="600" >
</p>


