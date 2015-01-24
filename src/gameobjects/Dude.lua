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

local torsoWidth = 111
local torsoHeight = 148
local headRadius = 56
local armWidth = 11
local armHeight = 89
local handWidth = 59
local handHeight = 72
local legWidth = 16
local legHeight = 120
local footWidth = 42
local footHeight = 17
local footXDecal = 5
local legspacing = 15
local groinWidth = 81
local groinHeight = 53
local memberDistance = 10

local COLLIDABLE_CATEGORY = 1
local UNCOLLIDABLE_CATEGORY = 2

local Dude = Class({

  type = GameObject.newType("Dude"),

  init = function(self, x, y, character)

  	-- hello!
  	audio:play_sound("HelloMale")

    -- semantic object
    GameObject.init(self, x, y)

    self.friction = 1000000
    self.canBeGrabbed = false
    self.density = 100

    -- rag doll
    local parts = {}
    parts.torso = { dude = self, part = "torso" }
    parts.torso.body = love.physics.newBody(
      game.world, x, y, "dynamic")
    parts.torso.body:setUserData(parts.torso)
    parts.torso.shape = love.physics.newRectangleShape(0, 0, torsoWidth, torsoHeight)
    parts.torso.fixture = love.physics.newFixture(parts.torso.body, parts.torso.shape, self.density)
    parts.torso.fixture:setCategory(COLLIDABLE_CATEGORY)
    parts.torso.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    parts.torso.fixture:setFriction(self.friction)
    parts.torso.body:setUserData(parts.torso)

    parts.head = { dude = self, part = "head" }
    parts.head.body = love.physics.newBody(
      game.world, x, y - torsoHeight/2-headRadius, "dynamic") 
    parts.head.shape = love.physics.newCircleShape(headRadius)
    parts.head.fixture = love.physics.newFixture(parts.head.body, parts.head.shape, self.density)
    parts.head.fixture:setCategory(COLLIDABLE_CATEGORY)
    parts.head.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    parts.head.fixture:setFriction(self.friction)
    parts.head.joint = love.physics.newDistanceJoint( parts.head.body, parts.torso.body, x, y - torsoHeight/2- 0.1*headRadius, x, y - torsoHeight/2, true )
    parts.head.body:setUserData(parts.head)

    parts.groin = { dude = self, part = "groin" }
    parts.groin.body = love.physics.newBody(
      game.world, x , y + torsoHeight/2 + groinHeight / 2, "dynamic")
    parts.groin.shape = love.physics.newRectangleShape(0, 0, groinWidth, groinHeight)
    parts.groin.fixture = love.physics.newFixture(parts.groin.body, parts.groin.shape, self.density)
    parts.groin.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
    parts.groin.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    parts.groin.fixture:setFriction(self.friction)
    parts.groin.joint = love.physics.newWeldJoint( parts.groin.body, parts.torso.body, x, y + torsoHeight/2 + groinHeight / 2, false )
    parts.groin.body:setUserData(parts.groin)

    parts.rightArm = { dude = self, part = "rightArm" }
    parts.rightArm.body = love.physics.newBody(
      game.world, x + (torsoWidth+armWidth)/2, y - torsoHeight/2 + armHeight / 2, "dynamic")
    parts.rightArm.shape = love.physics.newRectangleShape(0, 0, armWidth, armHeight)
    parts.rightArm.fixture = love.physics.newFixture(parts.rightArm.body, parts.rightArm.shape, self.density)
    parts.rightArm.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
    parts.rightArm.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    parts.rightArm.fixture:setFriction(self.friction)
    parts.rightArm.joint = love.physics.newRevoluteJoint( parts.rightArm.body, parts.torso.body, x + torsoWidth/2, y - (torsoHeight-armWidth)/2, false )
    parts.rightArm.body:setUserData(parts.rightArm)

    parts.rightForearm = { dude = self, part = "rightForearm" }
    parts.rightForearm.body = love.physics.newBody(
      game.world, x + (torsoWidth+armWidth)/2, y - torsoHeight/2 + 3*armHeight / 2, "dynamic")
    parts.rightForearm.shape = love.physics.newRectangleShape(0, 0, armWidth, armHeight)
    parts.rightForearm.fixture = love.physics.newFixture(parts.rightForearm.body, parts.rightForearm.shape, self.density)
    parts.rightForearm.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
    parts.rightForearm.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    parts.rightForearm.fixture:setFriction(self.friction)
    parts.rightForearm.joint = love.physics.newRevoluteJoint( parts.rightForearm.body, parts.rightArm.body, x + (torsoWidth+armWidth)/2, y - torsoHeight/2 + armHeight, false )
    parts.rightForearm.body:setUserData(parts.rightForearm)

    parts.rightHand = { dude = self, part = "rightHand" }
    parts.rightHand.body = love.physics.newBody(
      game.world, x + (torsoWidth+armWidth)/2, y - torsoHeight/2 + 2*armHeight + handHeight/2, "dynamic")
    parts.rightHand.shape = love.physics.newRectangleShape(0, 0, handWidth, handHeight)
    parts.rightHand.fixture = love.physics.newFixture(parts.rightHand.body, parts.rightHand.shape, self.density)
    parts.rightHand.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
    parts.rightHand.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    parts.rightHand.fixture:setFriction(self.friction)
    parts.rightHand.joint = love.physics.newRevoluteJoint( parts.rightHand.body, parts.rightForearm.body, x + (torsoWidth+armWidth)/2, y - torsoHeight/2 + 2*armHeight, false )
    parts.rightHand.body:setUserData(parts.rightHand)

    parts.leftArm = { dude = self, part = "leftArm" }
    parts.leftArm.body = love.physics.newBody(
      game.world, x - (torsoWidth+armWidth)/2, y - torsoHeight/2 + armHeight / 2, "dynamic")
    parts.leftArm.shape = love.physics.newRectangleShape(0, 0, armWidth, armHeight)
    parts.leftArm.fixture = love.physics.newFixture(parts.leftArm.body, parts.leftArm.shape, self.density)
    parts.leftArm.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
    parts.leftArm.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    parts.leftArm.fixture:setFriction(self.friction)
    parts.leftArm.joint = love.physics.newRevoluteJoint( parts.leftArm.body, parts.torso.body, x - torsoWidth/2, y - (torsoHeight-armWidth)/2, false )
    parts.leftArm.body:setUserData(parts.leftArm)

    parts.leftForearm = { dude = self, part = "leftForearm" }
    parts.leftForearm.body = love.physics.newBody(
      game.world, x - (torsoWidth+armWidth)/2, y - torsoHeight/2 + 3*armHeight / 2, "dynamic")
    parts.leftForearm.shape = love.physics.newRectangleShape(0, 0, armWidth, armHeight)
    parts.leftForearm.fixture = love.physics.newFixture(parts.leftForearm.body, parts.leftForearm.shape, self.density)
    parts.leftForearm.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
    parts.leftForearm.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    parts.leftForearm.fixture:setFriction(self.friction)
    parts.leftForearm.joint = love.physics.newRevoluteJoint( parts.leftForearm.body, parts.leftArm.body, x - (torsoWidth+armWidth)/2, y - torsoHeight/2 + armHeight, false )
    parts.leftForearm.body:setUserData(parts.leftForearm)

    parts.leftHand = { dude = self, part = "leftHand" }
    parts.leftHand.body = love.physics.newBody(
      game.world, x - (torsoWidth+armWidth)/2, y - torsoHeight/2 + 2*armHeight + handHeight/2, "dynamic")
    parts.leftHand.shape = love.physics.newRectangleShape(0, 0, handWidth, handHeight)
    parts.leftHand.fixture = love.physics.newFixture(parts.leftHand.body, parts.leftHand.shape, self.density)
    parts.leftHand.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
    parts.leftHand.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    parts.leftHand.fixture:setFriction(self.friction)
    parts.leftHand.joint = love.physics.newRevoluteJoint( parts.leftHand.body, parts.leftForearm.body, x - (torsoWidth+armWidth)/2, y - torsoHeight/2 + 2*armHeight, false )
    parts.leftHand.body:setUserData(parts.leftHand)

    parts.rightLeg = { dude = self, part = "rightLeg" }
    parts.rightLeg.body = love.physics.newBody(
      game.world, x + legspacing, y + torsoHeight/2 + legHeight / 2 + memberDistance, "dynamic")
    parts.rightLeg.shape = love.physics.newRectangleShape(0, 0, legWidth, legHeight)
    parts.rightLeg.fixture = love.physics.newFixture(parts.rightLeg.body, parts.rightLeg.shape, self.density)
    parts.rightLeg.fixture:setCategory(COLLIDABLE_CATEGORY)
    parts.rightLeg.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    parts.rightLeg.fixture:setFriction(self.friction)
    parts.rightLeg.joint = love.physics.newRevoluteJoint( parts.rightLeg.body, parts.torso.body, x + legspacing, y + torsoHeight/2 + memberDistance, true )
    parts.rightLeg.body:setUserData(parts.rightLeg)

    parts.rightForeleg = { dude = self, part = "rightForeleg" }
    parts.rightForeleg.body = love.physics.newBody(
      game.world, x + legspacing, y + torsoHeight/2 + 3*legHeight / 2 + 2*memberDistance, "dynamic")
    parts.rightForeleg.shape = love.physics.newRectangleShape(0, 0, legWidth, legHeight)
    parts.rightForeleg.fixture = love.physics.newFixture(parts.rightForeleg.body, parts.rightForeleg.shape, self.density)
    parts.rightForeleg.fixture:setCategory(COLLIDABLE_CATEGORY)
    parts.rightForeleg.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    parts.rightForeleg.fixture:setFriction(self.friction)
    parts.rightForeleg.joint = love.physics.newRevoluteJoint( parts.rightForeleg.body, parts.rightLeg.body, x + legspacing, y + torsoHeight/2 + memberDistance + legHeight, true )
    parts.rightForeleg.body:setUserData(parts.rightForeleg)

    parts.rightFoot = { dude = self, part = "rightFoot" }
    parts.rightFoot.body = love.physics.newBody(
      game.world, x + legspacing + footXDecal, y + torsoHeight/2 + 2*legHeight + 3*memberDistance, "dynamic")
    parts.rightFoot.shape = love.physics.newRectangleShape(0, 0, footWidth, footHeight)
    parts.rightFoot.fixture = love.physics.newFixture(parts.rightFoot.body, parts.rightFoot.shape, self.density)
    parts.rightFoot.fixture:setCategory(COLLIDABLE_CATEGORY)
    parts.rightFoot.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    parts.rightFoot.fixture:setFriction(self.friction)
    parts.rightFoot.joint = love.physics.newRevoluteJoint( parts.rightFoot.body, parts.rightForeleg.body, x + legspacing + footXDecal, y + torsoHeight/2 + 2*(memberDistance + legHeight), true )
    parts.rightFoot.body:setUserData(parts.rightFoot)

    parts.leftLeg = { dude = self, part = "leftLeg" }
    parts.leftLeg.body = love.physics.newBody(
      game.world, x - legspacing, y + torsoHeight/2 + legHeight / 2 + memberDistance, "dynamic")
    parts.leftLeg.shape = love.physics.newRectangleShape(0, 0, legWidth, legHeight)
    parts.leftLeg.fixture = love.physics.newFixture(parts.leftLeg.body, parts.leftLeg.shape, self.density)
    parts.leftLeg.fixture:setCategory(COLLIDABLE_CATEGORY)
    parts.leftLeg.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    parts.leftLeg.fixture:setFriction(self.friction)
    parts.leftLeg.joint = love.physics.newRevoluteJoint( parts.leftLeg.body, parts.torso.body, x - legspacing, y + torsoHeight/2 + memberDistance, true )
    parts.leftLeg.body:setUserData(parts.leftLeg)

    parts.leftForeleg = { dude = self, part = "leftForeleg" }
    parts.leftForeleg.body = love.physics.newBody(
      game.world, x - legspacing, y + torsoHeight/2 + 3*legHeight / 2 + 2*memberDistance, "dynamic")
    parts.leftForeleg.shape = love.physics.newRectangleShape(0, 0, legWidth, legHeight)
    parts.leftForeleg.fixture = love.physics.newFixture(parts.leftForeleg.body, parts.leftForeleg.shape, self.density)
    parts.leftForeleg.fixture:setCategory(COLLIDABLE_CATEGORY)
    parts.leftForeleg.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    parts.leftForeleg.fixture:setFriction(self.friction)
    parts.leftForeleg.joint = love.physics.newRevoluteJoint( parts.leftForeleg.body, parts.leftLeg.body, x - legspacing, y + torsoHeight/2 + memberDistance + legHeight, true )
    parts.leftForeleg.body:setUserData(parts.leftForeleg)

    parts.leftFoot = { dude = self, part = "leftFoot" }
    parts.leftFoot.body = love.physics.newBody(
      game.world, x - legspacing - footXDecal, y + torsoHeight/2 + 2*legHeight + 3*memberDistance, "dynamic")
    parts.leftFoot.shape = love.physics.newRectangleShape(0, 0, footWidth, footHeight)
    parts.leftFoot.fixture = love.physics.newFixture(parts.leftFoot.body, parts.leftFoot.shape, self.density)
    parts.leftFoot.fixture:setCategory(COLLIDABLE_CATEGORY)
    parts.leftFoot.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    parts.leftFoot.fixture:setFriction(self.friction)
    parts.leftFoot.joint = love.physics.newRevoluteJoint( parts.leftFoot.body, parts.leftForeleg.body, x - legspacing - footXDecal, y + torsoHeight/2 + 2*(memberDistance + legHeight), true )
    parts.leftFoot.body:setUserData(parts.leftFoot)

    self.body_parts = parts

    self.puppeteer = {}
    puppeteerX = x
    puppeteerY = y - torsoHeight/2 - 2*headRadius - 400
    self.puppeteer.body = love.physics.newBody(
      game.world, puppeteerX, puppeteerY, "kinematic")
    self.puppeteer.joint = love.physics.newDistanceJoint( 
        parts.head.body, self.puppeteer.body, 
        x, y - torsoHeight/2-headRadius, 
        puppeteerX, puppeteerY, false )

    self.puppeteer.speed = 1
    self.puppeteer.bounce = 150
    self.puppeteer.points = {
      {puppeteerX, puppeteerY},
      {puppeteerX-50, puppeteerY},
      {puppeteerX-100, puppeteerY},
      {puppeteerX-150, puppeteerY},
      {puppeteerX-200, puppeteerY},
      {puppeteerX-300, puppeteerY},
      {puppeteerX-350, puppeteerY-50},
    }
    self.puppeteer.currentPoint = 1
    self.puppeteer.currentT = 0


    self.character = character

    self.clothes = {}
    for i, clothName in ipairs(self.character) do
    	if not clothes[clothName] then
    		error("No cloth called '" .. clothName .. "' defined in clothes.lua")
    	end
    	self.clothes[i] = clothes[clothName]
    end
    self:updateTextures()

		for partName, part in pairs(self.body_parts) do
			part.textures = {}
			for _, cloth in ipairs(self.clothes) do
				if #part.textures == 0 then
					local partTextureNames = cloth.body_parts[partName]

					if partTextureNames then 
						for __, textureName in ipairs(partTextureNames) do
							local t = foregroundb:getPiece(textureName)
							if not t then
								error("no sprite called '" .. textureName .. "' in foreground atlas")
							else
								table.insert(part.textures, t)
							end
						end
					end
				end
			end
		end
	end
})
Dude:include(GameObject)

