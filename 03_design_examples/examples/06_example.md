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

$V_{DsatP} = \dfrac{2}{(g_m/I_D)_p}$ $\leftrightarrow$  $({g_m}{I_D})_p \geq 10 \ S/A $

To size the CS we begin with the IGS "associated" to the n-channel transistor.

We define a suitable range of $L_{n}$ and compute the corresponding $(g_m/I_D)_n$ vector to achieve the required transient frequency $f_T$. 

This procedure also provides the corresponding $(g_{ds}/I_D)_n$ 

---

#### matlab's design script (cs_ex3_8.m - part 1)
``` 
```

