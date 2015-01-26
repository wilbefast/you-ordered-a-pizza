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

local Locker = Class({

  type = GameObject.newType("Locker"),

  init = function(self, x, y, width, height, prop)

    GameObject.init(self, x, y, width, height)

    self.closed = true

    self.prop = prop

    self.x = x
    self.y = y

  end,
})

Locker:include(GameObject)


--[[------------------------------------------------------------
Destruction
--]]--

function Locker.onPurge(self)
end

--[[------------------------------------------------------------
Game loop
--]]--

function Locker:update(dt)
end

function Locker:draw(x, y)
  if not self.closed then
    foregroundb:addb_centered("casier", x, y)
  end
end

--[[------------------------------------------------------------
Open and shut
--]]--

function Locker:onclick()
  if self.closed then
    self.closed = false
    Prop(self.x, self.y, self.prop)
    audio:play_sound("Locker")
  end
end

--[[------------------------------------------------------------
Collisions
--]]--

function Locker:eventCollision(other, dt)
end

--[[------------------------------------------------------------
Export
--]]--

return Locker