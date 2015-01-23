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

local torsoWidth = 50
local torsoHeight = 100
local headRadius = 20

local Dude = Class({

  type = GameObject.newType("Dude"),

  init = function(self, x, y)

    GameObject.init(self, x, y)

	  self.torso = {}
	  self.torso.body = love.physics.newBody(
	    game.world, x, y, "dynamic")
	  self.torso.shape = love.physics.newRectangleShape(0, 0, torsoWidth, torsoHeight)
	  self.torso.fixture = love.physics.newFixture(self.torso.body, self.torso.shape, 5)

	  self.head = {}
	  self.head.body = love.physics.newBody(
	    game.world, x, y - torsoHeight/2 - headRadius, "dynamic") 
	  self.head.shape = love.physics.newCircleShape(headRadius)
	  self.head.fixture = love.physics.newFixture(self.head.body, self.head.shape, 1)
	  self.head.fixture:setRestitution(0.9)

	  local headTorsojoint = love.physics.newDistanceJoint(
	  	self.head.body, self.torso.body, 
	  	x, y - torsoHeight/2 - headRadius, 
	  	x, y - torsoHeight/2, true)

  end,
})

Dude:include(GameObject)


--[[------------------------------------------------------------
Destruction
--]]--

function Dude.onPurge(self)
end

--[[------------------------------------------------------------
Game loop
--]]--

function Dude:update(dt)
	self.x, self.y = self.torso.body:getX(), self.torso.body:getY()
end

function Dude:draw(x, y)

  love.graphics.circle("line", x, y, 32)
end

--[[------------------------------------------------------------
Physics
--]]--



--[[------------------------------------------------------------
Collisions
--]]--

function Dude:eventCollision(other, dt)
end

--[[------------------------------------------------------------
Export
--]]--

return Dude