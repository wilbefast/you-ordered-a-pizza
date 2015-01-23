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

-------------------------------------------------------------------------------
-- LIBRARY INCLUDES
-------------------------------------------------------------------------------

-- 'fudge' is Kevin's sprite-packing library
fudge = require("fudge/src/fudge")

-- 'hump' is a useful helper library for LOVE
gamestate = require("hump/gamestate")
Class = require("hump/class")
Vector = require("hump/vector-light")

-- 'unrequited' is my game library for LOVE
useful = require("unrequited/useful")
audio = require("unrequited/audio")
log = require("unrequited/log")
GameObject = require("unrequited/GameObject")
Animation = require("unrequited/Animation")
AnimationView = require("unrequited/AnimationView")
Controller = require("unrequited/Controller")

-- debug function I found online
debugWorldDraw = require("debugWorldDraw")

-------------------------------------------------------------------------------
-- SCALING
-------------------------------------------------------------------------------

WORLD_W = 640	
WORLD_H = 480

WINDOW_W = 0
WINDOW_H = 0

VIEW_W = 0
VIEW_H = 0
VIEW_SCALE = 1

local __convert_mouse_position = function(x, y)
  x = (x - (WINDOW_W - VIEW_W*VIEW_SCALE)*0.5)/VIEW_SCALE
  y = (y - (WINDOW_H - VIEW_H*VIEW_SCALE)*0.5)/VIEW_SCALE
  return x, y
end

local __old_love_mouse_getPosition = love.mouse.getPosition

love.mouse.getPosition = function()
	local x, y = __old_love_mouse_getPosition()
  return __convert_mouse_position(x, y)
end

-------------------------------------------------------------------------------
-- GAME INCLUDES
-------------------------------------------------------------------------------

Dude = require("gameobjects/Dude")

-------------------------------------------------------------------------------
-- DEFINES
-------------------------------------------------------------------------------

DEBUG = false

FONT_SMALL = nil
FONT_MEDIUM = nil
FONT_BIG = nil

-------------------------------------------------------------------------------
-- SCREEN SHAKE !
-------------------------------------------------------------------------------

shake = 0

-------------------------------------------------------------------------------
-- GAME STATES
-------------------------------------------------------------------------------

game = require("gamestates/game")
title = require("gamestates/title")
gameover = require("gamestates/gameover")

-------------------------------------------------------------------------------
-- LOVE CALLBACKS
-------------------------------------------------------------------------------
love.load = function()

	WINDOW_W = love.graphics.getWidth()
	WINDOW_H = love.graphics.getHeight()

  VIEW_W = WORLD_W
  VIEW_H = WORLD_H
  VIEW_SCALE = 1

	while (VIEW_W < WINDOW_W) and (VIEW_H < WINDOW_H) do
		VIEW_SCALE = VIEW_SCALE + 0.0001
    VIEW_W = WORLD_W*VIEW_SCALE
    VIEW_H = WORLD_H*VIEW_SCALE
	end
	VIEW_SCALE = VIEW_SCALE - 0.0001

	love.graphics.setDefaultFilter("nearest", "nearest", 1)

  fudge.set({ monkey = true })
  --foregroundb = fudge.new("assets/foreground", { npot = false })

	FONT_SMALL = love.graphics.newFont("assets/ttf/Romulus_by_pix3m.ttf", 32)
	FONT_SMALL:setFilter("nearest", "nearest", 1)
	love.graphics.setFont(FONT_SMALL)

	FONT_MEDIUM = love.graphics.newFont("assets/ttf/Romulus_by_pix3m.ttf", 48)
	FONT_MEDIUM:setFilter("nearest", "nearest", 1)

	FONT_BIG = love.graphics.newFont("assets/ttf/Romulus_by_pix3m.ttf", 64)
	FONT_BIG:setFilter("nearest", "nearest", 1)

	love.mouse.setVisible(true)

	gamestate.registerEvents{ 'quit', 'keypressed', 'keyreleased' }
	gamestate.switch(title)
end

love.draw = function()

	love.graphics.push()
    love.graphics.translate(
      (WINDOW_W - VIEW_W)*0.5 + useful.signedRand(shake), 
      (WINDOW_H - VIEW_H)*0.5 + useful.signedRand(shake))
    love.graphics.scale(VIEW_SCALE, VIEW_SCALE)
    gamestate.draw()
		useful.recordGIF("x")
	love.graphics.pop()

	if DEBUG then
		log:draw(32, 32)
	end
end

love.update = function(dt)

	if love.keyboard.isDown("x") then
    dt = 1/30
 	end

  if shake > 0 then
    shake = math.max(0, shake - 10*dt*shake)
  end
  gamestate.update(dt)
end

love.mousepressed = function(x, y, button)
  x, y = __convert_mouse_position(x, y)
	gamestate.mousepressed(x, y, button)
end

love.mousereleased = function(x, y, button)
  x, y = __convert_mouse_position(x, y)
	gamestate.mousereleased(x, y, button)
end

love.keypressed = function(key)
	if key == "o" then
		DEBUG = (not DEBUG)
	end
end