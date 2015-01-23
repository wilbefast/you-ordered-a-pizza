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
end

function state:leave()
end

--[[------------------------------------------------------------
Callbacks
--]]--

function state:keypressed(key, uni)
  if key=="escape" then
    gamestate.switch(title)
  end
end

function state:mousepressed(x, y, button)
  gamestate.switch(title)
end

function state:update(dt)
	t = t + dt
end

function state:draw()

	local offset = 8*math.sin(2*t)

	love.graphics.setFont(FONT_MEDIUM)
	love.graphics.printf("Score", 
		(VIEW_W*0.5 - VIEW_W*0.1)/VIEW_SCALE, (VIEW_H*0.2 + offset)/VIEW_SCALE, VIEW_W*0.2/VIEW_SCALE, "center")

	love.graphics.setFont(FONT_BIG)
	love.graphics.printf("GAME OVER!", 
		(VIEW_W*0.5 - VIEW_W*0.2)/VIEW_SCALE, (VIEW_H*0.5 + offset)/VIEW_SCALE, VIEW_W*0.4/VIEW_SCALE, "center")

	love.graphics.setFont(FONT_SMALL)
end


--[[------------------------------------------------------------
EXPORT
--]]------------------------------------------------------------

return state