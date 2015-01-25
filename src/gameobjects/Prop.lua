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

local Prop = Class({

  type = GameObject.newType("Prop"),

  init = function(self, x, y, prop)
  	GameObject.init(self, x, y)

  	if type(prop) == "string" then
  		local name = prop
  		prop = props[name]
  		if not prop then
  			error("No prop called '" .. name .. "'")
  		end
  	end
 
		self.body = love.physics.newBody(game.world, x, y, "dynamic")
		self.body:setUserData({ prop = self })
		local shape = nil
		if prop.radius then
			shape = love.physics.newCircleShape(prop.radius)
		elseif prop.height and prop.width then
			shape = love.physics.newRectangleShape(prop.width, prop.height)
		else
			error("Prop doesn't have a width, height or radius")
		end
	  local fixture = love.physics.newFixture(self.body, shape, (prop.density or 1))
	  --fixture:setCategory(COLLIDE_DUDES)
	  --fixture:setMask(COLLIDE_CLOTHES)
	  fixture:setFriction(1000000*(prop.friction or 1))

	  self.texture = foregroundb:getPiece(prop.textureName)

	  self.prototype = prop
	end
})

Prop:include(GameObject)


--[[------------------------------------------------------------
Destruction
--]]--

function Prop.onPurge(self)
	log:write("purging prop")
	self.body:destroy()
	self.body = nil	
end

--[[------------------------------------------------------------
Game loop
--]]--

function Prop:update(dt)
	self.x, self.y = self.body:getPosition()
  if self.y > 4*WORLD_H then
  	self.purge = true
  elseif self.x > 2*WORLD_W then
  	self.purge = true
  end
end

function Prop:draw(x, y)
	local angle = self.body:getAngle()
	foregroundb:addb_centered(self.texture, x, y, angle)
end


--[[------------------------------------------------------------
Export
--]]--

return Prop