v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -290 -370 -290 -330 {
lab=out}
N -410 -200 -410 -180 {
lab=GND}
N -530 -200 -530 -180 {
lab=GND}
N -410 -300 -410 -260 {
lab=gn}
N -290 -260 -220 -260 {
lab=GND}
N -290 -260 -290 -240 {
lab=GND}
N -290 -300 -220 -300 {
lab=GND}
N -180 -370 -180 -300 {
lab=out}
N -290 -370 -180 -370 {
lab=out}
N -180 -240 -180 -180 {
lab=GND}
N -530 -280 -530 -260 {
lab=VDD}
N -290 -500 -290 -470 {
lab=VDD}
N -290 -270 -290 -260 {
lab=GND}
N -220 -300 -220 -260 {
lab=GND}
N -290 -410 -290 -370 {
lab=out}
N -700 -500 -700 -470 {
lab=VDD}
N -700 -380 -700 -350 {
lab=#net1}
N -700 -280 -630 -280 {
lab=GND}
N -700 -280 -700 -260 {
lab=GND}
N -700 -320 -630 -320 {
lab=GND}
N -700 -290 -700 -280 {
lab=GND}
N -630 -320 -630 -280 {
lab=GND}
N -770 -320 -740 -320 {
lab=#net1}
N -770 -380 -770 -320 {
lab=#net1}
N -770 -380 -700 -380 {
lab=#net1}
N -700 -410 -700 -380 {
lab=#net1}
N -410 -300 -330 -300 {
lab=gn}
C {sg13g2_pr/sg13_lv_nmos.sym} -310 -300 2 1 {name=m1
L=\{Lx\}
W=\{Wx\}
ng=\{nx\}
m=\{mx\}
model=sg13_lv_nmos
spiceprefix=X
}
C {devices/gnd.sym} -290 -240 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} -410 -230 0 0 {name=Vgsn value="DC 0.4780 AC 1" savecurrent=false}
C {devices/gnd.sym} -410 -180 0 0 {name=l3 lab=GND}
C {devices/code_shown.sym} -610 -620 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib $::SG13G2_MODELS/cornerMOSlv.lib mos_tt
"}
C {devices/vsource.sym} -530 -230 0 0 {name=Vd value=1.2 savecurrent=false}
C {devices/gnd.sym} -530 -180 0 0 {name=l2 lab=GND}
C {devices/lab_wire.sym} -410 -300 0 0 {name=p1 sig_type=std_logic lab=gn}
C {devices/lab_wire.sym} -220 -370 0 0 {name=p2 sig_type=std_logic lab=out}
C {devices/code_shown.sym} 0 -560 0 0 {name=COMMANDS only_toplevel=false
value="
.param temp=27
.param Wx=16.53u
.param Lx=0.86u
.param nf=\{Wx/5e-6\}
.param nx=ceil(nf)
.param mx=1

.control
*pre_osdi ./psp103_nqs.osdi
set wr_singlescale
*set wr_vecnames
option numdgt = 3

ac dec 1000 10 10Gig
save v(out)
meas ac dc_gain find vm(out) at=10
meas ac fu when vm(out)=1
plot vm(out)
write igs_ex3_4a_ac.raw v(out)

op
save @n.xm1.nsg13_lv_nmos[ids]
save @n.xm1.nsg13_lv_nmos[vgs]
save @n.xm1.nsg13_lv_nmos[vds]
save @n.xm1.nsg13_lv_nmos[gm]
save  @n.xm1.nsg13_lv_nmos[gds]
save  @n.xm1.nsg13_lv_nmos[vth]

let ids_n=@n.xm1.nsg13_lv_nmos[ids]
let vgs_n=@n.xm1.nsg13_lv_nmos[vgs]
let vds_n=@n.xm1.nsg13_lv_nmos[vds]
let gm_n=@n.xm1.nsg13_lv_nmos[gm]
let gds_n=@n.xm1.nsg13_lv_nmos[gds]
let vth_n=@n.xm1.nsg13_lv_nmos[vth]

print ids_n
print vgs_n
print vds_n
print gm_n
print gds_n
print vth_n
print gm_n/ids_n
print gm_n/gds_n
*show
write igs_ex3_4a_dc.raw 
+ ids_n vgs_n vds_n gm_n gds_n vth_n
.endc
"}
C {devices/capa-2.sym} -180 -270 0 0 {name=CL
m=1
value=1p
footprint=1206
device=polarized_capacitor}
C {devices/gnd.sym} -180 -180 0 0 {name=l4 lab=GND}
C {devices/vdd.sym} -530 -280 0 0 {name=l5 lab=VDD}
C {devices/vdd.sym} -290 -500 0 0 {name=l6 lab=VDD}
C {devices/isource.sym} -290 -440 0 0 {name=IBIAS value=180e-6}
C {devices/vdd.sym} -700 -500 0 0 {name=l7 lab=VDD}
C {devices/isource.sym} -700 -440 0 0 {name=IBIAS1 value=179.94e-6}
C {sg13g2_pr/sg13_lv_nmos.sym} -720 -320 2 1 {name=m2
L=\{Lx\}
W=\{Wx\}
ng=\{nx\}
m=\{mx\}
model=sg13_lv_nmos
spiceprefix=X
}
C {devices/gnd.sym} -700 -260 0 0 {name=l8 lab=GND}
