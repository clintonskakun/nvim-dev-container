echo "Downloading latest Neo Vim config updates"

rm -rf /root/.config/nvim
git clone https://github.com/clintonskakun/clinton.nvim.git /root/.config/nvim && rm -rf /root/.config/nvim/.git
