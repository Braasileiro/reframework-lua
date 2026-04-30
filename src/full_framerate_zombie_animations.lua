-- full_framerate_zombie_animations.lua
-- Animates low LOD zombies at full framerate
-- Original C++ source code from https://github.com/TheTedder/REFix

-- Author : Brasileiro
-- Date   : 2026-04-29
-- Games  : RE2, RE3

local game_name = reframework.get_game_name()

local motion_interval_controller_prefix = ""

if game_name == "re2" then
  motion_interval_controller_prefix = "app.ropeway"
elseif game_name == "re3" then
  motion_interval_controller_prefix = "offline"
else
  log.warn("[FullFramerateZombieAnimations] Invalid game. Hooks will not be applied.")

  return
end

local motion_interval_controller = sdk.find_type_definition(motion_interval_controller_prefix .. ".MotionIntervalController")

if not motion_interval_controller then
  log.error("[FullFramerateZombieAnimations] MotionIntervalController type definition not found.")

  return
end

local set_interval_level = motion_interval_controller:get_method("setIntervalLevel")

if not set_interval_level then
  log.error("[FullFramerateZombieAnimations] MotionIntervalController::setIntervalLevel method not found.")

  return
end

local function on_pre_set_interval_level(args)
  args[3] = sdk.to_ptr(0)

  return sdk.PreHookResult.CALL_ORIGINAL
end

local function on_post_set_interval_level(retval)
  return retval
end

sdk.hook(set_interval_level, on_pre_set_interval_level, on_post_set_interval_level)
