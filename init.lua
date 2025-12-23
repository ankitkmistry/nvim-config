-- 'ma goofy ahh' neovim Config 
-- Author: Ankit Kumar Mistry
-- Date:   26-10-2025

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")

if vim.g.neovide then
    -- Font and text settings
	vim.o.guifont = "CaskaydiaCove Nerd Font:h12"
    vim.g.neovide_text_gamma = 0.0
    vim.g.neovide_text_contrast = 0.5
	vim.opt.linespace = 0
	vim.g.neovide_scale_factor = 1.0

    -- Theme
    vim.g.neovide_theme = 'bg_color'

    -- Animation settings
    vim.g.neovide_position_animation_length = 0.15
    vim.g.neovide_scroll_animation_length = 0.3
    vim.g.neovide_cursor_animation_length = 0.150
    vim.g.neovide_cursor_short_animation_length = 0.04
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_animate_in_insert_mode = true
    vim.g.neovide_cursor_smooth_blink = false

    -- Progress bar
    vim.g.neovide_progress_bar_enabled = true
    vim.g.neovide_progress_bar_height = 5.0
    vim.g.neovide_progress_bar_animation_speed = 200.0
    vim.g.neovide_progress_bar_hide_delay = 0.2

    -- Other
    vim.g.neovide_confirm_quit = true
    vim.g.neovide_refresh_rate = 60
end
