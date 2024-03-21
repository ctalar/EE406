* dpair_basic_ee214
* basic differential pait with resistive load and resistive input drivers

* device models
.include ./ee214_hspice.mod

* parameters
.param Ln = 0.18u
.param Wn = 15.7u
.param supply = 1.8

* circuit
vdd vdd 0 'supply'
vic vic 0 1
vid vid 0 ac 1
x1 vid vic vip vim balun
x2 vod voc vop vom balun
rdum vod 0 1gig
it t 0 600u

m1 vop vgp t 0 nch w=18.6u l=0.18u
m2 vom vgm t 0 nch w=18.6u l=0.18u
rsp vip vgp 10k
rsm vim vgm 10k
rlp vop vdd 1k
rlm vom vdd 1k
clp vop 0 50f
clm vom 0 50f

.control
set wr_singlescale
.option numdgt = 3
save all

ac dec 1000 10 1000e9
save v(vod)
meas ac av0db find vdb(vod) at=10
meas ac av0 find vm(vod) at=10
let av03db = av0db - 3
meas ac f3db when vdb(vod)=av03db
write dpair_basic_ac_ee214.raw v(vod)
plot vm(vod)
* plot vdb(vod)
* plot {180*vp(vod)/pi}
op
print v(t)
.endc

.subckt balun vdm vcm vplus vminus
*.iopin vdm
*.iopin vcm
*.iopin vplus
*.iopin vminus
*Balun Circuit - by K. Kundert
e1 nodeA vcm vdm 0 0.5
v1 vplus nodeA 0
f1 vdm 0 v1 -0.5
r1 vdm 0 1G
e2 nodeB vminus vdm 0 0.5
v2 vcm nodeC 0
f2 vdm 0 v2 -0.5
r2 nodec nodeB 1u
.ends

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
