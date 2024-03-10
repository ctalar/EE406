v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -290 -370 -290 -330 {
lab=out}
N -720 -470 -720 -450 {
lab=GND}
N -290 -260 -220 -260 {
lab=GND}
N -290 -260 -290 -240 {
lab=GND}
N -290 -370 -180 -370 {
lab=out}
N -720 -550 -720 -530 {
lab=VDD}
N -290 -480 -290 -470 {
lab=VDD}
N -290 -270 -290 -260 {
lab=GND}
N -220 -300 -220 -260 {
lab=GND}
N -290 -440 -220 -440 {
lab=VDD}
N -290 -480 -220 -480 {
lab=VDD}
N -290 -500 -290 -480 {
lab=VDD}
N -220 -480 -220 -440 {
lab=VDD}
N -520 -530 -520 -520 {
lab=VDD}
N -520 -490 -450 -490 {
lab=VDD}
N -520 -530 -450 -530 {
lab=VDD}
N -450 -530 -450 -490 {
lab=VDD}
N -600 -210 -510 -210 {
lab=GND}
N -600 -210 -600 -190 {
lab=GND}
N -600 -220 -600 -210 {
lab=GND}
N -510 -250 -510 -210 {
lab=GND}
N -600 -400 -600 -380 {
lab=VDD}
N -290 -410 -290 -370 {
lab=out}
N -520 -360 -520 -340 {
lab=GND}
N -520 -560 -520 -530 {
lab=VDD}
N -360 -150 -360 -130 {
lab=GND}
N -520 -440 -520 -420 {
lab=gp}
N -180 -270 -180 -240 {
lab=GND}
N -180 -370 -180 -330 {
lab=out}
N -600 -250 -510 -250 {
lab=GND}
N -600 -300 -600 -280 {
lab=gn}
N -290 -300 -220 -300 {
lab=GND}
N -360 -300 -330 -300 {
lab=gn}
N -600 -330 -600 -300 {
lab=gn}
N -670 -300 -600 -300 {
lab=gn}
N -670 -300 -670 -250 {
lab=gn}
N -670 -250 -640 -250 {
lab=gn}
N -520 -460 -520 -440 {
lab=gp}
N -600 -440 -520 -440 {
lab=gp}
N -600 -490 -600 -440 {
lab=gp}
N -600 -490 -560 -490 {
lab=gp}
N -360 -300 -360 -270 {
lab=gn}
N -360 -230 -360 -200 {
lab=#net1}
N -520 -440 -330 -440 {
lab=gp}
N -600 -300 -360 -300 {
lab=gn}
C {sg13g2_pr/sg13_lv_nmos.sym} -310 -300 2 1 {name=m1
L=0.29u
W=47.59u
ng=10
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {devices/vsource.sym} -360 -170 0 0 {name=Vin value="DC 0 AC 1" savecurrent=false
}
C {devices/gnd.sym} -360 -130 0 0 {name=l3 lab=GND}
C {devices/code_shown.sym} -450 -610 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib $::SG13G2_MODELS/cornerMOSlv.lib mos_tt
"}
C {devices/vsource.sym} -720 -500 0 0 {name=Vd value=1.2 savecurrent=false}
C {devices/gnd.sym} -720 -450 0 0 {name=l2 lab=GND}
C {devices/lab_wire.sym} -220 -370 0 0 {name=p2 sig_type=std_logic lab=out}
C {devices/code_shown.sym} 0 -560 0 0 {name=COMMANDS only_toplevel=false
value="
.param temp=27

.control
*pre_osdi ./psp103_nqs.osdi
set wr_singlescale
*set wr_vecnames
option numdgt = 3

save all

ac dec 1000 10 10Gig
meas ac dc_gain find vm(out) at=10
meas ac fu when vm(out)=1
plot vm(out)
write cs_ex3_8_ac.raw v(out)

op
save @n.xm1.nsg13_lv_nmos[ids]
save @n.xm1.nsg13_lv_nmos[gm]
save @n.xm1.nsg13_lv_nmos[gds]
save @n.xm1.nsg13_lv_nmos[vth]
save @n.xm2.nsg13_lv_pmos[ids]
save @n.xm2.nsg13_lv_pmos[gm]
save @n.xm2.nsg13_lv_pmos[gds]
save @n.xm2.nsg13_lv_pmos[vth]

let ids_n=@n.xm1.nsg13_lv_nmos[ids]
let gm_n=@n.xm1.nsg13_lv_nmos[gm]
let gds_n=@n.xm1.nsg13_lv_nmos[gds]
let vth_n=@n.xm1.nsg13_lv_nmos[vth]
let ids_p=@n.xm2.nsg13_lv_pmos[ids]
let gm_p=@n.xm2.nsg13_lv_pmos[gm]
let gds_p=@n.xm2.nsg13_lv_pmos[gds]
let vth_p=@n.xm2.nsg13_lv_pmos[vth]

print ids_n
print gm_n
print gm_n/ids_n
print ids_p
print gm_p
print gm_p/ids_p
print v(gp) v(gn) v(out)
write cs_ex3_8_dc.raw 
+ ids_n gm_n gds_n vth_n ids_p gm_p gds_p vth_p
*show
.endc
"}
C {devices/capa-2.sym} -180 -300 0 0 {name=CL
m=1
value=1p
footprint=1206
device=polarized_capacitor}
C {devices/gnd.sym} -180 -240 0 0 {name=l4 lab=GND}
C {devices/vdd.sym} -720 -550 0 0 {name=l5 lab=VDD}
C {devices/vdd.sym} -290 -500 0 0 {name=l6 lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} -310 -440 0 0 {name=m2
L=0.50u
W=343.04u
ng=69
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_pmos.sym} -540 -490 0 0 {name=m3
L=0.50u
W=343.04u
ng=69
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {devices/vdd.sym} -520 -550 0 0 {name=l8 lab=VDD}
C {sg13g2_pr/sg13_lv_nmos.sym} -620 -250 2 1 {name=m4
L=0.29u
W=47.59u
ng=10
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {devices/gnd.sym} -600 -190 0 0 {name=l9 lab=GND}
C {devices/vdd.sym} -600 -400 0 0 {name=l10 lab=VDD}
C {devices/isource.sym} -600 -350 0 0 {name=I1 value=891.49u}
C {devices/isource.sym} -520 -390 0 0 {name=I2 value=891.49u}
C {devices/gnd.sym} -520 -340 0 0 {name=l11 lab=GND}
C {devices/capa-2.sym} -360 -250 0 0 {name=Cc
m=1
value=1
footprint=1206
device=polarized_capacitor}
C {devices/gnd.sym} -290 -240 0 0 {name=l1 lab=GND}
C {devices/lab_wire.sym} -410 -300 0 0 {name=p4 sig_type=std_logic lab=gn}
C {devices/lab_wire.sym} -410 -440 0 0 {name=p1 sig_type=std_logic lab=gp}
