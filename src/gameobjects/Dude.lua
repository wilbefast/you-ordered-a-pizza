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
local armWidth = 15
local armHeight = 90
local legWidth = 15
local legHeight = 90
local legspacing = 15
local memberTorsoDistance = 10

local COLLIDABLE_CATEGORY = 1
local UNCOLLIDABLE_CATEGORY = 2

local Dude = Class({

  type = GameObject.newType("Dude"),

  init = function(self, x, y)

    GameObject.init(self, x, y)

		local torsoX = x
		local torsoY = y

	  self.torso = {}
	  self.torso.body = love.physics.newBody(
	    game.world, torsoX, torsoY, "dynamic")
	  self.torso.shape = love.physics.newRectangleShape(0, 0, torsoWidth, torsoHeight)
	  self.torso.fixture = love.physics.newFixture(self.torso.body, self.torso.shape, 5)
	  self.torso.fixture:setCategory(COLLIDABLE_CATEGORY)
	  self.torso.fixture:setMask(UNCOLLIDABLE_CATEGORY)

	  self.head = {}
	  self.head.body = love.physics.newBody(
	    game.world, torsoX, torsoY - torsoHeight/2-headRadius, "dynamic") 
	  self.head.shape = love.physics.newCircleShape(headRadius)
	  self.head.fixture = love.physics.newFixture(self.head.body, self.head.shape, 1)
	  self.head.fixture:setCategory(COLLIDABLE_CATEGORY)
	  self.head.fixture:setMask(UNCOLLIDABLE_CATEGORY)

	  headTorsojoint = love.physics.newDistanceJoint( self.head.body, self.torso.body, torsoX, torsoY - torsoHeight/2-headRadius, torsoX, torsoY - torsoHeight/2, true )

	  self.rightArm = {}
	  self.rightArm.body = love.physics.newBody(
	    game.world, torsoX + (torsoWidth+armWidth)/2, torsoY - torsoHeight/2 + armHeight / 2, "dynamic")
	  self.rightArm.shape = love.physics.newRectangleShape(0, 0, armWidth, armHeight)
	  self.rightArm.fixture = love.physics.newFixture(self.rightArm.body, self.rightArm.shape, 1)
	  self.rightArm.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
	  self.rightArm.fixture:setMask(UNCOLLIDABLE_CATEGORY)

	  rightArmjoint = love.physics.newRevoluteJoint( self.rightArm.body, self.torso.body, torsoX + torsoWidth/2, torsoY - (torsoHeight-armWidth)/2, false )

	  self.leftArm = {}
	  self.leftArm.body = love.physics.newBody(
	    game.world, torsoX - (torsoWidth+armWidth)/2, torsoY - torsoHeight/2 + armHeight / 2, "dynamic")
	  self.leftArm.shape = love.physics.newRectangleShape(0, 0, armWidth, armHeight)
	  self.leftArm.fixture = love.physics.newFixture(self.leftArm.body, self.leftArm.shape, 1)
	  self.leftArm.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
	  self.leftArm.fixture:setMask(UNCOLLIDABLE_CATEGORY)

	  leftArmjoint = love.physics.newRevoluteJoint( self.leftArm.body, self.torso.body, torsoX - torsoWidth/2, torsoY - (torsoHeight-armWidth)/2, false )

	  self.rightLeg = {}
	  self.rightLeg.body = love.physics.newBody(
	    game.world, torsoX + legspacing, torsoY + torsoHeight/2 + legHeight / 2 + memberTorsoDistance, "dynamic")
	  self.rightLeg.shape = love.physics.newRectangleShape(0, 0, legWidth, legHeight)
	  self.rightLeg.fixture = love.physics.newFixture(self.rightLeg.body, self.rightLeg.shape, 1)
	  self.rightLeg.fixture:setCategory(COLLIDABLE_CATEGORY)
	  self.rightLeg.fixture:setMask(UNCOLLIDABLE_CATEGORY)

	  rightLegjoint = love.physics.newRevoluteJoint( self.rightLeg.body, self.torso.body, torsoX + legspacing, torsoY + torsoHeight/2 + memberTorsoDistance, true )

	  self.leftLeg = {}
	  self.leftLeg.body = love.physics.newBody(
	    game.world, torsoX - legspacing, torsoY + torsoHeight/2 + legHeight / 2 + memberTorsoDistance, "dynamic")
	  self.leftLeg.shape = love.physics.newRectangleShape(0, 0, legWidth, legHeight)
	  self.leftLeg.fixture = love.physics.newFixture(self.leftLeg.body, self.leftLeg.shape, 1)
	  self.leftLeg.fixture:setCategory(COLLIDABLE_CATEGORY)
	  self.leftLeg.fixture:setMask(UNCOLLIDABLE_CATEGORY)

	  leftLegjoint = love.physics.newRevoluteJoint( self.leftLeg.body, self.torso.body, torsoX - legspacing, torsoY + torsoHeight/2 + memberTorsoDistance, true )

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

	foregroundb:addb("icon", x, y, 0, 1, 1, 25, 25)


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