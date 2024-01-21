local lunarfrost = {}

---@class lunarfrost.types.Config
---@field transparent_background boolean
---@field theme 'nightfall'|'midnight'|'dawn'
---@field override_terminal boolean
---@field style lunarfrost.types.StyleConfig
---@field overrides lunarfrost.types.HLGroups

---@type lunarfrost.types.Config
lunarfrost.default_config = {
    transparent_background = false,
    theme = 'nightfall',
    override_terminal = true,
    style = {
        tabline = { reverse = true, color = 'lunar0' },
        search = { reverse = false, inc_reverse = true },
        types = { italic = true },
        keyword = { italic = true },
        comment = { italic = false },
    },
    overrides = {},
}

---@type lunarfrost.types.Config
_G.lunarfrost_config = vim.tbl_deep_extend("force", lunarfrost.default_config, _G.lunarfrost_config or {})

---@param config lunarfrost.types.Config|table
function lunarfrost.setup(config)
    _G.lunarfrost_config = vim.tbl_deep_extend("force", _G.lunarfrost_config, config or {})
end

---@param group string
---@param colors lunarfrost.types.ColorSpec
local function set_hi(group, colors)
    if not vim.tbl_isempty(colors) then
        ---@type vim.api.keyset.highlight
        local color = colors
        color.fg = colors[1] and colors[1][1] or 'NONE'
        color.bg = colors[2] and colors[2][1] or 'NONE'
        color.ctermfg = colors[1] and colors[1][2] or 'NONE'
        color.ctermbg = colors[2] and colors[2][2] or 'NONE'
        color[1] = nil
        color[2] = nil
        vim.api.nvim_set_hl(0, group, color)
    end
end

---@param hlgroups lunarfrost.types.HLGroups
local function set_highlights(hlgroups)
    vim.cmd("highlight Normal guifg=" .. hlgroups.Normal[1][1] .. " guibg=" .. hlgroups.Normal[2][1].. " ctermfg=" .. hlgroups.Normal[1][2] .. " ctermbg=" .. hlgroups.Normal[2][2])
    hlgroups.Normal = nil
    for group, colors in pairs(hlgroups) do
        set_hi(group, colors)
    end
end

function lunarfrost.load(_)
    if vim.g.colors_name then
        vim.cmd('hi clear')
    end

    vim.g.colors_name = 'lunarfrost'
    vim.o.termguicolors = true

    -- if vim.o.background == 'light' then
    --     _G.lunarfrost_config.theme = 'light'
    -- elseif vim.o.background == 'dark' then
    --     _G.lunarfrost_config.theme = 'default'
    -- end

    local theme = require 'lunarfrost.colors'.setup()
    local hlgroups = require 'lunarfrost.hl.init'.setup(theme, _G.lunarfrost_config)

    set_highlights(hlgroups)
end

function lunarfrost.colors()
    return require 'lunarfrost.colors'.colors()
end

return lunarfrost
