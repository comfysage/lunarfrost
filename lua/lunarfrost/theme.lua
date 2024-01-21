---@class lunarfrost.types.StyleConfig
---@field tabline { reverse: boolean, color: lunarfrost.types.ColorField }
---@field search { reverse: boolean, inc_reverse: boolean }
---@field types { italic: boolean }
---@field keyword { italic: boolean }
---@field comment { italic: boolean }

---@class lunarfrost.types.Theme
---@field none lunarfrost.types.Color
---@field colors lunarfrost.types.Colors
---@field base { fg: lunarfrost.types.Color, bg: lunarfrost.types.Color }
---@field bg lunarfrost.types.Color
---@field fg lunarfrost.types.Color
---@field bg0 lunarfrost.types.Color
---@field bg1 lunarfrost.types.Color
---@field bg2 lunarfrost.types.Color
---@field bg3 lunarfrost.types.Color
---@field fg0 lunarfrost.types.Color
---@field fg1 lunarfrost.types.Color
---@field fg2 lunarfrost.types.Color
---@field lunar0 lunarfrost.types.Color
---@field lunar1 lunarfrost.types.Color
---@field lunar2 lunarfrost.types.Color
---@field red  lunarfrost.types.Color
---@field yellow lunarfrost.types.Color
---@field orange lunarfrost.types.Color
---@field green lunarfrost.types.Color
---@field aqua lunarfrost.types.Color
---@field blue lunarfrost.types.Color
---@field purple lunarfrost.types.Color
---@field syntax lunarfrost.types.Syntax
---@field diagnostic { ['ok'|'error'|'warn'|'info'|'hint']: lunarfrost.types.Color }
---@field diff { ['add'|'delete'|'change']: lunarfrost.types.Color }
---@field style lunarfrost.types.StyleConfig
---@field sign lunarfrost.types.Color
---@field comment lunarfrost.types.Color
---@field bg_accent lunarfrost.types.Color

---@class lunarfrost.types.Syntax
---@field keyword lunarfrost.types.Color
---@field object lunarfrost.types.Color
---@field field lunarfrost.types.Color
---@field type lunarfrost.types.Color
---@field context lunarfrost.types.Color
---@field constant lunarfrost.types.Color
---@field call lunarfrost.types.Color
---@field string lunarfrost.types.Color
---@field macro lunarfrost.types.Color
---@field annotation lunarfrost.types.Color

local M = {}

---@param colors lunarfrost.types.Colors
---@param config lunarfrost.types.Config
---@return lunarfrost.types.Theme
function M.setup(colors, config)
  local theme = {}

  theme.none = { 'NONE', 0 }
  theme.colors = colors

  theme.bg = theme.none
  local bg_c = {
    nightfall = colors.bg0_hard,
    midnight = colors.bg0,
    dawn = colors.bg0_soft,
  }
  if not config.transparent_background then
    theme.bg = bg_c[config.theme] or colors.bg0
  end
  theme.base = { fg = colors.bg0, bg = theme.bg }
  theme.fg = colors.fg0

  theme.bg0 = colors.bg0
  theme.bg1 = colors.bg1
  theme.bg2 = colors.bg2
  theme.bg3 = colors.bg3

  theme.fg0 = colors.fg0
  theme.fg1 = colors.fg1
  theme.fg2 = colors.fg2

  theme.lunar0 = colors.lunar0
  theme.lunar1 = colors.lunar1
  theme.lunar2 = colors.lunar2

  local sign_colors = { dawn = theme.bg3 }
  theme.sign = sign_colors[config.theme] or theme.none
  theme.comment = colors.bg4
  theme.bg_accent = theme.bg2

  theme.red = colors.red
  theme.orange = colors.orange
  theme.yellow = colors.yellow
  theme.green = colors.green
  theme.aqua = colors.lunar1
  theme.blue = colors.lunar2
  theme.purple = colors.purple

  theme.syntax = {
    keyword = theme.red,
    object = theme.fg1,
    field = theme.blue,
    type = theme.yellow,
    context = theme.bg3,
    constant = theme.purple,
    call = theme.lunar1,
    string = theme.green,
    macro = theme.orange,
    annotation = theme.orange,
  }
  theme.diagnostic = {
    ok = theme.green,
    error = theme.red,
    warn = theme.yellow,
    info = theme.aqua,
    hint = theme.blue,
  }
  theme.diff = {
    add = theme.green,
    delete = theme.red,
    change = theme.aqua,
  }

  theme.style = {
    search = { reverse = true },
  }
  theme.style = vim.tbl_deep_extend('force', theme.style, config.style)

  return theme
end

return M