--[[------------------------------------------------------------
Destruction
--]]--

function Dude.onPurge(self)

    for partName, part in pairs (self.body_parts) do
        if part.join ~= nil then
            part.join:destroy()
        end
        part.fixture:destroy()
        part.body:destroy()
    end

    self.body_parts = {}
end

--[[------------------------------------------------------------
Clothing
--]]--

function Dude:tearClothingOffPart(partName)
	for i = 1, #self.clothes - 1 do
		local cloth = self.clothes[i]

		if cloth.body_parts[partName] then
			table.remove(self.clothes, i)
			self:updateTextures()



			return true
		end
	end
	return false
end

function Dude:updateTextures()
	for partName, part in pairs(self.body_parts) do
		part.textures = {}
		for _, cloth in ipairs(self.clothes) do
			if #part.textures == 0 then
				local partTextureNames = cloth.body_parts[partName]

				if partTextureNames then 
					for __, textureName in ipairs(partTextureNames) do
						local t = foregroundb:getPiece(textureName)
						if not t then
							error("no sprite called '" .. textureName .. "' in foreground atlas")
						else
							table.insert(part.textures, t)
						end
					end
				end
			end
		end
	end
end


--[[------------------------------------------------------------
Game loop
--]]--

function Dude:update(dt)

	local p = self.body_parts
	self.x, self.y = p.torso.body:getX(), p.torso.body:getY()

  if (self.puppeteer ~= nil and self.puppeteer.currentPoint < #self.puppeteer.points) then
    self.puppeteer.currentT = self.puppeteer.currentT + dt * self.puppeteer.speed;
    if (self.puppeteer.currentT > 1) then
      self.puppeteer.currentT = 1
    end
    -- TODO : update pos

    xPuppeteer = self.puppeteer.points[self.puppeteer.currentPoint][1] + (self.puppeteer.points[self.puppeteer.currentPoint+1][1] - self.puppeteer.points[self.puppeteer.currentPoint][1]) * self.puppeteer.currentT
    yPuppeteer = self.puppeteer.points[self.puppeteer.currentPoint][2] + (self.puppeteer.points[self.puppeteer.currentPoint+1][2] - self.puppeteer.points[self.puppeteer.currentPoint][2]) * self.puppeteer.currentT - 4*self.puppeteer.bounce * (self.puppeteer.currentT - self.puppeteer.currentT*self.puppeteer.currentT)

    self.puppeteer.body:setPosition(xPuppeteer, yPuppeteer)

    if (self.puppeteer.currentT >= 1) then
      self.puppeteer.currentPoint = self.puppeteer.currentPoint + 1
      self.puppeteer.currentT = 0
    end
  else

  end
  self.canBeGrabbed = true

end

Dude.pickingPriority = {
	rightLeg = 0,
	leftLeg = 0,
	groin = 3,
	leftForeleg = 0,
	rightForeleg = 0,
	rightFoot = 2,
	leftFoot = 2,
	torso = 0,
	rightArm = 0,
	leftArm = 0,
	rightForearm = 0,
	leftForearm = 0,
	rightHand = 0,
	leftHand = 0,
	head = 1
}

local partDrawOrder = {
	"rightLeg",
	"leftLeg",
	"groin",
	"leftForeleg",
	"rightForeleg",
	"rightFoot",
	"leftFoot",
	"torso",
	"rightArm",
	"leftArm",
	"rightForearm",
	"leftForearm",
	"rightHand",
	"leftHand",
	"head",
}
function Dude:draw(x, y)
	for _, partName in ipairs(partDrawOrder) do
		local part = self.body_parts[partName]
		local b = part.body
		local px, py = b:getPosition()
		local pa = b:getAngle()
		for _, texture in ipairs(part.textures) do
			foregroundb:addb_centered(texture, px, py, pa)
		end
	end

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