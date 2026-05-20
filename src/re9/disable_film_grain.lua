-- disable_film_grain.lua
-- Author : Brasileiro
-- Date   : 2026-05-20
-- Games  : RE9

if reframework:get_game_name() ~= "re9" then
  return
end

local rendering_manager = nil

local function get_rendering_manager()
  if not rendering_manager then
    rendering_manager = sdk.get_managed_singleton("app.RenderingManager")
  end
end

local function get_is_film_grain_custom_filter_enable()
  if not rendering_manager then return end

  return rendering_manager:call("get__IsFilmGrainCustomFilterEnable")
end

re.on_frame(function()
  get_rendering_manager()

  local current = get_is_film_grain_custom_filter_enable()

  if current then
    rendering_manager:call("set__IsFilmGrainCustomFilterEnable", false)
  end
end)

re.on_draw_ui(function()
  if not imgui.tree_node("Disable Film Grain") then
    return
  end

  local current = get_is_film_grain_custom_filter_enable()

  imgui.text("IsFilmGrainCustomFilterEnable: " .. tostring(current))

  imgui.tree_pop()
end)
