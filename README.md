Corona-Time-Machine
===================

A Corona SDK Lua module that will take care of adjusting FPS for you either manually or automatically (and eventually allowing for slow-mode and etc.).

To use:

GameScreen.lua: (somewhere in your game code)

local TimeMachine = require("TimeMachine")
TimeMachine.start()