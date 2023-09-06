function build(directory, config, parameters)
  config.effects = parameters.effects or config.effects --fix for IFD only checking config for status effects
  require("/items/buildscripts/buildfood.lua")
  config, parameters = build(directory, config, parameters)
  local foodTooltip = root.assetJson("/interface/tooltips/food.tooltip")
  local fields = config.tooltipFields or {}
  if foodTooltip.effectLabel then --check for IFD
    config.tooltipKind = "sb_food"
  end
  if not (not not foodTooltip.foodAmountLabel or not not foodTooltip.foodValueLabel) then --check for other food label mods
    fields.foodValueLabel = ""
    foodTooltip.foodAmountLabel = ""
  else
    local foodValue = parameters.foodValue or config.foodValue
    if foodValue then
      local untrailingValue = string.format("%.0f",foodValue,0)
      fields.foodValueLabel = "Food: "..untrailingValue
      fields.foodAmountLabel = "Food: "..untrailingValue
    end
  end

  parameters.tooltipFields = fields

  if not config.itemAgingScripts then
    fields.rotTimeLabel = ""
  elseif root.assetJson("/betabound.config:rotFood") == false then
    fields.rotTimeLabel = ""
    parameters.timeToRot = nil --root.assetJson("/items/rotting.config:baseTimeToRot")
  end

  return config, parameters
end