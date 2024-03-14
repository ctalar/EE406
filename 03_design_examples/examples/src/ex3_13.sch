v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N -330 110 -330 140 { lab=GND}
N -330 -20 -330 50 { lab=vid}
N -330 -20 -210 -20 { lab=vid}
N -270 20 -210 20 { lab=vic}
N -270 110 -270 140 { lab=GND}
N -270 20 -270 50 { lab=vic}
N 90 -20 170 -20 { lab=vip}
N 320 10 320 50 { lab=tail}
N 430 50 540 50 { lab=tail}
N 540 10 540 50 { lab=tail}
N 430 -20 540 -20 { lab=GND}
N 540 -70 540 -50 { lab=vom}
N 320 -110 320 -50 { lab=vop}
N 540 -140 540 -70 { lab=vom}
N 320 -240 320 -200 { lab=dd}
N 540 -240 540 -200 { lab=dd}
N 320 -240 540 -240 { lab=dd}
N 430 170 430 210 { lab=GND}
N 430 50 430 110 { lab=tail}
N 160 -240 160 -210 { lab=dd}
N 160 -150 160 -120 { lab=GND}
N 580 -20 620 -20 { lab=gm}
N 620 -20 620 80 { lab=gm}
N 660 -110 740 -110 { lab=vop}
N 720 -70 740 -70 { lab=vom}
N 1040 -110 1130 -110 { lab=vod}
N 1040 -70 1130 -70 { lab=voc}
N 160 -240 320 -240 { lab=dd}
N 320 -140 320 -110 { lab=vop}
N 430 -20 430 -10 {
lab=GND}
N 320 -20 430 -20 { lab=GND}
N 660 -110 660 -30 {
lab=vop}
N 320 -110 660 -110 { lab=vop}
N 720 -70 720 -30 {
lab=vom}
N 540 -70 720 -70 { lab=vom}
N 660 30 660 60 {
lab=GND}
N 720 30 720 60 {
lab=GND}
N 150 20 150 80 {
lab=vim}
N 220 -20 280 -20 {
lab=gp}
N 90 20 150 20 {
lab=vim}
N 150 80 170 80 {
lab=vim}
N 320 50 430 50 { lab=tail}
N 230 80 620 80 {
lab=gm}
C {devices/gnd.sym} 430 210 0 0 {name=l5 lab=GND}
C {sg13g2_pr/sg13_lv_nmos.sym} 300 -20 2 1 {name=M1
L=\{Lx\}
W=\{Wx\}
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {sg13g2_pr/sg13_lv_nmos.sym} 560 -20 2 0 {name=M2
L=\{Lx\}
W=\{Wx\}
ng=1
m=1
model=sg13_lv_nmos
spiceprefix=X
}
C {devices/gnd.sym} -330 140 0 0 {name=l1 lab=GND}
C {devices/gnd.sym} -270 140 0 0 {name=l3 lab=GND}
C {devices/gnd.sym} 160 -120 0 0 {name=l6 lab=GND}
C {devices/isource.sym} 430 140 0 0 {name=ITAIL value=701.6u}
C {devices/res.sym} 540 -170 0 0 {name=R2
value=1k
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 320 -170 0 0 {name=R1
value=1k
footprint=1206
device=resistor
m=1}
C {devices/vsource.sym} 160 -180 0 0 {name=VDD value=1.2 savecurrent=false}
C {devices/vsource.sym} -270 80 0 0 {name=Vc value="DC 0.75" savecurrent=false
}
C {devices/vsource.sym} -330 80 0 1 {name=Vd value="DC 0 AC 1" savecurrent=false}
C {devices/lab_wire.sym} 640 -110 0 0 {name=p1 sig_type=std_logic lab=vop}
C {devices/lab_wire.sym} 640 -70 0 0 {name=p2 sig_type=std_logic lab=vom}
C {devices/gnd.sym} 430 -10 0 0 {name=l2 lab=GND}
C {devices/lab_wire.sym} 410 50 0 0 {name=p3 sig_type=std_logic lab=tail}
C {devices/lab_wire.sym} 140 -20 0 0 {name=p4 sig_type=std_logic lab=vip}
C {devices/lab_wire.sym} 140 20 0 0 {name=p5 sig_type=std_logic lab=vim}
C {devices/lab_wire.sym} 240 -240 0 0 {name=p6 sig_type=std_logic lab=dd}
C {devices/capa-2.sym} 660 0 0 0 {name=C1
m=1
value=50f
footprint=1206
device=polarized_capacitor}
C {devices/capa-2.sym} 720 0 0 0 {name=C2
m=1
value=50f
footprint=1206
device=polarized_capacitor}
C {devices/gnd.sym} 660 60 0 0 {name=l4 lab=GND}
C {devices/gnd.sym} 720 60 0 0 {name=l7 lab=GND}
C {devices/lab_wire.sym} -230 -20 0 0 {name=p7 sig_type=std_logic lab=vid}
C {devices/lab_wire.sym} -230 20 0 0 {name=p8 sig_type=std_logic lab=vic}
C {devices/res.sym} 200 -20 3 0 {name=Rsp
value=10k
footprint=1206
device=resistor
m=1}
C {devices/res.sym} 200 80 3 1 {name=Rsm
value=10k
footprint=1206
device=resistor
m=1}
C {devices/lab_wire.sym} 260 -20 0 0 {name=p9 sig_type=std_logic lab=gp}
C {devices/lab_wire.sym} 610 -20 0 0 {name=p10 sig_type=std_logic lab=gm}
C {devices/code_shown.sym} 0 260 0 0 {name=COMMANDS only_toplevel=false 
value="
.param temp=27
.param Wx=58.11u
.param Lx=0.13u
.param nf=\{Wx/5e-6\}
.param nx=ceil(nf)

.save all

.control
*pre_osdi ./psp103_nqs.osdi
set wr_singlescale
.option numdgt = 3

ac dec 1000 10 1000e9
save v(vod)
meas ac av0db find vdb(vod) at=10
meas ac av0 find vm(vod) at=10
let av03db = av0db - 3
meas ac f3db when vdb(vod)=av03db
meas ac fu when vm(vod)=1
write ex3_13_ac.raw v(vod)
plot vm(vod) 
* plot vdb(vod) 
* plot \{180*vp(vod)/pi\}

op
show n.xm1.nsg13_lv_nmos : ids vgs vds gm gds cdd cgg cgs cgd cgb cdg cgsol cgdol cjd cds cdb
show n.xm2.nsg13_lv_nmos : ids vgs vds gm gds cdd cgg cgs cgd cgb cdg cgsol cgdol cjd cds cdb
print v(tail)
.endc
"}
C {/foss/designs/gmid/balun.sym} -60 0 0 0 {name=x1}
C {/foss/designs/gmid/balun.sym} 890 -90 0 1 {name=x2}
C {devices/lab_wire.sym} 1100 -110 0 0 {name=p11 sig_type=std_logic lab=vod}
C {devices/lab_wire.sym} 1100 -70 0 0 {name=p12 sig_type=std_logic lab=voc}
C {devices/code_shown.sym} -250 -320 0 0 {name=MODELS only_toplevel=false 
format="tcleval( @value )"
value=".lib $::SG13G2_MODELS/cornerMOSlv.lib mos_tt
"}
