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
local TEXT_LENGTH = 2*WORLD_W
local TIMER_X = WORLD_W/2 - TEXT_LENGTH/2
local TIMER_Y = 0.05*WORLD_H
local ENDTEXT_X = WORLD_W/2 - TEXT_LENGTH/2
local ENDTEXT_Y = 0.25*WORLD_H

local GRAB_HIT_POINTS_TEAR = 1/10000
local GRAB_HIT_POINTS_REFILL = 10

local state = gamestate.new()

local lightImage = love.graphics.newImage( "assets/foreground/light.PNG" )
local cursorDownImage = love.graphics.newImage( "assets/foreground/cursor_down.png" )
local cursorUpImage = love.graphics.newImage( "assets/foreground/cursor_up.png" )

local END_TRANSITION_DURATION = 2;
local END_TEXT_DURATION = 3;

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
	self.cursorImage = cursorUpImage

	love.mouse.setVisible(false)
  camera:lookAt(WORLD_W/2, WORLD_H/2)
  camera:zoomTo(1)

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
    self.world, WORLD_W/2, WORLD_H + 16)
  floor.shape = love.physics.newRectangleShape(WORLD_W, 64)
  floor.fixture = love.physics.newFixture(floor.body, floor.shape)
  floor.fixture:setCategory(COLLIDE_WALLS)
  floor.body:setUserData("floor")

  -- roof
  local roof = {}
  roof.body = love.physics.newBody(
    self.world, -WORLD_W/2, -16)
  roof.shape = love.physics.newRectangleShape(WORLD_W*3, 64)
  roof.fixture = love.physics.newFixture(roof.body, roof.shape)
  roof.fixture:setCategory(COLLIDE_WALLS)
  roof.body:setUserData("roof")

  -- far left wall
  local leftWall = {}
  leftWall.body = love.physics.newBody(
    self.world, -WORLD_W*2, WORLD_H*2)
  leftWall.shape = love.physics.newRectangleShape(64, WORLD_H*4)
  leftWall.fixture = love.physics.newFixture(leftWall.body, leftWall.shape)
  leftWall.fixture:setCategory(COLLIDE_WALLS)
  leftWall.body:setUserData("leftWall")


  -- far left bottom wall
  local leftBottomWall = {}
  leftBottomWall.body = love.physics.newBody(
    self.world, -WORLD_W, WORLD_H*4)
  leftBottomWall.shape = love.physics.newRectangleShape(WORLD_W*2, 64)
  leftBottomWall.fixture = love.physics.newFixture(leftBottomWall.body, leftBottomWall.shape)
  leftBottomWall.fixture:setCategory(COLLIDE_WALLS)
  leftBottomWall.body:setUserData("leftBottomWall")

  -- middle wall
  local middleWallTop = {}
  middleWallTop.body = love.physics.newBody(
    self.world, 0, (50 + 6*WORLD_H)/2)
  middleWallTop.shape = love.physics.newRectangleShape(32, (50 + 3*WORLD_H))
  middleWallTop.fixture = love.physics.newFixture(middleWallTop.body, middleWallTop.shape)
  middleWallTop.fixture:setCategory(COLLIDE_WALLS)
  middleWallTop.body:setUserData("middleWallTop")

  local middleWallBottom = {}
  middleWallBottom.body = love.physics.newBody(
    self.world, 0, WORLD_H - 80/2)
  middleWallBottom.shape = love.physics.newRectangleShape(32, 80)
  middleWallBottom.fixture = love.physics.newFixture(middleWallBottom.body, middleWallBottom.shape)
  middleWallBottom.fixture:setCategory(COLLIDE_WALLS)
  middleWallBottom.body:setUserData("middleWallBottom")

  -- right wall
  local rightWallTop = {}
  rightWallTop.body = love.physics.newBody(
    self.world, WORLD_W, 111/2)
  rightWallTop.shape = love.physics.newRectangleShape(32, 111)
  rightWallTop.fixture = love.physics.newFixture(rightWallTop.body, rightWallTop.shape)
  rightWallTop.fixture:setCategory(COLLIDE_WALLS)
  rightWallTop.body:setUserData("rightWallTop")
  
  local rightWallBottom = {}
  rightWallBottom.body = love.physics.newBody(
    self.world, WORLD_W, WORLD_H - 320/2)
  rightWallBottom.shape = love.physics.newRectangleShape(32, 320)
  rightWallBottom.fixture = love.physics.newFixture(rightWallBottom.body, rightWallBottom.shape)
  rightWallBottom.fixture:setCategory(COLLIDE_WALLS)
  rightWallBottom.body:setUserData("rightWallBottom")

  -- create a door
  self.door = Door(WORLD_W*0.7)

  -- reset state variables
  self.epilogue = nil
end


