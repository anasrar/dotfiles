# dotfiles

My 2025 dotfiles.

# Details

## Screenshot

![Screenshot](https://github.com/anasrar/.dotfiles/assets/38805204/d2ed4651-9b87-48e4-b33b-0d0292056382)

## Details

- **GTK Theme**: [Kripton](https://www.pling.com/p/1365372/).
- **Cursor**: [McMojave cursors](https://www.pling.com/p/1355701/).
- **Icon**: [Grade-icon-theme](https://www.pling.com/p/1586828).
- **Fonts**:
  - [Inter](https://github.com/rsms/inter), select variable version for crisp render.
  - [JetBrains Mono](https://github.com/JetBrains/JetBrainsMono) with [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts) fallback.
  - [tabler-icons](https://github.com/tabler/tabler-icons), font icon.
- **Terminal**:
  - [Alacritty](https://github.com/alacritty/alacritty) with color scheme [Tokyo Night](https://github.com/folke/tokyonight.nvim/tree/main/extras/alacritty).
  - [Kitty](https://github.com/kovidgoyal/kitty) with color scheme [Tokyo Night](https://github.com/folke/tokyonight.nvim/blob/main/extras/kitty/tokyonight_night.conf).
- **Text Editor**: [Neovim](https://github.com/neovim/neovim).
- **Git Client**: [lazygit](https://github.com/jesseduffield/lazygit).
- **Browser**: [Firefox](https://www.mozilla.org/firefox/new/) with [Fireside](https://github.com/bjesus/fireside).
- **Music Visualizer**: [cava](https://github.com/karlstav/cava).
- **App Finder**: [rofi](https://github.com/davatorium/rofi).
- **Panel/Sidebar**: [eww](https://github.com/elkowar/eww).
- **System Tray**: [stalonetray](https://github.com/kolbusa/stalonetray).
- **Notification**: [wired-notify](https://github.com/Toqozz/wired-notify).
- **Compositor**: [picom](https://github.com/yshui/picom).
- **Neofetch Image**: [pixiv: Aoi Ogata](https://www.pixiv.net/en/artworks/90655690).
- **Wallpaper**: [https://wallhaven.cc/w/y8jgzk](https://wallhaven.cc/w/y8jgzk).

# Notice

Specific directory has `README.md`, read for more specific information like dependency or another requirement.

# Dependency

- `stow` to manage symlink

# How to use

- run `stow.sh <directory>` to create symlink specific directory
- run `unstow.sh <directory>` to remove symlink specific directory
- run `stow-all.sh` to create symlink all directory
- run `unstow-all.sh` to remove symlink all directory
