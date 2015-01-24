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
  -- create the world
  self.world = love.physics.newWorld(0, 9.81)
  self.world:setCallbacks(
    self.beginContact, 
    self.endContact, 
    self.preSolve, 
    self.postSolve)
  love.physics.setMeter(100) -- 100 pixels per meter

  -- floor
  local floor = {}
  floor.body = love.physics.newBody(
    self.world, WORLD_W*0.5, WORLD_H + 16)
  floor.shape = love.physics.newRectangleShape(WORLD_W*1.5, 64)
  floor.fixture = love.physics.newFixture(floor.body, floor.shape)
  
  -- roof
  local roof = {}
  roof.body = love.physics.newBody(
    self.world, WORLD_W*0.5, -16)
  roof.shape = love.physics.newRectangleShape(WORLD_W*1.5, 64)
  roof.fixture = love.physics.newFixture(roof.body, roof.shape)

  -- left wall
  local leftWall = {}
  leftWall.body = love.physics.newBody(
    self.world, -16, WORLD_H*0.5)
  leftWall.shape = love.physics.newRectangleShape(64, WORLD_H)
  leftWall.fixture = love.physics.newFixture(leftWall.body, leftWall.shape)
 
  -- right wall
  local rightWall = {}
  rightWall.body = love.physics.newBody(
    self.world, WORLD_W + 16, WORLD_H*0.5)
  rightWall.shape = love.physics.newRectangleShape(64, WORLD_H)
  rightWall.fixture = love.physics.newFixture(rightWall.body, rightWall.shape)



  self.dude = Dude(WORLD_W/2, WORLD_H/2)
end


function state:leave()
	GameObject.purgeAll()
  self.world:destroy()
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


  self.world:queryBoundingBox(x, y, x, y, function(fixture) 

    if self.mouseJoint then
      self.mouseJoint:destroy()
    end
    self.mouseJoint = love.physics.newMouseJoint(fixture:getBody(), x, y)

    return true
  end)


end

function state:mousereleased()
  if self.mouseJoint then
    self.mouseJoint:destroy()
  end
  self.mouseJoint = nil
end

function state:update(dt)
  -- update physics
  self.world:update(dt)

  -- control physics
  if self.mouseJoint then
    self.mouseJoint:setTarget(love.mouse.getPosition())
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
  useful.bindWhite()

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