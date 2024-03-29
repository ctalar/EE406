v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -380 -200 -380 -180 {
lab=GND}
N -380 -300 -380 -260 {
lab=in}
N -290 -300 -220 -300 {
lab=GND}
N -290 -270 -290 -230 {
lab=GND}
N -290 -340 -290 -330 {
lab=out}
N -290 -340 -140 -340 {
lab=out}
N -290 -360 -290 -340 {
lab=out}
N -380 -390 -330 -390 {
lab=in}
N -380 -390 -380 -300 {
lab=in}
N -380 -300 -330 -300 {
lab=in}
N -520 -480 -520 -460 {
lab=VDD}
N -520 -400 -520 -380 {
lab=GND}
N -140 -250 -140 -230 {
lab=GND}
N -140 -340 -140 -310 {
lab=out}
N -290 -390 -200 -390 {
lab=VDD}
N -290 -480 -290 -420 {
lab=VDD}
C {sg13g2_pr/sg13_lv_nmos.sym} -310 -300 2 1 {name=m1
L=0.13u
W=1u
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {devices/gnd.sym} -290 -230 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} -380 -230 0 1 {name=Vin value="DC 0 PULSE(0 1.2 10n 1n 1n 4n 10n)" savecurrent=false
}
C {devices/gnd.sym} -380 -180 0 0 {name=l3 lab=GND}
C {devices/code_shown.sym} -610 -620 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib $::SG13G2_MODELS/cornerMOSlv.lib mos_tt
"}
C {devices/lab_wire.sym} -380 -340 0 0 {name=p1 sig_type=std_logic lab=in

}
C {devices/code_shown.sym} 0 -560 0 0 {name=COMMANDS only_toplevel=false
value="
.param temp=27

.control
*pre_osdi ./psp103_nqs.osdi
set wr_singlescale
option numdgt = 3

DC Vin 0 1.2 10m
save all
plot v(out)
let VP = 1.2
let VO_mid = VP/2
let dvout = deriv(v(out))
plot dvout
meas DC VSW find v(in) when v(out)=VO_mid
meas DC VIL find v(in) when dvout=-1 CROSS=1
meas DC VIH find v(in) when dvout=-1 CROSS=2
meas DC VOL find v(out) when dvout=-1 CROSS=2
meas DC VOH find v(out) when dvout=-1 CROSS=1
echo VTC measurements
print VSW
print VIL
print VIH
print VOL
print VOH
echo
write ./spiceout/inverter_vtc.raw v(in) v(out) dvout VSW VIL VIH VOL VOH

tran 10p 40n
plot v(in) v(out)
meas tran t_rise TRIG v(out) VAL=0.12 rise=2 TARG v(out) VAL=1.08 rise=2
meas tran t_fall TRIG v(out) VAL=1.08 fall=2 TARG v(out) VAL=0.12 fall=2
meas tran t_delay TRIG v(in) VAL=0.6 rise=2 TARG v(out) VAL=0.6 fall=2
echo TRAN measurements
print t_rise
print t_fall
print t_delay
echo
write ./spiceout/inverter_tran.raw v(in) v(out) t_rise t_fall t_delay

.endc
"}
C {devices/gnd.sym} -220 -300 3 1 {name=l4 lab=GND}
C {sg13g2_pr/sg13_lv_pmos.sym} -310 -390 0 0 {name=M2
L=0.13u
W=1u
ng=1
m=1
model=sg13_lv_pmos
spiceprefix=X
}
C {devices/vdd.sym} -290 -480 0 0 {name=l2 lab=VDD}
C {devices/vdd.sym} -520 -480 0 0 {name=l5 lab=VDD}
C {devices/vsource.sym} -520 -430 0 1 {name=Vd value="DC 1.2" savecurrent=false
}
C {devices/gnd.sym} -520 -380 0 0 {name=l6 lab=GND}
C {devices/lab_wire.sym} -170 -340 0 0 {name=p2 sig_type=std_logic lab=out

}
C {devices/capa-2.sym} -140 -280 0 0 {name=C1
m=1
value=50f
footprint=1206
device=polarized_capacitor
}
C {devices/gnd.sym} -140 -230 0 0 {name=l7 lab=GND}
C {devices/vdd.sym} -200 -390 1 0 {name=l8 lab=VDD}
