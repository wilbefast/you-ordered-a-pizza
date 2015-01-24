--[[
(C) Copyright 2014 William Dyce

All rights reserved. This program and the accompanying materials
are made available under the terms of the GNU Lesser General Public License
(LGPL) version 2.1 which accompanies this distribution, and is available at
http://www.gnu.org/licenses/lgpl-2.1.html

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
Lesser General Public License for more details.
--]]

--[[------------------------------------------------------------
Initialisation
--]]--

local height = WORLD_H*0.7

local Door = Class({

  type = GameObject.newType("Door"),

  init = function(self, x)


    GameObject.init(self, x, WORLD_H - 0.5*height - 16, WORLD_W*0.2, height)

    self.dingdong = false
    self.dingdong_t = 0
  end,
})

Door:include(GameObject)


--[[------------------------------------------------------------
Destruction
--]]--

function Door.onPurge(self)
end

--[[------------------------------------------------------------
Game loop
--]]--

function Door:update(dt)
  if not self.dingdong then
    self.dingdong_t = self.dingdong_t + dt
    if self.dingdong_t > 1 then
      self.dingdong = true
      self.dingdong_t = 0
      audio:play_sound("DoorBell")
    end
  end
end

function Door:draw(x, y)
  if self.dingdong then
    self.DEBUG_VIEW:draw(self)
  end
end

--[[------------------------------------------------------------
Open and shut
--]]--

function Door:open()
  log:write("OPEN")
  if self.dingdong then
    self.dingdong = false
    Dude(self.x, self.y)
  end
end


--[[------------------------------------------------------------
Collisions
--]]--

function Door:eventCollision(other, dt)
end

--[[------------------------------------------------------------
Export
--]]--

return Door