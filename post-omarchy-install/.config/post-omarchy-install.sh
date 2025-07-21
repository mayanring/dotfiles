#!/usr/bin/env fish

# omarchy post-install customizations

if not fc-list | grep -qi "JetBrainsMono Nerd Font"
  cd /tmp
  wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
  unzip JetBrainsMono.zip -d JetBrainsFont
  cp JetBrainsFont/*.ttf ~/.local/share/fonts
  rm -rf JetBrainsMono.zip JetBrainsFont
  fc-cache
  cd -
end

yay -S --noconfirm --needed \
  ghostty starship stow

yay -S --noconfirm --needed \
  zen-browser-bin

set apps_to_remove obsidian-bin signal-desktop spotify typora

for app in $apps_to_remove
  if pacman -Q $app >/dev/null 2>&1
    yay -Rns $app
  end
end

web2app-remove WhatsApp
web2app-remove HEY
web2app-remove Basecamp
web2app-remove "Google Photos"
web2app-remove "Google Messages"
web2app-remove "Google Contacts"
web2app-remove ChatGPT
web2app-remove GitHub
web2app-remove X
