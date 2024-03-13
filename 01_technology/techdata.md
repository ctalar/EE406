Source: [B. Murmann's github](https://github.com/bmurmann/EE628/tree/main/4_Technology)
<p align="center">
   <img src="./img/gm_ID-VGS.png" width="800" />
</p>

In the above plot, $f_T=(1/2\pi) \cdot g_m/C_{GG}$, where $C_{GG} = cgg+cgsol+cgdol$. The lower case variables are the capacitances reported by NGspice.

<p align="center">
   <img src="./img/gm_IDfT-gm_ID.png" width="800" />
</p>

The plot above shows the product $g_m/I_D \cdot f_T$. The peak can be viewed as a biasing sweet spot. The unusual "hump" for the NMOS curve hints at modeling issues in moderate inversion ($g_m/I_D>10 S/A$). These curves usually look like upside-down parabolas without drastic slope changes.

<p align="center">
   <img src="./img/fT-gm_ID.png" width="800" />
</p>

<p align="center">
   <img src="./img/Aintr-gm_ID.png" width="800" />
</p>

The above NMOS plot has an odd-looking curvature at the transition between strong to moderate inversion.

<p align="center">
   <img src="./img/JD-gm_ID.png" width="800" />
</p>

<p align="center">
   <img src="./img/JD-gm_ID-for-VDS.png" width="800" />
</p>

The above plot shows that the dependency of the current density $I_D/W$ on $V_{DS}$ is weak. Typically it is ok to work with data generated at $V_{DD}/2$.

<p align="center">
   <img src="./img/JD-VDS.png" width="800" />
</p>

---

<p align="center">
   <img src="./img/Cdd_W-VDS.png" width="800" />
</p>

In the above plot, $C_{DD} = cdd+cgdol+cjd$. The lower case variables are the capacitances reported by NGspice.

<p align="center">
   <img src="./img/Cdd_Cgg_and_Cgd_Cgg-VDS.png" width="800" />
</p>

In the above plot, $C_{DD} = cdd+cgdol+cjd$,  $C_{GG} = cgg + cgdol + cgsol$ and $C_{GD} = cgd = cgdol$.
The lower-case variables are the capacitances reported by NGspice.

**NOTE:** for $V_{DS} > 0.2V$ the ratios of the capacitances don't vary much.

At $V_{DS}=0.6V$: <br>
$(C_{DD}/C_{GG})n = 0.5789$ and $(C_{DD}/C_{GG})p = 0.5582$<br>
$(C_{GD}/C_{GG})n = 0.3762$ and $(C_{GD}/C_{GG})p = 0.3394$

