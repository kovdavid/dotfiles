#!/bin/bash

function remove_and_link_dir {
    $(rm -rf ~/.$1)
    if [ -d /opt/$1 ] ; then
        $(ln -s /opt/$1 ~/.$1)
    else
        $(ln -s /tmp ~/.$1)
    fi
}

mkdir -p /opt/javascript/config/yarn
mkdir -p /opt/javascript/meteor
mkdir -p /opt/javascript/node
mkdir -p /opt/javascript/pnpm
mkdir -p /opt/javascript/npm
mkdir -p /opt/javascript/npm-packages
mkdir -p /opt/javascript/nvm
mkdir -p /opt/javascript/fnm
mkdir -p /opt/javascript/yarn

rm -rf ~/.meteor; ln -sf /opt/javascript/meteor ~/.meteor
rm -rf ~/.npm; ln -sf /opt/javascript/npm ~/.npm
rm -rf ~/.yarn; ln -sf /opt/javascript/yarn ~/.yarn
rm -rf ~/.config/yarn; ln -sf /opt/javascript/config/yarn ~/.config/yarn
rm -rf ~/.local/share/fnm; ln -sf /opt/javascript/fnm ~/.local/share/fnm

echo "Linking scripts"
mkdir -p ~/bin

for script in $(ls ~/dotfiles/bin); do
    ln -sf ~/dotfiles/bin/$script ~/bin/$script
done

echo "Linking directories"
remove_and_link_dir thumbnails
remove_and_link_dir pip
remove_and_link_dir macromedia
remove_and_link_dir cpanm
remove_and_link_dir cpan
remove_and_link_dir codeintel
remove_and_link_dir bundler
remove_and_link_dir adobe

mkdir -p ~/.config/systemd/user
ln -sf ~/dotfiles/systemd/i3lock/i3lock.service ~/.config/systemd/user/
systemctl enable --user i3lock.service

ln -sf ~/dotfiles/systemd/i3daemon/i3daemon.service ~/.config/systemd/user
systemctl enable --user i3daemon.service

ln -sf ~/dotfiles/systemd/dalsik_daemon/dalsik_daemon.service ~/.config/systemd/user
systemctl enable --user dalsik_daemon.service

for timer_unit in clean_daily redshift_adjust restic_backup_local restic_work_backup_local ; do
    echo "Setting up systemd-timer $timer_unit"
    ln -sf ~/dotfiles/systemd/$timer_unit/$timer_unit.timer ~/.config/systemd/user/
    ln -sf ~/dotfiles/systemd/$timer_unit/$timer_unit.service ~/.config/systemd/user/
    systemctl --user daemon-reload
    systemctl enable --user $timer_unit.timer
    systemctl restart --user $timer_unit.timer
done

echo "DONE"
