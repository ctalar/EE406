v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -290 -380 -290 -360 {
lab=d}
N -410 -210 -410 -180 {
lab=GND}
N -100 -210 -100 -180 {
lab=GND}
N -190 -210 -190 -180 {
lab=GND}
N -290 -300 -290 -270 {
lab=GND}
N -190 -330 -190 -270 {
lab=b}
N -410 -330 -410 -270 {
lab=g}
N -410 -330 -330 -330 {
lab=g}
N -290 -330 -190 -330 {
lab=b}
N -290 -380 -100 -380 {
lab=d}
N -100 -380 -100 -270 {
lab=d}
C {sg13g2_pr/sg13_lv_nmos.sym} -310 -330 2 1 {name=m1
L=\{Lx\}
W=\{Wx\}
ng=\{nx\}
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {devices/gnd.sym} -290 -270 0 0 {name=l1 lab=GND}
C {devices/vsource.sym} -410 -240 0 0 {name=Vgs value=0.6 savecurrent=false}
C {devices/gnd.sym} -410 -180 0 0 {name=l3 lab=GND}
C {devices/code_shown.sym} -450 -460 0 0 {name=MODEL only_toplevel=true
format="tcleval( @value )"
value=".lib $::SG13G2_MODELS/cornerMOSlv.lib mos_tt
"}
C {devices/vsource.sym} -100 -240 0 0 {name=Vds value=0.6 savecurrent=false}
C {devices/gnd.sym} -100 -180 0 0 {name=l2 lab=GND}
C {devices/vsource.sym} -190 -240 2 1 {name=Vsb value=\{vsbx\} savecurrent=false}
C {devices/gnd.sym} -190 -180 0 0 {name=l4 lab=GND}
C {devices/lab_wire.sym} -360 -330 0 0 {name=p1 sig_type=std_logic lab=g}
C {devices/lab_wire.sym} -190 -380 0 0 {name=p2 sig_type=std_logic lab=d}
C {devices/lab_wire.sym} -190 -330 0 0 {name=p3 sig_type=std_logic lab=b}
C {devices/code_shown.sym} 0 -560 0 0 {name=COMMANDS only_toplevel=false
value="
.param temp=27
.param Wx=5u
.param Lx=0.13u
.param nx=1
.param Vsbx=0
.dc Vds 0.6 1.2 0.6 
.save @n.xm1.nsg13_lv_nmos[vth]
.save @n.xm1.nsg13_lv_nmos[ids]


.control
*pre_osdi ./psp103_nqs.osdi
set wr_singlescale
*set wr_vecnames
option numdgt = 3

foreach W_val 0.15u 0.25u 0.35u 0.45u 0.55u 0.65u 0.75u 0.85u 0.95u
+ 1u 2u 3u 4u 5u 6u 7u 8u 9u 10u 11u 12u 13u 14u 15u 16u 17u 18u 19u 20u
+ 25u 30u 35u 40u 45u 50u
  alterparam Wx = $W_val
  reset
  run
  wrdata vt_W_n.txt all
  destroy $curplot
  set appendwrite
end
* show
.endc
"}
