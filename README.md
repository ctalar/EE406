# EE406
### Required EDA software
1. Open the PowerShell and install WSL<br>
`wsl --install -d Ubuntu-22.04`<br>
You will be prompted to create a UNIX username and password.<br>
This UNIX username and password have no relationship to your Windows username and password.<br>
To avoid any confusion use a different username
2. [Install Docker Desktop](https://docs.docker.com/desktop/install/windows-install/)<br>
3. Start Ubuntu (either by typing `wsl` into the Windows's PowerShell or selecting the Ubuntu app in the Window's Start Menu) <br>
Your unix user's home directory is:<br>
`/home/<unix username>`<br>
Your Windows user's home directory is:<br>
`/mnt/c/Users/<windows username>`
5. clone the [iic-osic-tools](https://github.com/iic-jku/IIC-OSIC-TOOLS) container onto your computer (for example into your Windows user's folder)<br>
`git clone --depth=1 https://github.com/iic-jku/iic-osic-tools.git`<br>
*Example*<br>
Windows user's folder: `C:\Users\claudio`<br>
In Unix, the Windows user's folder is accessible as:
`/mnt/c/Users/claudio`<br>
5. Start Docker Desktop
6. Browse to the iic-osic-tools directory<br>
`cd /mnt/c/Users/claudio/iic-osic-tools`<be>
7. Start the container using the script `./start_x.sh`<br>
**NOTE:** in the script, all user data is persistently mounted in the directory pointed to by the environment variable `DESIGNS` <br>
The default is `$HOME/eda/designs`<br>
To change where the user data is mounted edit the `./start_x.sh` script and modify the definition of the variable `DESIGNS`<br>
*Example*<br>
`DESIGNS="/mnt/g/My Drive/eda/designs"`
8. In the unfortunate event that .Xauthority does not exist in the user home directory, it will show the below error:<br>
   ```
   xauth
   xauth:  file /root/.Xauthority does not exist
   Using authority file /root/.Xauthority
   ```
   Below are the steps to manually create .Xauthority under the user home directory:<br>
   ```
   touch ~/.Xauthority
   # Generate the magic cookie with 128 bit hex encoding
   xauth add ${HOST}:0 . $(xxd -l 16 -p /dev/urandom)
   # Verify the result and it shouldn't show any error
   xauth list
   ```

9. If everything goes as it should, you will see a terminal with the prompt `/foss/designs >`. <br>
This is your working directory where all your design data goes.
10. The default PDK is the `sky130A`. However, the container supports also other PDKs.<br>
The available PDKs are:<br>
`gf180mcuC`<br>
`sg13g2`<br>
`sky130A`<br>
If you want to switch to the IHP PDK type:<br>
`iic-pdk sg13g2`<br>
To skip typing this command every time, create a `.designinit` text file in your design directory with the following lines:<br>
```
PDK_ROOT=/foss/pdks
PDK=sg13g2
PDKPATH=/foss/pdks/sg13g2
```

### Additional software to install on your computer
1. Matlab (or Octave) <-- **required**
2. Anaconda ([link](https://docs.anaconda.com/free/anaconda/install/index.html))
3. PyLTSpice version 3.1<br>
`pip install PyLTSpice==3.1`<br>
4. [HSPICE/ngspice Toolbox](https://web02.gonzaga.edu/faculty/talarico/vlsi/matlab.html) by M. Perrott <-- **required**
