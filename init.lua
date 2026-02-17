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

-- Shell configuration
-- Set the shell based on the operating system
local my_sys_name = vim.loop.os_uname().sysname
if my_sys_name:find("Windows") then
    -- Use pwsh (PowerShell 7+) if available, otherwise fallback to powershell (5.x)
    if vim.fn.executable("pwsh") == 1 then
        vim.opt.shell = "pwsh"
    else
        vim.opt.shell = "powershell"
    end
    -- Additional flags might be needed for Windows shells
    vim.opt.shellcmdflag = "-NoLogo -ExecutionPolicy RemoteSigned -Command"
elseif my_sys_name == "Darwin" or my_sys_name == "Linux" then
    if vim.fn.executable("zsh") == 1 then
        vim.opt.shell = "zsh"
    else
        vim.opt.shell = "bash"
    end
end

-- Neovide configuration
if vim.g.neovide then
    -- Font and text settings
    vim.o.guifont = "CaskaydiaCove Nerd Font:h12"
    vim.g.neovide_text_gamma = 0.0
    vim.g.neovide_text_contrast = 0.5
    vim.opt.linespace = 0
    vim.g.neovide_scale_factor = 1.0

    -- Theme
    vim.g.neovide_theme = "bg_color"

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
