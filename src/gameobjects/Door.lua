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

local close, dingdong, opened

closed = {
  update = function(self, dt)
    self.t = self.t + dt
    if self.t > 1 then
      self.state = dingdong
      self.t = 0
      audio:play_sound("DoorBell")
    end
  end,
  onclick = function(self)
  end,
  draw = function(self, x, y)
    self.DEBUG_VIEW:draw(self)
  end
}
dingdong = {
  update = function(self, dt)
  end,
  onclick = function(self)
    audio:play_sound("OpenDoor")
    self.state = opened
    Dude(self.x, self.y - 64)
  end,
  draw = function(self, x, y)
    useful.bindBlack()
    self.DEBUG_VIEW:draw(self)
    useful.bindWhite()
  end
}
opened = {
  update = function(self, dt)
  end,
  onclick = function(self)
  end,
  draw = function(self, x, y)
    love.graphics.setColor(0, 0, 255)
    self.DEBUG_VIEW:draw(self)
    useful.bindWhite()
  end

}

local Door = Class({

  type = GameObject.newType("Door"),

  init = function(self, x)


    GameObject.init(self, x, WORLD_H - 0.5*height - 16, WORLD_W*0.2, height)

    self.state = closed
    self.t = 0
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
  self.state.update(self, dt)
end

function Door:draw(x, y)
  self.state.draw(self, x, y)
end

--[[------------------------------------------------------------
Open and shut
--]]--

function Door:onclick()
  self.state.onclick(self)
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