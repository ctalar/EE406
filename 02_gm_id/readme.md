## $g_{m} / I{_D}$ LUTs

To learn more about the $g_{m} / I{_D}$ see [B. Murmann's textbook on gm-ID-design](https://github.com/bmurmann/Book-on-gm-ID-design)

### Xschem's setup to generate the LUTs

The following setup is provided courtesy of B. Murmann

#### techsweep_n.sch

<p align="center">
   <img src="./img/techsweep_n.png" width="800" />
</p>

#### techsweep_p.sch
<p align="center">
   <img src="./img/techsweep_p.png" width="800" />
</p>

### Steps to generate and use the LUTs (.mat files)
- Run the NGspice simulations corresponding to the Xschem's setup (`techsweep_n.spice` and `techsweep_p.spice`)
- Read the NGspice output data (txt) into Matlab scripts and save each parameter set (NMOS, PMOS) in mat file format<br>
  (i.e. run `save_as_mat_n.m` and `save_as_mat_p.m`) 
- Use the look_up and the look_upVGS functions to read the mat file data
