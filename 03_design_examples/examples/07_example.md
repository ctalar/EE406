## Large signal characteristic of CS stage with active load

The DC transfer characteristic ($v_{OUT}$ vs. $v_{IN}$) allows to assess the available output voltage swing.

---

#### matlab's design script (CS_ex3_9.m)
```
% File: cs_ex3_9.m
% source: Jesper and Murmann textbook
% example 3_9 pp. 98-99
% large signal characteristic of CS with active p-channel load

% ================== PART 1 ===============================

clear all
close all
clc
addpath('~/ihome/class/gmidLUTs;~/ihome/class/gmidTECHs')

load ('sg13_lv_nmos.mat');
load ('sg13_lv_pmos.mat');

% specs ===========
VDD = 1.2;
CL  = 1e-12;
fT = 10e9; 
FO = 10;

gm_ID2 = 10;     % VDSat2 = 0.2V
L2 = 0.5;

% compute gain ========
VDS = .6;     	
LL  = .13: .01: .5;

gm_ID1  = look_up(nch,'GM_ID','GM_CGG',2*pi*fT,'VDS',VDS,'L',LL);
gds_ID1 = look_up(nch,'GDS_ID','GM_CGG',2*pi*fT,'VDS',VDS,'L',LL);
gds_ID2 = look_up(pch,'GDS_ID','GM_ID',gm_ID2,'VDS',VDD - VDS,'L',L2);

% maximize gain =========
Av = gm_ID1./(gds_ID1 + gds_ID2);
[a b] = max(Av);   % find L1 making Av max
L1  = LL(b);
Avo = Av(b)

% de-normalize and introduce parasitc cap ===========
JDn    = look_up(nch,'ID_W','GM_ID',gm_ID1(b),'VDS',VDS,'L',L1);
Cdd_Wn = look_up(nch,'CDD_W','GM_ID',gm_ID1(b),'VDS',VDS,'L',L1);
JDp    = look_up(pch,'ID_W','GM_ID',gm_ID2,'VDS',VDD - VDS,'L',L2);
Cdd_Wp = look_up(pch,'CDD_W','GM_ID',gm_ID2,'VDS',VDD - VDS,'L',L2);

Cdd = 0;
for k = 1:5,
    gm = 2*pi*fT/FO*(CL+Cdd);
    ID = gm/gm_ID1(b);
    Wn = ID/JDn;
    Wp = ID/JDp;
    Cdd = Wn*Cdd_Wn + Wp*Cdd_Wp;
end

% results ==============
L1
Wn
L2
Wp
ID
gm_id1 = gm_ID1(b)
gm_ID2

VGS1 = look_upVGS(nch,'GM_ID',gm_ID1(b),'VDS',VDS,'L',L1)
VGS2 = look_upVGS(pch,'GM_ID',gm_ID2,'VDS',VDD - VDS,'L',L2);
VG2 = VDD - VGS2
fu = gm/(2*pi*(CL+Cdd))
Cdd
```
