--- Item

local heatDefenseItem = table.deepcopy(data.raw["item"]["heat-pipe"]) 

heatDefenseItem.name = "heat-pipe-defense"
heatDefenseItem.icons = {
  {
    icon = heatDefenseItem.icon,
    tint = {r=0.8,g=0,b=0,a=0.3}
  },
}
heatDefenseItem.place_result = "heat-pipe-defense"

data:extend{heatDefenseItem}

--- Actual Entity

local heatDefense = table.deepcopy(data.raw["heat-pipe"]["heat-pipe"])
 
heatDefense.name = "heat-pipe-defense"
heatDefense.minable.result = "heat-pipe-defense"
heatDefense.heat_buffer.minimum_glow_temperature = -500.0
heatDefense.map_color = {r=1, g=0, b=0, a=1}

heatDefense.resistances = {
 {
   type = "explosion",
   decrease = 0,
   percent = 30
 },
 {
   type = "acid",
   decrease = 0,
   percent = 80
 },
 {
   type = "fire",
   decrease = 0,
   percent = 90
 }
}

 
data:extend{heatDefense}


--- Recipe

local recipe = table.deepcopy(data.raw["recipe"]["heat-pipe"])
recipe.enabled = true
recipe.name = "heat-pipe-defense"
recipe.ingredients = {{"heat-pipe",1},{"copper-plate",5}}
recipe.result = "heat-pipe-defense"

data:extend{recipe}

--- Sound

data:extend{
  {
    type = "sound",
    name = "heat-defense-burn",
    filename = "__heat-pipe-defense__/fire-1.ogg"
  }
}

