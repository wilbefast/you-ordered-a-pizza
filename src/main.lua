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
Camera = require("hump/camera")

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

WORLD_W = 1024	
WORLD_H = 768

WINDOW_W = 0
WINDOW_H = 0

VIEW_W = 0
VIEW_H = 0
VIEW_SCALE = 1

local __convert_mouse_position = function(x, y)
  x = (x - (WINDOW_W - VIEW_W)*0.5)/VIEW_SCALE
  y = (y - (WINDOW_H - VIEW_H)*0.5)/VIEW_SCALE
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

props = require("assets/lson/props")
clothes = require("assets/lson/clothes")
characters = require("assets/lson/characters")
endings = require("assets/lson/endings")
ending = endings[1]
characterNames = {}
for name, char in pairs(characters) do
	table.insert(characterNames, name)
end

Prop = require("gameobjects/Prop")
Cloth = require("gameobjects/Cloth")
Dude = require("gameobjects/Dude")
Door = require("gameobjects/Door")

-------------------------------------------------------------------------------
-- DEFINES
-------------------------------------------------------------------------------

--DEBUG = true

FONT_SMALL = nil
FONT_MEDIUM = nil
FONT_BIG = nil

COLLIDE_WALLS = 1
COLLIDE_DUDES = 2
COLLIDE_CLOTHES = 3

--MUTE = true

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

	-- view scaling
	WORLD_CANVAS = love.graphics.newCanvas(WORLD_W, WORLD_H)
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

	-- sprite atlas
  fudge.set({ monkey = true })
  foregroundb = fudge.new("assets/foreground", { npot = false })
  fudge.set( { current = foregroundb } )
  
  -- animations
	bgFinAnim = Animation(foregroundb:getPiece("bgFin"), 2048, 1536, 3)


  -- fonts
	FONT_SMALL = love.graphics.newFont("assets/ttf/Romulus_by_pix3m.ttf", 32)
	FONT_SMALL:setFilter("nearest", "nearest", 1)
	love.graphics.setFont(FONT_SMALL)
	FONT_MEDIUM = love.graphics.newFont("assets/ttf/Romulus_by_pix3m.ttf", 48)
	FONT_MEDIUM:setFilter("nearest", "nearest", 1)
	FONT_BIG = love.graphics.newFont("assets/ttf/Romulus_by_pix3m.ttf", 64)
	FONT_BIG:setFilter("nearest", "nearest", 1)

	-- audio
	audio.mute = MUTE
	-- music
	local music_menu = love.audio.newSource("assets/audio/Menu.ogg")
	local music_game = love.audio.newSource("assets/audio/Music01.ogg")
	music_menu:setVolume(0.3)
	music_game:setVolume(0.3)
	music_menu:setLooping(true)
	music_game:setLooping(true)
	music_menu:play()
	local playing_music_menu = true
	audio.swap_music = function()
		if playing_music_menu then
			music_game:play()
			music_game:seek(music_menu:tell())
			music_menu:pause()
			playing_music_menu = false
		else
			music_menu:play()
			music_menu:seek(music_game:tell())
			music_game:pause()
			playing_music_menu = true
		end
	end
	audio.set_main_music = function(on)
		local m = ((playing_music_menu and music_menu) or music_game)
		if on then
			m:play()
		else
			m:pause()
		end
	end

	-- sound
	audio:load_sound("CloseDoor", 1, 3)
	audio:load_sound("Cat", 1, 2)
	audio:load_sound("OpenDoor", 1, 3)
	audio:load_sound("DoorBell", 1, 5)
	audio:load_sound("Tissu", 1, 3)
	audio:load_sound("ValidMan", 1, 3)
	audio:load_sound("ValidWoman", 0.4, 3)
	audio:load_sound("Fenetre", 1, 3)

	-- preload character sounds
	for character_name, character in pairs(characters) do
		for character_field_name, character_field in pairs(character) do
			if character_field_name == "hello_sound" or character_field_name == "rejected_sound" then
				audio:load_sound(character_field, 1, 2)
			end
		end
	end

	-- preload endings sounds
	for i,endi in ipairs(endings) do
		audio:load_music(endi.sound, 1, 1)
	end


	-- mouse cursor
	love.mouse.setVisible(true)

	gamestate.registerEvents{ 'quit', 'keypressed', 'keyreleased' }
	gamestate.switch(title)
end

love.draw = function()

	useful.pushCanvas(WORLD_CANVAS)
		gamestate.draw()
	useful.popCanvas()

	love.graphics.push()
    love.graphics.translate(
      (WINDOW_W - VIEW_W)*0.5 + useful.signedRand(shake), 
      (WINDOW_H - VIEW_H)*0.5 + useful.signedRand(shake))
    love.graphics.scale(VIEW_SCALE, VIEW_SCALE)
    love.graphics.draw(WORLD_CANVAS)
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
	elseif key == "m" then
		audio.mute = (not audio.mute)
	end
end