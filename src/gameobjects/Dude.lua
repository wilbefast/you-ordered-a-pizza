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

local Dude = Class
{
  type = GameObject.newType("Dude"),

  init = function(self, x, y, dx, dy)

    GameObject.init(self, x, y, 8, 8)

    self.dx, self.dy = dx, dy
  end,
}
Dude:include(GameObject)


--[[------------------------------------------------------------
Destruction
--]]--

function Dude:onPurge()
end

--[[------------------------------------------------------------
Game loop
--]]--

function Dude:update(dt)
  GameObject.update(self, dt)
end

function Dude:draw(x, y)

  --if DEBUG then
    self.DEBUG_VIEW:draw(self)
  --end
end

--[[------------------------------------------------------------
Collisions
--]]--

function Dude:eventCollision(other, dt)
end

--[[------------------------------------------------------------
Export
--]]--

return Dude