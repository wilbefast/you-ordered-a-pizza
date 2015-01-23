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

local state = gamestate.new()

--[[------------------------------------------------------------
Workspace, local to this file
--]]--

--[[------------------------------------------------------------
Gamestate navigation
--]]--

function state:init()
end


function state:enter()
  -- set up the world
  self.world = love.physics.newWorld(0, 9.81, true)
  self.world:setCallbacks(
    self.beginContact, 
    self.endContact, 
    self.preSolve, 
    self.postSolve)
  love.physics.setMeter(100) -- 100 pixels per meter


  -- populate the world
  self.floor = {}
  self.floor.body = love.physics.newBody(
    self.world, WORLD_W/2, WORLD_H - 32)
  self.floor.shape = love.physics.newRectangleShape(WORLD_W*1.5, 64)
  self.floor.fixture = love.physics.newFixture(self.floor.body, self.floor.shape)

  self.testguy = {}

  torsoX = WORLD_W/2
  torsoY = 70
  torsoWidth = 50
  torsoHeight = 100
  headRadius = 20
  armWidth = 15
  armHeight = 90
  legWidth = 15
  legHeight = 90
  legspacing = 15
  memberTorsoDistance = 10

  self.testguy.torso = {}
  self.testguy.torso.body = love.physics.newBody(
    self.world, torsoX, torsoY, "dynamic")
  self.testguy.torso.shape = love.physics.newRectangleShape(0, 0, torsoWidth, torsoHeight)
  self.testguy.torso.fixture = love.physics.newFixture(self.testguy.torso.body, self.testguy.torso.shape, 5)

  self.testguy.head = {}
  self.testguy.head.body = love.physics.newBody(
    self.world, torsoX, torsoY - torsoHeight/2-headRadius, "dynamic") 
  self.testguy.head.shape = love.physics.newCircleShape(headRadius)
  self.testguy.head.fixture = love.physics.newFixture(self.testguy.head.body, self.testguy.head.shape, 1)

  headTorsojoint = love.physics.newDistanceJoint( self.testguy.head.body, self.testguy.torso.body, torsoX, torsoY - torsoHeight/2-headRadius, torsoX, torsoY - torsoHeight/2, true )

  self.testguy.rightArm = {}
  self.testguy.rightArm.body = love.physics.newBody(
    self.world, torsoX + (torsoWidth+armWidth)/2, torsoY - torsoHeight/2 + armHeight / 2, "dynamic")
  self.testguy.rightArm.shape = love.physics.newRectangleShape(0, 0, armWidth, armHeight)
  self.testguy.rightArm.fixture = love.physics.newFixture(self.testguy.rightArm.body, self.testguy.rightArm.shape, 1)

  rightArmjoint = love.physics.newRevoluteJoint( self.testguy.rightArm.body, self.testguy.torso.body, torsoX + torsoWidth/2, torsoY - (torsoHeight-armWidth)/2, false )

  self.testguy.leftArm = {}
  self.testguy.leftArm.body = love.physics.newBody(
    self.world, torsoX - (torsoWidth+armWidth)/2, torsoY - torsoHeight/2 + armHeight / 2, "dynamic")
  self.testguy.leftArm.shape = love.physics.newRectangleShape(0, 0, armWidth, armHeight)
  self.testguy.leftArm.fixture = love.physics.newFixture(self.testguy.leftArm.body, self.testguy.leftArm.shape, 1)

  leftArmjoint = love.physics.newRevoluteJoint( self.testguy.leftArm.body, self.testguy.torso.body, torsoX - torsoWidth/2, torsoY - (torsoHeight-armWidth)/2, false )

  self.testguy.rightLeg = {}
  self.testguy.rightLeg.body = love.physics.newBody(
    self.world, torsoX + legspacing, torsoY + torsoHeight/2 + legHeight / 2 + memberTorsoDistance, "dynamic")
  self.testguy.rightLeg.shape = love.physics.newRectangleShape(0, 0, legWidth, legHeight)
  self.testguy.rightLeg.fixture = love.physics.newFixture(self.testguy.rightLeg.body, self.testguy.rightLeg.shape, 1)

  rightLegjoint = love.physics.newRevoluteJoint( self.testguy.rightLeg.body, self.testguy.torso.body, torsoX + legspacing, torsoY + torsoHeight/2 + memberTorsoDistance, true )

  self.testguy.leftLeg = {}
  self.testguy.leftLeg.body = love.physics.newBody(
    self.world, torsoX - legspacing, torsoY + torsoHeight/2 + legHeight / 2 + memberTorsoDistance, "dynamic")
  self.testguy.leftLeg.shape = love.physics.newRectangleShape(0, 0, legWidth, legHeight)
  self.testguy.leftLeg.fixture = love.physics.newFixture(self.testguy.leftLeg.body, self.testguy.leftLeg.shape, 1)

  leftLegjoint = love.physics.newRevoluteJoint( self.testguy.leftLeg.body, self.testguy.torso.body, torsoX - legspacing, torsoY + torsoHeight/2 + memberTorsoDistance, true )

end


function state:leave()
	GameObject.purgeAll()
end

--[[------------------------------------------------------------
Love callbacks
--]]--

function state:keypressed(key, uni)
  if key == "escape" then
    gamestate.switch(title)
  end
end

function state:mousepressed(x, y)

end

function state:mousereleased()
end

function state:update(dt)
  -- update phyics
  self.world:update(dt)

  -- control physics
  if love.keyboard.isDown("right") then
    self.testguy.head.body:applyForce(512*dt, 0)
  elseif love.keyboard.isDown("left") then
    self.testguy.head.body:applyForce(-512*dt, 0)
  end

  -- update logic
  GameObject.updateAll(dt)
end


function state:draw()
	-- clear
	local mx, my = love.mouse.getPosition()

  -- background
  love.graphics.setColor(200, 50, 200)
  love.graphics.rectangle("fill", 0, 0, WORLD_W, WORLD_H)

	-- objects
	GameObject.drawAll(self.view)

  -- debug
  if DEBUG then
    debugWorldDraw(self.world, 0, 0, WORLD_W, WORLD_H)
  end
end

--[[------------------------------------------------------------
Physics callbacks
--]]--

function state.beginContact()
end

function state.endContact()
end

function state.preSolve()
end

function state.postSolve()
end

--[[------------------------------------------------------------
EXPORT
--]]------------------------------------------------------------

return state