v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -290 -370 -290 -330 {
lab=out}
N -100 -420 -100 -400 {
lab=GND}
N -290 -260 -220 -260 {
lab=GND}
N -290 -260 -290 -240 {
lab=GND}
N -290 -370 -180 -370 {
lab=out}
N -100 -500 -100 -480 {
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
N -290 -410 -290 -370 {
lab=out}
N -180 -270 -180 -240 {
lab=GND}
N -180 -370 -180 -330 {
lab=out}
N -290 -300 -220 -300 {
lab=GND}
N -400 -210 -400 -190 {
lab=GND}
N -400 -300 -330 -300 {
lab=gn}
N -400 -360 -400 -340 {
lab=GND}
N -400 -440 -400 -410 {
lab=gp}
N -400 -440 -330 -440 {
lab=gp}
N -400 -300 -400 -260 {
lab=gn}
C {sg13g2_pr/sg13_lv_nmos.sym} -310 -300 2 1 {name=m1
L=0.29u
W=47.55u
ng=10
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {devices/code_shown.sym} -450 -610 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib $::SG13G2_MODELS/cornerMOSlv.lib mos_tt
"}
C {devices/vsource.sym} -100 -450 0 0 {name=Vd value=1.2 savecurrent=false}
C {devices/gnd.sym} -100 -400 0 0 {name=l2 lab=GND}
C {devices/lab_wire.sym} -220 -370 0 0 {name=p2 sig_type=std_logic lab=out}
C {devices/code_shown.sym} 0 -560 0 0 {name=COMMANDS only_toplevel=false
value=".param temp=27

.control
*pre_osdi ./psp103_nqs.osdi
set wr_singlescale
*set wr_vecnames
option numdgt = 3

save all
dc vin 0 1.2 0.001
write cs_ex3_9_dc_sweep.raw 
wrdata cs_ex3_9_dc_sweep.txt v(gn) v(out)
plot v(out)
.endc
"}
C {devices/capa-2.sym} -180 -300 0 0 {name=CL
m=1
value=1p
footprint=1206
device=polarized_capacitor}
C {devices/gnd.sym} -180 -240 0 0 {name=l4 lab=GND}
C {devices/vdd.sym} -100 -500 0 0 {name=l5 lab=VDD}
C {devices/vdd.sym} -290 -500 0 0 {name=l6 lab=VDD}
C {sg13g2_pr/sg13_lv_pmos.sym} -310 -440 0 0 {name=m2
L=0.50u
W=342.78u
ng=69
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {devices/gnd.sym} -290 -240 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} -400 -230 0 0 {name=Vin value="DC 0.4955" savecurrent=false
}
C {devices/gnd.sym} -400 -190 0 0 {name=l7 lab=GND}
C {devices/vsource.sym} -400 -380 0 0 {name=Vin2 value="DC 0.6671" savecurrent=false
}
C {devices/gnd.sym} -400 -340 0 0 {name=l12 lab=GND}
C {devices/lab_wire.sym} -360 -300 0 0 {name=p1 sig_type=std_logic lab=gn}
C {devices/lab_wire.sym} -360 -440 0 0 {name=p3 sig_type=std_logic lab=gp}
