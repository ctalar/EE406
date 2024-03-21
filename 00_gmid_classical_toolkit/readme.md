## $g_{m}/I_{D}$ Methodology

The best way to start designing circuits with the $g_m/I_D$ methodology is to use the LUTs (.mat files) provided by B. Murmann in the [textbook:
Systematic Design of Analog CMOS Circuits](https://github.com/bmurmann/Book-on-gm-ID-design/tree/main/starter_kit)<br>
The .mat files (180nch.mat and 180pch.mat) are based on BSIM3 models of a typical 180-nm CMOS process (ee214_hspice.mod).<br>
The functions that can read and interpolate the created lookup tables (mat files) are look_up.m and look_upVGS.m.

---

### $g_{m}/I_{D}$ Design Examples

| Example  | Link  | Comments  |
|---|---|---|
| CS with resistive load and ideal driver |[01](https://github.com/claudiotalarico/EE406/blob/main/00_gmid_classical_toolkit/examples/01_example.md)| | 
| Differential Pair with resistive load and resistive drivers | [02](https://github.com/claudiotalarico/EE406/blob/main/00_gmid_classical_toolkit/examples/02_example.md)| |

