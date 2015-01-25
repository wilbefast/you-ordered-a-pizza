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

local height = WORLD_H*0.8

local DING_DONG_SPEED = 1

local close, dingdong, opened

closed = {
  update = function(self, dt)
    if #self.queue > 0 then
      self.t = self.t + dt
      if self.t > 1 then
        self.state = dingdong

			  self.dingdongTimer = 0;
        self.t = 0
        audio:play_sound("DoorBell")
      end
    end
  end,
  onclick = function(self)
  end,
  draw = function(self, x, y)
  	foregroundb:addb("doorClose", 0, -1)
  end
}
dingdong = {
  update = function(self, dt)
  	if self.dingdongTimer >= 0 then
		  self.dingdongTimer = self.dingdongTimer + dt* DING_DONG_SPEED;
		  if self.dingdongTimer >= 5 then
		  	self.dingdongTimer = 0
        audio:play_sound("DoorBell")
		  end
		end
  end,
  onclick = function(self)
    audio:play_sound("OpenDoor", 0.2)
    self.state = opened
    self.queue[1](self.x, self.y)
    table.remove(self.queue, 1)
  end,
  draw = function(self, x, y)
  	foregroundb:addb("doorClose", 0, -1)
  	if self.dingdongTimer >= 0 and self.dingdongTimer < 1 then
  		foregroundb:addb("dingdong", WORLD_W * 0.65, WORLD_H*0.1)
  	end
  end
}
opened = {
  update = function(self, dt)
    self.t = self.t + 0.5*dt
    if self.t > 1 then
      self.state = closed
      self.t = 0
      audio:play_sound("CloseDoor", 0.2)
    end
  end,
  onclick = function(self)
  end,
  draw = function(self, x, y)
  	foregroundb:addb("doorOpen", 0, -1)
	end

}

local Door = Class({

  type = GameObject.newType("Door"),

  init = function(self, x)

    GameObject.init(self, x, WORLD_H*0.77 - 0.5*height, WORLD_W*0.28, height)

    self.state = closed

		self.dingdongTimer = -1;
    self.t = 0
    self.queue = { }

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

function Door:enqueue(onOpenDoor)
  table.insert(self.queue, onOpenDoor)
end

function Door:anyQueued()
  return (#self.queue > 0)
end

function Door:isClosed()
  return (self.state == closed)
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