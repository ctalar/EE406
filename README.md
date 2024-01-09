# EE406
### Required EDA software
1. Open the PowerShell and install WSL<br>
`wsl --install -d Ubuntu-22.04`<br>
You will be prompted to create a UNIX username and password.<br>
This UNIX username and password have no relationship to your Windows username and password.<br>
To avoid any confusion use a different username
2. [Install Docker Desktop](https://docs.docker.com/desktop/install/windows-install/)<br>
3. Start Ubuntu (either by typing `wsl` into the Windows's PowerShell or selecting the Ubuntu app in the Window's Start Menu) <br>
Your unix user's home directory is located at:<br>
`/home/<unix username>`<br>
Your Windows user's home directory is located at:<br>
`/mnt/c/Users/<windows username>`
5. clone the [iic-osic-tools](https://github.com/iic-jku/IIC-OSIC-TOOLS) container onto your computer (for example into your Windows user's folder)<br>
`git clone --depth=1 https://github.com/iic-jku/iic-osic-tools.git`<br>
*Example*<br>
Windows user's folder: `C:\Users\claudio`<br>
In Unix, the Windows user's folder is accessible as:
`/mnt/c/Users/claudio`<br>
5. Start Docker
6. Browse to the iic-osic-tools directory<br>
`cd /mnt/c/Users/claudio/iic-osic-tools`<be>
7. Start the container using the script `./start_x.sh`
NOTE: in the script all user data is persistently mounted in the directory pointed to by the environment variable `DESIGNS` <br>
The default is `$HOME/eda/designs`
To change where the the user data is mounted edit the ./start_x.sh script and modify the definition of the variable of the `DESIGN`

### Additional software to install on your computer
1. Matlab (or Octave) <-- **required**
2. Anaconda ([link](https://docs.anaconda.com/free/anaconda/install/index.html))
3. PyLTSpice version 3.1<br>
`pip install PyLTSpice==3.1`<br>
4. [HSPICE/ngspice Toolbox](https://web02.gonzaga.edu/faculty/talarico/vlsi/matlab.html) by M. Perrott <-- **required**
