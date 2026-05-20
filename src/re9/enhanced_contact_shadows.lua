-- enhanced_contact_shadows.lua
-- Author : Brasileiro
-- Date   : 2026-05-20
-- Games  : RE9

if reframework:get_game_name() ~= "re9" then
  return
end

local render_config = nil

local function get_render_config()
  if not render_config then
    local td = sdk.find_type_definition("via.render.Renderer")

    if td then
      local md = td:get_method("get_RenderConfig")

      if md then
        local singleton = sdk.get_native_singleton("via.render.Renderer")

        if singleton then
          render_config = md:call(singleton)
        end
      end
    end
  end
end

local function get_contact_shadow_setting()
  if not render_config then return end

  return render_config:call("get_ContactShadowSetting")
end

re.on_frame(function()
  get_render_config()

  local current = get_contact_shadow_setting()

  if current and current ~= 1 then
    render_config:call("set_ContactShadowSetting", 1)
  end
end)

re.on_draw_ui(function()
  if not imgui.tree_node("Enhanced Contact Shadows") then
    return
  end

  local current = get_contact_shadow_setting()

  imgui.text("ContactShadowSetting: " .. tostring(current))

  imgui.tree_pop()
end)
