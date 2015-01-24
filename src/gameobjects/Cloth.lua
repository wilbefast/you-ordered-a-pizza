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

local clothSize = {
	rightLeg = 1,
	leftLeg = 1,
	groin = 1,
	leftForeleg = 1,
	rightForeleg = 1,
	rightFoot = 1,
	leftFoot = 1,
	torso = 4,
	rightArm = 1,
	leftArm = 1,
	rightForearm = 1,
	leftForearm = 1,
	rightHand = 1,
	leftHand = 1,
	head = 3
}

local Cloth = Class({

  type = GameObject.newType("Cloth"),

  init = function(self, x, y, cloth)

		local size = 0
		for partName, _ in pairs(cloth.body_parts) do
			size = size + clothSize[partName]
		end
		size = math.max(3, size)

    GameObject.init(self, x, y)

		local mx, my = love.mouse.getPosition()

		local bx, by = mx, my
		local body = love.physics.newBody(
		  game.world, bx, by, "dynamic")
		local shape = love.physics.newCircleShape(16)
		local fixture = love.physics.newFixture(body, shape, 0.5)
		fixture:setCategory(COLLIDE_CLOTHES)
		fixture:setMask(COLLIDE_DUDES, COLLIDE_WALLS)
		fixture:setFriction(2000000)


    self.bodies	 = { body }

		for i = 1, size - 1 do
			local angle = math.random()*math.pi*2
			local newBx =  x + math.cos(angle)*(math.random() + 1)*10*size
			local newBy = y + math.sin(angle)*(math.random() + 1)*10*size

			local newBody = love.physics.newBody(
		    game.world, newBx, newBy, "dynamic")
		  local newShape = love.physics.newCircleShape(16)
		  local newFixture = love.physics.newFixture(newBody, newShape, 0.5)
		  newFixture:setCategory(COLLIDE_CLOTHES)
		  newFixture:setMask(COLLIDE_DUDES, COLLIDE_WALLS)
		  newFixture:setFriction(2000000)	

		  local joint = love.physics.newRopeJoint(
				body, newBody, bx, by, newBx, newBy, 100, true)

		  body, bx, by = newBody, newBx, newBy


		  table.insert(self.bodies, newBody)
		end

		local joint = love.physics.newRopeJoint(
			body, self.bodies[1], bx, by, mx, my, 100, true)

		self.mesh = love.graphics.newMesh( #self.bodies )
  end,
})

Cloth:include(GameObject)


--[[------------------------------------------------------------
Destruction
--]]--

function Cloth.onPurge(self)
	log:write("purging cloth")
	for i, b in ipairs(self.bodies) do
		b:destroy()
	end
	self.bodies = nil	
end

--[[------------------------------------------------------------
Game loop
--]]--

function Cloth:update(dt)
	self.x, self.y = self.bodies[1]:getPosition()

  if self.y > 2*WORLD_H then
  	self.purge = true
  end
end

function Cloth:draw_cloth(x, y)

	local vertices = {}
	for i, b in ipairs(self.bodies) do
		local bx, by = b:getPosition()
		table.insert(vertices, bx)
		table.insert(vertices, by)
	end
	love.graphics.polygon("fill", vertices)

end


--[[------------------------------------------------------------
Export
--]]--

return Cloth