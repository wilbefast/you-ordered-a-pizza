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

local torsoX = WORLD_W/2
local torsoY = WORLD_H/2
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
local dickWidth = 13
local dickHeight = 49
local memberDistance = 10

local COLLIDABLE_CATEGORY = 1
local UNCOLLIDABLE_CATEGORY = 2

local Dude = Class({

  type = GameObject.newType("Dude"),

  init = function(self, x, y)

  GameObject.init(self, x, y)

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

  self.rightForearm = {}
  self.rightForearm.body = love.physics.newBody(
    game.world, torsoX + (torsoWidth+armWidth)/2, torsoY - torsoHeight/2 + 3*armHeight / 2, "dynamic")
  self.rightForearm.shape = love.physics.newRectangleShape(0, 0, armWidth, armHeight)
  self.rightForearm.fixture = love.physics.newFixture(self.rightForearm.body, self.rightForearm.shape, 1)
  self.rightForearm.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
  self.rightForearm.fixture:setMask(UNCOLLIDABLE_CATEGORY)
  rightForearmjoint = love.physics.newRevoluteJoint( self.rightForearm.body, self.rightArm.body, torsoX + (torsoWidth+armWidth)/2, torsoY - torsoHeight/2 + armHeight, false )

  self.rightHand = {}
  self.rightHand.body = love.physics.newBody(
    game.world, torsoX + (torsoWidth+armWidth)/2, torsoY - torsoHeight/2 + 2*armHeight + handHeight/2, "dynamic")
  self.rightHand.shape = love.physics.newRectangleShape(0, 0, handWidth, handHeight)
  self.rightHand.fixture = love.physics.newFixture(self.rightHand.body, self.rightHand.shape, 1)
  self.rightHand.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
  self.rightHand.fixture:setMask(UNCOLLIDABLE_CATEGORY)
  rightHandjoint = love.physics.newRevoluteJoint( self.rightHand.body, self.rightForearm.body, torsoX + (torsoWidth+armWidth)/2, torsoY - torsoHeight/2 + 2*armHeight, false )

  self.leftArm = {}
  self.leftArm.body = love.physics.newBody(
    game.world, torsoX - (torsoWidth+armWidth)/2, torsoY - torsoHeight/2 + armHeight / 2, "dynamic")
  self.leftArm.shape = love.physics.newRectangleShape(0, 0, armWidth, armHeight)
  self.leftArm.fixture = love.physics.newFixture(self.leftArm.body, self.leftArm.shape, 1)
  self.leftArm.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
  self.leftArm.fixture:setMask(UNCOLLIDABLE_CATEGORY)
  leftArmjoint = love.physics.newRevoluteJoint( self.leftArm.body, self.torso.body, torsoX - torsoWidth/2, torsoY - (torsoHeight-armWidth)/2, false )

  self.leftForearm = {}
  self.leftForearm.body = love.physics.newBody(
    game.world, torsoX - (torsoWidth+armWidth)/2, torsoY - torsoHeight/2 + 3*armHeight / 2, "dynamic")
  self.leftForearm.shape = love.physics.newRectangleShape(0, 0, armWidth, armHeight)
  self.leftForearm.fixture = love.physics.newFixture(self.leftForearm.body, self.leftForearm.shape, 1)
  self.leftForearm.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
  self.leftForearm.fixture:setMask(UNCOLLIDABLE_CATEGORY)
  leftForearmjoint = love.physics.newRevoluteJoint( self.leftForearm.body, self.leftArm.body, torsoX - (torsoWidth+armWidth)/2, torsoY - torsoHeight/2 + armHeight, false )

  self.leftHand = {}
  self.leftHand.body = love.physics.newBody(
    game.world, torsoX - (torsoWidth+armWidth)/2, torsoY - torsoHeight/2 + 2*armHeight + handHeight/2, "dynamic")
  self.leftHand.shape = love.physics.newRectangleShape(0, 0, handWidth, handHeight)
  self.leftHand.fixture = love.physics.newFixture(self.leftHand.body, self.leftHand.shape, 1)
  self.leftHand.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
  self.leftHand.fixture:setMask(UNCOLLIDABLE_CATEGORY)
  leftHandjoint = love.physics.newRevoluteJoint( self.leftHand.body, self.leftForearm.body, torsoX - (torsoWidth+armWidth)/2, torsoY - torsoHeight/2 + 2*armHeight, false )

  self.rightLeg = {}
  self.rightLeg.body = love.physics.newBody(
    game.world, torsoX + legspacing, torsoY + torsoHeight/2 + legHeight / 2 + memberDistance, "dynamic")
  self.rightLeg.shape = love.physics.newRectangleShape(0, 0, legWidth, legHeight)
  self.rightLeg.fixture = love.physics.newFixture(self.rightLeg.body, self.rightLeg.shape, 1)
  self.rightLeg.fixture:setCategory(COLLIDABLE_CATEGORY)
  self.rightLeg.fixture:setMask(UNCOLLIDABLE_CATEGORY)
  rightLegjoint = love.physics.newRevoluteJoint( self.rightLeg.body, self.torso.body, torsoX + legspacing, torsoY + torsoHeight/2 + memberDistance, true )

  self.rightForeleg = {}
  self.rightForeleg.body = love.physics.newBody(
    game.world, torsoX + legspacing, torsoY + torsoHeight/2 + 3*legHeight / 2 + 2*memberDistance, "dynamic")
  self.rightForeleg.shape = love.physics.newRectangleShape(0, 0, legWidth, legHeight)
  self.rightForeleg.fixture = love.physics.newFixture(self.rightForeleg.body, self.rightForeleg.shape, 1)
  self.rightForeleg.fixture:setCategory(COLLIDABLE_CATEGORY)
  self.rightForeleg.fixture:setMask(UNCOLLIDABLE_CATEGORY)
  rightForelegjoint = love.physics.newRevoluteJoint( self.rightForeleg.body, self.rightLeg.body, torsoX + legspacing, torsoY + torsoHeight/2 + memberDistance + legHeight, true )

  self.rightFoot = {}
  self.rightFoot.body = love.physics.newBody(
    game.world, torsoX + legspacing + footXDecal, torsoY + torsoHeight/2 + 2*legHeight + 3*memberDistance, "dynamic")
  self.rightFoot.shape = love.physics.newRectangleShape(0, 0, footWidth, footHeight)
  self.rightFoot.fixture = love.physics.newFixture(self.rightFoot.body, self.rightFoot.shape, 1)
  self.rightFoot.fixture:setCategory(COLLIDABLE_CATEGORY)
  self.rightFoot.fixture:setMask(UNCOLLIDABLE_CATEGORY)
  rightFootjoint = love.physics.newRevoluteJoint( self.rightFoot.body, self.rightForeleg.body, torsoX + legspacing + footXDecal, torsoY + torsoHeight/2 + 2*(memberDistance + legHeight), true )

  self.leftLeg = {}
  self.leftLeg.body = love.physics.newBody(
    game.world, torsoX - legspacing, torsoY + torsoHeight/2 + legHeight / 2 + memberDistance, "dynamic")
  self.leftLeg.shape = love.physics.newRectangleShape(0, 0, legWidth, legHeight)
  self.leftLeg.fixture = love.physics.newFixture(self.leftLeg.body, self.leftLeg.shape, 1)
  self.leftLeg.fixture:setCategory(COLLIDABLE_CATEGORY)
  self.leftLeg.fixture:setMask(UNCOLLIDABLE_CATEGORY)
  leftLegjoint = love.physics.newRevoluteJoint( self.leftLeg.body, self.torso.body, torsoX - legspacing, torsoY + torsoHeight/2 + memberDistance, true )

  self.leftForeleg = {}
  self.leftForeleg.body = love.physics.newBody(
    game.world, torsoX - legspacing, torsoY + torsoHeight/2 + 3*legHeight / 2 + 2*memberDistance, "dynamic")
  self.leftForeleg.shape = love.physics.newRectangleShape(0, 0, legWidth, legHeight)
  self.leftForeleg.fixture = love.physics.newFixture(self.leftForeleg.body, self.leftForeleg.shape, 1)
  self.leftForeleg.fixture:setCategory(COLLIDABLE_CATEGORY)
  self.leftForeleg.fixture:setMask(UNCOLLIDABLE_CATEGORY)
  leftForelegjoint = love.physics.newRevoluteJoint( self.leftForeleg.body, self.leftLeg.body, torsoX - legspacing, torsoY + torsoHeight/2 + memberDistance + legHeight, true )

  self.leftFoot = {}
  self.leftFoot.body = love.physics.newBody(
    game.world, torsoX - legspacing - footXDecal, torsoY + torsoHeight/2 + 2*legHeight + 3*memberDistance, "dynamic")
  self.leftFoot.shape = love.physics.newRectangleShape(0, 0, footWidth, footHeight)
  self.leftFoot.fixture = love.physics.newFixture(self.leftFoot.body, self.leftFoot.shape, 1)
  self.leftFoot.fixture:setCategory(COLLIDABLE_CATEGORY)
  self.leftFoot.fixture:setMask(UNCOLLIDABLE_CATEGORY)
  leftFootjoint = love.physics.newRevoluteJoint( self.leftFoot.body, self.leftForeleg.body, torsoX - legspacing - footXDecal, torsoY + torsoHeight/2 + 2*(memberDistance + legHeight), true )

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