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
