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

  self.ball = {}
  self.ball.body = love.physics.newBody(
    self.world, WORLD_W/2, WORLD_H/2, "dynamic") 
  self.ball.shape = love.physics.newCircleShape(20)
  self.ball.fixture = love.physics.newFixture(self.ball.body, self.ball.shape, 1)
  self.ball.fixture:setRestitution(0.9)

  self.block = {}
  self.block.body = love.physics.newBody(
    self.world, WORLD_W/2, 0, "dynamic")
  self.block.shape = love.physics.newRectangleShape(0, 0, 50, 100)
  self.block.fixture = love.physics.newFixture(self.block.body, self.block.shape, 5)

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
    self.ball.body:applyForce(512*dt, 0)
  elseif love.keyboard.isDown("left") then
    self.ball.body:applyForce(-512*dt, 0)
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