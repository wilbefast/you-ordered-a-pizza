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

local camera = Camera(0, 0, 1, 0)

local GAME_TIME = 180
local TIMER_TEXT_LENGTH = 0.6*WORLD_W
local TIMER_X = WORLD_W/2 - TIMER_TEXT_LENGTH/2
local TIMER_Y = 0.05*WORLD_H

local state = gamestate.new()

local lightImage = love.graphics.newImage( "assets/foreground/light.PNG" )

--[[------------------------------------------------------------
Workspace, local to this file
--]]--

--[[------------------------------------------------------------
Gamestate navigation
--]]--

function state:init()
end


function state:enter()
  audio.swap_music()

  self.timer = GAME_TIME
  camera:lookAt(WORLD_W/2, WORLD_H/2)

  -- create the world
  self.world = love.physics.newWorld(0, 500)
  self.world:setCallbacks(
    self.beginContact, 
    self.endContact, 
    self.preSolve, 
    self.postSolve)
  love.physics.setMeter(100) -- 100 pixels per meter

  -- floor
  local floor = {}
  floor.body = love.physics.newBody(
    self.world, 0, WORLD_H + 16)
  floor.shape = love.physics.newRectangleShape(WORLD_W*2, 64)
  floor.fixture = love.physics.newFixture(floor.body, floor.shape)
  floor.body:setUserData("floor")

  -- roof
  local roof = {}
  roof.body = love.physics.newBody(
    self.world, 0, -16)
  roof.shape = love.physics.newRectangleShape(WORLD_W*2, 64)
  roof.fixture = love.physics.newFixture(roof.body, roof.shape)
  roof.body:setUserData("roof")

  -- far left wall
  local leftWall = {}
  leftWall.body = love.physics.newBody(
    self.world, -WORLD_W, WORLD_H*0.5)
  leftWall.shape = love.physics.newRectangleShape(32, WORLD_H)
  leftWall.fixture = love.physics.newFixture(leftWall.body, leftWall.shape)
  leftWall.body:setUserData("leftWall")

  -- middle wall
  local middleWallTop = {}
  middleWallTop.body = love.physics.newBody(
    self.world, 0, 50/2)
  middleWallTop.shape = love.physics.newRectangleShape(32, 50)
  middleWallTop.fixture = love.physics.newFixture(middleWallTop.body, middleWallTop.shape)
  middleWallTop.body:setUserData("middleWallTop")

  local middleWallBottom = {}
  middleWallBottom.body = love.physics.newBody(
    self.world, 0, WORLD_H - 80/2)
  middleWallBottom.shape = love.physics.newRectangleShape(32, 80)
  middleWallBottom.fixture = love.physics.newFixture(middleWallBottom.body, middleWallBottom.shape)
  middleWallBottom.body:setUserData("middleWallBottom")

  -- right wall
  local rightWallTop = {}
  rightWallTop.body = love.physics.newBody(
    self.world, WORLD_W, 111/2)
  rightWallTop.shape = love.physics.newRectangleShape(32, 111)
  rightWallTop.fixture = love.physics.newFixture(rightWallTop.body, rightWallTop.shape)
  rightWallTop.body:setUserData("rightWallTop")
  
  local rightWallBottom = {}
  rightWallBottom.body = love.physics.newBody(
    self.world, WORLD_W, WORLD_H - 320/2)
  rightWallBottom.shape = love.physics.newRectangleShape(32, 320)
  rightWallBottom.fixture = love.physics.newFixture(rightWallBottom.body, rightWallBottom.shape)
  rightWallBottom.body:setUserData("rightWallBottom")

  -- create a door
  self.door = Door(WORLD_W*0.7)

  -- reset state variables
  self.epilogue = nil
end


function state:leave()
  audio.swap_music()
  
  if self.mouseJoint then
    self.mouseJoint:destroy()
  end
  self.mouseJoint = nil

	GameObject.purgeAll()
  self.world:destroy()


end

--[[------------------------------------------------------------
Love callbacks
--]]--

function state:keypressed(key, uni)
  if key == "escape" then
    gamestate.switch(title)

  elseif key == "return" then
    self.epilogue = 0
  end
