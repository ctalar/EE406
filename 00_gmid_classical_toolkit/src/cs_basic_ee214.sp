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
