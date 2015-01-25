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

local t = nil

--[[------------------------------------------------------------
Gamestate navigation
--]]--

function state:init()
end

function state:enter()
	t = 0
	if audio.music then
		audio.music:pause()
	end
	audio.set_main_music(true)
end

function state:leave()
end

--[[------------------------------------------------------------
Callbacks
--]]--

function state:keypressed(key, uni)
  if key=="escape" then
    love.event.push("quit")
  end
end

function state:mousepressed(x, y, button)
  gamestate.switch(game)
end

function state:update(dt)
	t = t + dt
end

function state:draw()
	local offset = 8*math.sin(2*t)
	
  -- background
  love.graphics.setColor(255, 0, 0)
  love.graphics.rectangle("fill", 0, 0, WORLD_W, WORLD_H)

  useful.bindWhite()
	love.graphics.setFont(FONT_BIG)
	love.graphics.printf("SOMEBODY ORDER A PIZZA?", 
		WORLD_W*0.5 - WORLD_W*0.2, WORLD_H*0.15 + offset, WORLD_W*0.4, "center")
	love.graphics.setFont(FONT_MEDIUM)
	love.graphics.printf("A game with ragdolls", 
		WORLD_W*0.5 - WORLD_W*0.3, WORLD_H*0.6 + offset, WORLD_W*0.6, "center")

	love.graphics.setFont(FONT_SMALL)
end


--[[------------------------------------------------------------
EXPORT
--]]------------------------------------------------------------

return state