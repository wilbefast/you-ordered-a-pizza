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
local dickWidth = 13
local dickHeight = 49
local memberDistance = 10

local COLLIDABLE_CATEGORY = 1
local UNCOLLIDABLE_CATEGORY = 2

local Dude = Class({

  type = GameObject.newType("Dude"),

  init = function(self, x, y)

    -- semantic object
    GameObject.init(self, x, y)

    -- rag doll
    self.torso = { dude = self }
    self.torso.body = love.physics.newBody(
      game.world, x, y, "dynamic")
    self.torso.body:setUserData(self.torso)

    self.torso.shape = love.physics.newRectangleShape(0, 0, torsoWidth, torsoHeight)
    self.torso.fixture = love.physics.newFixture(self.torso.body, self.torso.shape, 5)
    self.torso.fixture:setCategory(COLLIDABLE_CATEGORY)
    self.torso.fixture:setMask(UNCOLLIDABLE_CATEGORY)

    self.head = { dude = self, part = "head" }
    self.head.body = love.physics.newBody(
      game.world, x, y - torsoHeight/2-headRadius, "dynamic") 
    self.head.shape = love.physics.newCircleShape(headRadius)
    self.head.fixture = love.physics.newFixture(self.head.body, self.head.shape, 1)
    self.head.fixture:setCategory(COLLIDABLE_CATEGORY)
    self.head.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    headTorsojoint = love.physics.newDistanceJoint( self.head.body, self.torso.body, x, y - torsoHeight/2-headRadius, x, y - torsoHeight/2, true )
    self.head.body:setUserData(self.head)

    self.rightArm = { dude = self, part = "rightArm" }
    self.rightArm.body = love.physics.newBody(
      game.world, x + (torsoWidth+armWidth)/2, y - torsoHeight/2 + armHeight / 2, "dynamic")
    self.rightArm.shape = love.physics.newRectangleShape(0, 0, armWidth, armHeight)
    self.rightArm.fixture = love.physics.newFixture(self.rightArm.body, self.rightArm.shape, 1)
    self.rightArm.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
    self.rightArm.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    rightArmjoint = love.physics.newRevoluteJoint( self.rightArm.body, self.torso.body, x + torsoWidth/2, y - (torsoHeight-armWidth)/2, false )
    self.rightArm.body:setUserData(self.rightArm)

    self.rightForearm = { dude = self, part = "rightForearm" }
    self.rightForearm.body = love.physics.newBody(
      game.world, x + (torsoWidth+armWidth)/2, y - torsoHeight/2 + 3*armHeight / 2, "dynamic")
    self.rightForearm.shape = love.physics.newRectangleShape(0, 0, armWidth, armHeight)
    self.rightForearm.fixture = love.physics.newFixture(self.rightForearm.body, self.rightForearm.shape, 1)
    self.rightForearm.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
    self.rightForearm.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    rightForearmjoint = love.physics.newRevoluteJoint( self.rightForearm.body, self.rightArm.body, x + (torsoWidth+armWidth)/2, y - torsoHeight/2 + armHeight, false )
    self.rightForearm.body:setUserData(self.rightForearm)

    self.rightHand = { dude = self, part = "rightArm" }
    self.rightHand.body = love.physics.newBody(
      game.world, x + (torsoWidth+armWidth)/2, y - torsoHeight/2 + 2*armHeight + handHeight/2, "dynamic")
    self.rightHand.shape = love.physics.newRectangleShape(0, 0, handWidth, handHeight)
    self.rightHand.fixture = love.physics.newFixture(self.rightHand.body, self.rightHand.shape, 1)
    self.rightHand.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
    self.rightHand.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    rightHandjoint = love.physics.newRevoluteJoint( self.rightHand.body, self.rightForearm.body, x + (torsoWidth+armWidth)/2, y - torsoHeight/2 + 2*armHeight, false )
    self.rightHand.body:setUserData(self.rightHand)

    self.leftArm = { dude = self, part = "leftArm" }
    self.leftArm.body = love.physics.newBody(
      game.world, x - (torsoWidth+armWidth)/2, y - torsoHeight/2 + armHeight / 2, "dynamic")
    self.leftArm.shape = love.physics.newRectangleShape(0, 0, armWidth, armHeight)
    self.leftArm.fixture = love.physics.newFixture(self.leftArm.body, self.leftArm.shape, 1)
    self.leftArm.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
    self.leftArm.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    leftArmjoint = love.physics.newRevoluteJoint( self.leftArm.body, self.torso.body, x - torsoWidth/2, y - (torsoHeight-armWidth)/2, false )
    self.leftArm.body:setUserData(self.leftArm)

    self.leftForearm = { dude = self, part = "leftForearm" }
    self.leftForearm.body = love.physics.newBody(
      game.world, x - (torsoWidth+armWidth)/2, y - torsoHeight/2 + 3*armHeight / 2, "dynamic")
    self.leftForearm.shape = love.physics.newRectangleShape(0, 0, armWidth, armHeight)
    self.leftForearm.fixture = love.physics.newFixture(self.leftForearm.body, self.leftForearm.shape, 1)
    self.leftForearm.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
    self.leftForearm.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    leftForearmjoint = love.physics.newRevoluteJoint( self.leftForearm.body, self.leftArm.body, x - (torsoWidth+armWidth)/2, y - torsoHeight/2 + armHeight, false )
    self.leftForearm.body:setUserData(self.leftForearm)

    self.leftHand = { dude = self, part = "leftHand" }
    self.leftHand.body = love.physics.newBody(
      game.world, x - (torsoWidth+armWidth)/2, y - torsoHeight/2 + 2*armHeight + handHeight/2, "dynamic")
    self.leftHand.shape = love.physics.newRectangleShape(0, 0, handWidth, handHeight)
    self.leftHand.fixture = love.physics.newFixture(self.leftHand.body, self.leftHand.shape, 1)
    self.leftHand.fixture:setCategory(UNCOLLIDABLE_CATEGORY)
    self.leftHand.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    leftHandjoint = love.physics.newRevoluteJoint( self.leftHand.body, self.leftForearm.body, x - (torsoWidth+armWidth)/2, y - torsoHeight/2 + 2*armHeight, false )
    self.leftHand.body:setUserData(self.leftHand)

    self.rightLeg = { dude = self, part = "rightLeg" }
    self.rightLeg.body = love.physics.newBody(
      game.world, x + legspacing, y + torsoHeight/2 + legHeight / 2 + memberDistance, "dynamic")
    self.rightLeg.shape = love.physics.newRectangleShape(0, 0, legWidth, legHeight)
    self.rightLeg.fixture = love.physics.newFixture(self.rightLeg.body, self.rightLeg.shape, 1)
    self.rightLeg.fixture:setCategory(COLLIDABLE_CATEGORY)
    self.rightLeg.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    rightLegjoint = love.physics.newRevoluteJoint( self.rightLeg.body, self.torso.body, x + legspacing, y + torsoHeight/2 + memberDistance, true )
    self.rightLeg.body:setUserData(self.rightLeg)

    self.rightForeleg = { dude = self, part = "rightForeleg" }
    self.rightForeleg.body = love.physics.newBody(
      game.world, x + legspacing, y + torsoHeight/2 + 3*legHeight / 2 + 2*memberDistance, "dynamic")
    self.rightForeleg.shape = love.physics.newRectangleShape(0, 0, legWidth, legHeight)
    self.rightForeleg.fixture = love.physics.newFixture(self.rightForeleg.body, self.rightForeleg.shape, 1)
    self.rightForeleg.fixture:setCategory(COLLIDABLE_CATEGORY)
    self.rightForeleg.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    rightForelegjoint = love.physics.newRevoluteJoint( self.rightForeleg.body, self.rightLeg.body, x + legspacing, y + torsoHeight/2 + memberDistance + legHeight, true )
    self.rightForeleg.body:setUserData(self.rightForeleg)

    self.rightFoot = { dude = self, part = "rightFoot" }
    self.rightFoot.body = love.physics.newBody(
      game.world, x + legspacing + footXDecal, y + torsoHeight/2 + 2*legHeight + 3*memberDistance, "dynamic")
    self.rightFoot.shape = love.physics.newRectangleShape(0, 0, footWidth, footHeight)
    self.rightFoot.fixture = love.physics.newFixture(self.rightFoot.body, self.rightFoot.shape, 1)
    self.rightFoot.fixture:setCategory(COLLIDABLE_CATEGORY)
    self.rightFoot.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    rightFootjoint = love.physics.newRevoluteJoint( self.rightFoot.body, self.rightForeleg.body, x + legspacing + footXDecal, y + torsoHeight/2 + 2*(memberDistance + legHeight), true )
    self.rightFoot.body:setUserData(self.rightFoot)

    self.leftLeg = { dude = self, part = "leftLeg" }
    self.leftLeg.body = love.physics.newBody(
      game.world, x - legspacing, y + torsoHeight/2 + legHeight / 2 + memberDistance, "dynamic")
    self.leftLeg.shape = love.physics.newRectangleShape(0, 0, legWidth, legHeight)
    self.leftLeg.fixture = love.physics.newFixture(self.leftLeg.body, self.leftLeg.shape, 1)
    self.leftLeg.fixture:setCategory(COLLIDABLE_CATEGORY)
    self.leftLeg.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    leftLegjoint = love.physics.newRevoluteJoint( self.leftLeg.body, self.torso.body, x - legspacing, y + torsoHeight/2 + memberDistance, true )
    self.leftLeg.body:setUserData(self.leftLeg)

    self.leftForeleg = { dude = self, part = "leftForeleg" }
    self.leftForeleg.body = love.physics.newBody(
      game.world, x - legspacing, y + torsoHeight/2 + 3*legHeight / 2 + 2*memberDistance, "dynamic")
    self.leftForeleg.shape = love.physics.newRectangleShape(0, 0, legWidth, legHeight)
    self.leftForeleg.fixture = love.physics.newFixture(self.leftForeleg.body, self.leftForeleg.shape, 1)
    self.leftForeleg.fixture:setCategory(COLLIDABLE_CATEGORY)
    self.leftForeleg.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    leftForelegjoint = love.physics.newRevoluteJoint( self.leftForeleg.body, self.leftLeg.body, x - legspacing, y + torsoHeight/2 + memberDistance + legHeight, true )
    self.leftForeleg.body:setUserData(self.leftForeleg)

    self.leftFoot = { dude = self, part = "leftFoot" }
    self.leftFoot.body = love.physics.newBody(
      game.world, x - legspacing - footXDecal, y + torsoHeight/2 + 2*legHeight + 3*memberDistance, "dynamic")
    self.leftFoot.shape = love.physics.newRectangleShape(0, 0, footWidth, footHeight)
    self.leftFoot.fixture = love.physics.newFixture(self.leftFoot.body, self.leftFoot.shape, 1)
    self.leftFoot.fixture:setCategory(COLLIDABLE_CATEGORY)
    self.leftFoot.fixture:setMask(UNCOLLIDABLE_CATEGORY)
    leftFootjoint = love.physics.newRevoluteJoint( self.leftFoot.body, self.leftForeleg.body, x - legspacing - footXDecal, y + torsoHeight/2 + 2*(memberDistance + legHeight), true )
    self.leftFoot.body:setUserData(self.leftFoot)

    self.puppeteer = {}
    puppeteerX = x
    puppeteerY = y - torsoHeight/2 - 2*headRadius - 400
    self.puppeteer.body = love.physics.newBody(
      game.world, puppeteerX, puppeteerY, "kinematic")
    puppeteerJoint = love.physics.newDistanceJoint
    puppeteerJoint = love.physics.newDistanceJoint( self.head.body, self.puppeteer.body, x, y - torsoHeight/2-headRadius, puppeteerX, puppeteerY, false )

    self.puppeteer.speed = 1
    self.puppeteer.bounce = 150
    self.puppeteer.points = {
      {puppeteerX, puppeteerY},
      {puppeteerX-50, puppeteerY},
      {puppeteerX-100, puppeteerY},
      {puppeteerX-150, puppeteerY},
      {puppeteerX-200, puppeteerY},
      {puppeteerX-300, puppeteerY},
      {puppeteerX-350, puppeteerY},
    }
    self.puppeteer.currentPoint = 1
    self.puppeteer.currentT = 0


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

  if (self.puppeteer.currentPoint < #self.puppeteer.points) then
    self.puppeteer.currentT = self.puppeteer.currentT + dt * self.puppeteer.speed;
    if (self.puppeteer.currentT > 1) then
      self.puppeteer.currentT = 1
    end
    -- TODO : update pos

    xPuppeteer = self.puppeteer.points[self.puppeteer.currentPoint][1] + (self.puppeteer.points[self.puppeteer.currentPoint+1][1] - self.puppeteer.points[self.puppeteer.currentPoint][1]) * self.puppeteer.currentT
    yPuppeteer = self.puppeteer.points[self.puppeteer.currentPoint][2] + (self.puppeteer.points[self.puppeteer.currentPoint+1][2] - self.puppeteer.points[self.puppeteer.currentPoint][2]) * self.puppeteer.currentT - 4*self.puppeteer.bounce * (self.puppeteer.currentT - self.puppeteer.currentT*self.puppeteer.currentT)

    log:write("puppeteer", xPuppeteer, yPuppeteer)

    self.puppeteer.body:setPosition(xPuppeteer, yPuppeteer)

    if (self.puppeteer.currentT >= 1) then
      self.puppeteer.currentPoint = self.puppeteer.currentPoint + 1
      self.puppeteer.currentT = 0
    end
  end

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