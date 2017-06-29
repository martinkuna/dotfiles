##################
# MARTIN'S GUAKE #
##################

# if called at startup run guake, otherwise call init from guake config
#/usr/bin/guake &
sleep 5 # let main guake process start and initialize D-Bus session

# adjust tab which was opened by default to show htop
guake --rename-tab="htop" --execute="/usr/bin/htop"

# home
guake --new-tab --execute="/usr/bin/bash"
guake --rename-current-tab="home"

# OKL-master aka CLEAN dir
guake --new-tab --execute="/usr/bin/bash"
guake --execute="cd /home/$USER/OKL/repos/okl4-master/"
guake --rename-current-tab="OKL-master"

# OKL dir
guake --new-tab --execute="/usr/bin/bash"
guake --execute="cd /home/$USER/OKL/repos/okl4/"
guake --rename-current-tab="OKL"

# shell 0
guake --new-tab --execute="/usr/bin/bash"
guake --execute="cd /home/$USER/OKL/repos/"
guake --rename-current-tab="shell 0"

# shell 1
guake --new-tab --execute="/usr/bin/bash"
guake --execute="cd /home/$USER/OKL/repos/"
guake --rename-current-tab="shell 1"

# example
guake --new-tab --execute="/usr/bin/bash"
guake --execute="cd /home/$USER/OKL/repos/"
guake --rename-current-tab="example"

# create new tab, start bash session in it
#guake --new-tab --execute="/usr/bin/bash"

# rootshell
#guake --new-tab --execute="/usr/bin/bash"
#guake --execute="/usr/bin/sudo -i" --rename-current-tab="rootshell"

