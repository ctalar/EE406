## IGS: sizing at constant $|A_{V0}|$

Consider an IGS with $C_{L}$ = 1 pF and constant $|A_{V0}|$=30. <br>
Find combinations of $L$ and $g_{m}/I_{D}$ that 1) maximize unity gain frequency or 2) minimize current consumption<br>
and achieves at least 70% of the maximum unity gain frequency.

Sizing for constant $|A_{V0}|$ is common when designing operational amplifiers to be used in circuits for which we want<br>
a certain target feedback loop gain. <br> 

#### matlab's design script (igs_ex3_4.m)
```

```

<p align="center">
   <img src="./img/IGS_ex3_4_a.png" width="600" >
</p>
<p align="center">
<b>Figure 3.13 (a)</b> Transit frequency $f_{T}$ and DC gain $|A_{v0}|$ versus $g_{m}/I_{D}$ for three values of L

<p align="center">
   <img src="./img/IGS_ex3_4_b.png" width="600" >
</p>
<p align="center">
<b>Figure 3.13 (b)</b> $f_T$ and $g_{m}/I_{D}$ versus $L$ at $|A_{v0}|=30$

<p align="center">
   <img src="./img/IGS_ex3_4_c.png" width="600" >
</p>
<p align="center">
<b>Figure 3.14 (a) </b> Transit frequency $f_{T}$ vs. $g_{m}/I_{D}$ at $|A_{v0}|=30$<br>
The circles mark the design parameters that maximize $f_u$<br>
The asterisks mark the design parameters that minimize current for a 30% reduction of the $f_u$
<p align="center">
   <img src="./img/IGS_ex3_4_d.png" width="600" >
</p>
<p align="center">
<b>Figure 3.14 (b) </b> gate length $L$ vs. $g_{m}/I_{D}$ at $|A_{v0}|=25$<br>
The circles mark the design parameters that maximize $f_u$<br>
The asterisks mark the design parameters that minimize current for a 30% reduction of the $f_u$

**Design Parameters: Results Summary**<br>
option 1: maximize fT<br> 
Av0 = 30; gm/ID = 8.10 (S/A); ID = 1.80e-04 (A); VGS = 0.4708 (V); fu = 2.32e+08 (Hz); L = 0.86 (um); W = 16.53 (um); 

option 2: minimize current (30 percent fT reduction)<br>
Av0 = 30; gm/ID = 11.77 (S/A); ID = 9.12e-05 (A); VGS = 0.3782 (V); fu = 1.71e+08 (Hz); L = 0.79 (um); W = 19.90 (um); 