function state:leave()
  audio.swap_music()
	love.mouse.setVisible(true)
  
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

	self.cursorImage = cursorDownImage

  -- drag around bodies
  local grabbedBody, best = nil, -math.huge
  self.world:queryBoundingBox(x, y, x, y, function(fixture) 
  	local body = fixture:getBody()
  	local userdata = body:getUserData()
    if userdata and userdata.dude then
    	local val = Dude.pickingPriority[userdata.part]
    	if val > best then
    		grabbedBody = body
    		best = val
    	end
    end
    return true
  end)

  if grabbedBody then
  	local userdata = grabbedBody:getUserData()
  	local dude = userdata.dude
		self.grabDude = userdata.dude
		self.grabPart = userdata.part
		self.grabHitpoints = 1
		-- un-puppet
	  if dude.puppeteer and dude.canBeGrabbed then
	    dude.puppeteer.joint:destroy()
	    dude.puppeteer.body:destroy()
	    dude.puppeteer = nil
	  end
	  -- remove previous grab
		if self.mouseJoint then
		  self.mouseJoint:destroy()
		end
		self.mouseJoint = love.physics.newMouseJoint(grabbedBody, x, y)
		self.mouseJoint:setDampingRatio(0.1)

  else
  	-- open doors
	  GameObject.mapToType("Door", 
	    function(obj) obj:onclick() end, 
	    function(obj) return obj:isCollidingPoint(x, y) end)
 	end

end

function state:mousereleased()

	self.cursorImage = cursorUpImage
  if self.mouseJoint then
    self.mouseJoint:destroy()
  end
  self.mouseJoint = nil
end

function state:update(dt)
	local mx, my = love.mouse.getPosition()

  -- un-cloth
  if self.mouseJoint and self.grabDude then

  	local p = self.grabDude.body_parts[self.grabPart]
  	local dx, dy = p.body:getLinearVelocity()
  	local vx, vy = p.body:getPosition()
  	vx, vy = mx - vx, my - vy

		local d = Vector.det(dx, dy, vx, vy)
	  if d < 0 then

	  	self.grabHitpoints = math.max(0, self.grabHitpoints + d*dt*GRAB_HIT_POINTS_TEAR)
	  	if self.grabHitpoints == 0 then
	  		local cloth = self.grabDude:tearClothingOffPart(self.grabPart) 
	  		if cloth then
			  	self.mouseJoint:destroy()
			  	self.mouseJoint = love.physics.newMouseJoint(cloth.bodies[1], mx, my)
					self.mouseJoint:setDampingRatio(0.1) 
					self.grabPart = nil
					self.grabDude = nil
					self.grabHitpoints = 0
			  end
		  	
		  else
		  	self.grabHitpoints = math.min(1, self.grabHitpoints + GRAB_HIT_POINTS_REFILL*dt)
		  end
		end
	end

  -- update physics
  self.world:update(dt)

  if self.epilogue then
  	if self.epilogue < 1 then
    	-- epilogue
	    local new_ep = math.min(1, self.epilogue + dt)
	    local del_ep = new_ep - self.epilogue
	    self.epilogue = new_ep
	    camera:move(-3*WORLD_W/2*del_ep, 5*WORLD_H/2*del_ep)
	    camera:zoomTo(1-0.5*new_ep)
	  else
	    self.epilogue = self.epilogue + dt
  	end

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
    	if dude.x > WORLD_W/2 then
    		dude.purge = true
        audio:play_sound(dude.character.rejected_sound)
        audio:play_sound("Cat")
        if self.mouseJoint and (self.grabDude == dude) then
        	self.mouseJoint:destroy()
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

    if (not self.epilogue and count == 0) then
	    self.epilogue = 0
	  end
  end

  -- check end
  if self.epilogue and self.epilogue >= (1 + END_TRANSITION_DURATION + END_TEXT_DURATION) then
  	gamestate.switch(gameover)
  end

end


function state:draw()
	local mx, my = love.mouse.getPosition()

  -- background
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("fill", 0, 0, WORLD_W, WORLD_H)
  useful.bindWhite()

  camera:attach()

	-- objects
  foregroundb:addb("bg", 0, 0, 0, 1, 1)
  foregroundb:addb("bgFin", -2*WORLD_W, 2*WORLD_H, 0, 1, 1)
	GameObject.drawAll(self.view)

  love.graphics.draw(foregroundb)
  love.graphics.draw(lightImage, 0, 0)

  foregroundb.batch:clear()

  GameObject.mapToType("Cloth", function(obj) obj:draw_cloth() end)
 
  -- debug
  if DEBUG then
    debugWorldDraw(self.world, 0, 0, WORLD_W, WORLD_H)
    useful.bindWhite()
  end
  camera:detach()

  --ui
  if not self.epilogue then
  	if self.timer > 0 then
		  local timerInt = math.floor(self.timer)
		  local minutes = math.floor(timerInt/60)
		  local seconds = timerInt - minutes * 60
		  love.graphics.setFont(FONT_MEDIUM)
		  local format = string.format("%02d : %02d", minutes, seconds)
		  love.graphics.printf(format, 
		    TIMER_X, TIMER_Y, TEXT_LENGTH, "center")
		end
  		love.graphics.draw(self.cursorImage, mx, my)
	elseif self.epilogue > (1 + END_TRANSITION_DURATION) then
	  love.graphics.setFont(FONT_BIG)
	  love.graphics.printf("What do we do now ?", 
	    ENDTEXT_X, ENDTEXT_Y, TEXT_LENGTH, "center")
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