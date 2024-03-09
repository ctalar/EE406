## Sizing a CS stage with active load

Consider a common source with a p-channel load. Assume $C_{L}$ = 1 pF, $f_{T}$=10 GHz and FO = 10 ( $\leftrightarrow$ $f_u$ = 1 GHz). <br>
Find combinations of $L_n$ and $(g_{m}/I_{D})_{n}$ that maximize the DC gain $Av_0$ and evaluate the impact of $L_p$.

<p align="lect">
$A_{v0}$ = $-$ $\dfrac{\left( \dfrac{g_m}{I_D} \right)_n}{\left( \dfrac{g_{ds}}{I_D} \right)_n \;+ \; \left( \dfrac{g_{ds}}{I_D} \right)_p }$
</p>

---

To maximize the gain we should make $(g_{ds}/I_D)_p$ as small as possible (i.e., the p-channel transistor should operate in strong inversion).
However, strong inversion means large drain saturation voltage, and therefore loss of output signal swing.

To avoid excessive loss of output dynamics assume $V_{DsatP} \leq 0.2 V$  

$V_{DsatP} = \dfrac{2}{(g_m/I_D)_p}$ $\leftrightarrow$  $({g_m}/{I_D})_p \geq 10 \ S/A $

---

#### matlab's design script (cs_ex3_8.m - part 1)
```
% File: cs_ex3_8.m
% source: Jesper and Murmann textbook
% example 3_8 pp. 95-99
% design of CS with active p-channel transistor load

clear all; clearvars; close all; clc;

addpath('~/ihome/class/gmidLUTs;~/ihome/class/gmidTECHs')
load ('sg13_lv_nmos.mat');
load ('sg13_lv_pmos.mat');

% specs
CL = 1e-12;
VSB = 0;
VDD = 1.2;
VDS = VDD/2;
FT = 10e9;

% ============= PART 1 ================

% Gaining intuition about the impact of L2
% == data
L2 = .2*(1:5);  % L = [0.2 0.4 0.6 0.8 1.0] um 
gm_ID2 = 3:28;  % (S/A)
% == compute
gds_ID2 = look_up(pch,'GDS_ID','GM_ID',gm_ID2,'L',L2);
% == plot
h = figure(1);
plot(gm_ID2,gds_ID2,'linewidth',1); 
axis([2 max(gm_ID2)+1 0 0.4]); 
grid off;
xlabel('({g_m}/{I_D})_p   (S/A)','FontSize',12);
ylabel('({g_d_s}/{I_D})_p   (S/A)','fontsize',12);
% "automate" the creation of the legend
for i=1:5
   legstr{i} = ['L_p = ',num2str(L2(i),'%.2f'),' \mum'];
end
legend(legstr,'location','best','fontsize',12,'box','on');
```

<p align="center">
   <img src="./img/CD_ex3_8_a.png" width="600" >
</p>
<p align="center">
<b>Figure 3.24 </b> $(g_{ds}/I_{D})_p$ vs. $(g_{m}/I_D)_p$ for various L <br>

---

To size the CS we begin with the IGS "associated" to the n-channel transistor.

We define a suitable range of $L_{n}$ and compute the corresponding $(g_m/I_D)_n$ vector to achieve the required transient frequency $f_T$. 

This procedure also provides the corresponding $(g_{ds}/I_D)_n$ 
