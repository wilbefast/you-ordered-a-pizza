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
  self.testguy.head.fixture:setRestitution(0.9)

  headTorsojoint = love.physics.newDistanceJoint( self.testguy.head.body, self.testguy.torso.body, torsoX, torsoY - torsoHeight/2-headRadius, torsoX, torsoY - torsoHeight/2, true )

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