end

function state:mousepressed(x, y)
  if x < 0 or x > WORLD_W or y < 0 or y > WORLD_H then
    return
  end

  -- drag around bodies
  local grabbed =  false
  self.world:queryBoundingBox(x, y, x, y, function(fixture) 
  	local userdata = fixture:getBody():getUserData() 
    local dude = userdata["dude"]
    if dude then
    	self.grabPart = userdata["part"]
    	-- un-puppet
	    if dude.puppeteer and dude.canBeGrabbed then
	      dude.puppeteer.joint:destroy()
	      dude.puppeteer.body:destroy()
	      dude.puppeteer = nil
	    end
	    -- un-cloth
	    dude:tearClothingOffPart(self.grabPart)
	    -- match
	    grabbed = true
	  end

    if self.mouseJoint then
      self.mouseJoint:destroy()
    end
    self.mouseJoint = love.physics.newMouseJoint(fixture:getBody(), x, y)
    self.mouseJoint:setDampingRatio(0.1)
    return false
  end)

  -- open doors
  if not grabbed then
	  GameObject.mapToType("Door", 
	    function(obj) obj:onclick() end, 
	    function(obj) return obj:isCollidingPoint(x, y) end)
 	end

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

  if self.epilogue then

    -- epilogue
    local new_ep = math.min(1, self.epilogue + dt)
    local del_ep = new_ep - self.epilogue
    self.epilogue = new_ep
    --self.world:translateOrigin(-WORLD_W*del_ep, 0)
    camera:move(-WORLD_W*del_ep, 0)

  else
    -- control physics
    if self.mouseJoint then
      self.mouseJoint:setTarget(love.mouse.getPosition())
    end
  end

  -- update logic
  GameObject.updateAll(dt)

  -- check if dudes have left the screen
  local onscreen = {}
  GameObject.mapToType("Dude", function(dude)
    onscreen[dude] = false
  end)
  self.world:queryBoundingBox(0, 0, WORLD_W, WORLD_H, function(fixture)
    local userdata = fixture:getBody():getUserData()
    if userdata then
      if userdata.dude then
        onscreen[userdata.dude] = true
      end
    end
    return true
  end)
  local count = 0
  for dude, isonscreen in pairs(onscreen) do
    -- TODO - do stuff do the dude when he/she goes off screen
    if isonscreen then
      count = count + 1
    else
    	if dude.x > 0 then
    		dude.purge = true
        audio:play_sound("DefenestrationMan")
        audio:play_sound("Cat")
        if self.mouseJoint then
        	self.mouseJoint = nil
        end
      else

    	end
    end
  end
  if count == 0 and not self.door:anyQueued() and self.door:isClosed() then
    self.door:enqueue(function(x, y) 
    	Dude(x, y, characters[useful.randIn(characterNames)])
    end)
  end

  -- update timer
  self.timer = self.timer - dt;
  if (self.timer < 0) then
    self.timer = 0

    if (not self.epilogue) then
	    self.epilogue = 0
	  end
  end


end


function state:draw()
	-- clear
	local mx, my = love.mouse.getPosition()


  -- background
  love.graphics.setColor(200, 50, 200)
  love.graphics.rectangle("fill", 0, 0, WORLD_W, WORLD_H)
  useful.bindWhite()

  camera:attach()

	-- objects
  foregroundb:addb("bg", 0, 0, 0, 1, 1)
	GameObject.drawAll(self.view)

  love.graphics.draw(foregroundb)
  love.graphics.draw(lightImage, 0, 0)


  --timer
  local timerInt = math.floor(self.timer)
  local minutes = math.floor(timerInt/60)
  local seconds = timerInt - minutes * 60
  love.graphics.setFont(FONT_MEDIUM)
  love.graphics.printf(tostring(minutes)..":"..seconds, 
    TIMER_X, TIMER_Y, TIMER_TEXT_LENGTH, "center")

  foregroundb.batch:clear()

  -- debug
  if DEBUG then
    debugWorldDraw(self.world, 0, 0, WORLD_W, WORLD_H)
    useful.bindWhite()
  end
  camera:detach()
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