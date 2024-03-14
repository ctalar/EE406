v {xschem version=2.9.9 file_version=1.2 }
G {}
K {}
V {}
S {}
E {}
N -10 -100 60 -100 { lab=vdm}
N -10 -40 60 -40 { lab=vcm}
N 340 -100 430 -100 { lab=vplus}
N 340 -40 430 -40 { lab=vminus}
C {devices/iopin.sym} 0 -100 0 1 {name=p1 lab=vdm
}
C {devices/iopin.sym} 0 -40 0 1 {name=p2 lab=vcm
}
C {devices/iopin.sym} 420 -100 0 0 {name=p3 lab=vplus
}
C {devices/iopin.sym} 420 -40 0 0 {name=p4 lab=vminus

}
C {devices/code_shown.sym} 90 -170 0 0 {name=balun only_toplevel=false value="
*Balun Circuit - by K. Kundert
e1 nodeA vcm vdm 0 0.5
v1 vplus nodeA 0
f1 vdm 0 v1 -0.5
r1 vdm 0 1G
e2 nodeB vminus vdm 0 0.5
v2 vcm nodeC 0
f2 vdm 0 v2 -0.5
r2 nodec nodeB 1u
"}
