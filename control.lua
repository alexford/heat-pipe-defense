function distanceFrom(x1,y1,x2,y2) return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) end

script.on_event(defines.events.on_tick,
  function(event)
    --- TODO: use all surfaces
    local surface = game.surfaces["nauvis"]
    
    -- TODO: register defensePipes to global on creation/removal, this is not efficient
    local defensePipes = surface.find_entities_filtered{name= "heat-pipe-defense"}

    for _, pipe in ipairs(defensePipes) do
      --- These leak heat because they start to do damage from "radiant" heat
      if (event.tick % 60 == 0) then
        pipe.temperature = pipe.temperature - 0.125
      end
      
      if (pipe.temperature > 100.0) then      
        local collidingEnemies = surface.find_entities_filtered{position= pipe.position, radius=1.5, type= "unit"}
        for _, enemy in ipairs(collidingEnemies) do
          local distance = distanceFrom(pipe.position.x, pipe.position.y, enemy.position.x, enemy.position.y)
          local distanceFactor = math.max(distance, 0.5)
   
          local damage = 0.0005 * (pipe.temperature / distanceFactor)
            pipe.temperature = pipe.temperature - (0.4 / distanceFactor)
            
            if (event.tick % 10 == 0) then
              surface.create_trivial_smoke{name="soft-fire-smoke", position=enemy.position}
            end
            --surface.play_sound{path="heat-defense-burn", position=pipe.position}
            enemy.damage(damage, pipe.force, "fire", pipe)
        end
      end
    end
  end
)