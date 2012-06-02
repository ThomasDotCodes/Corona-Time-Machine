local M = {}
 
M.fps = 30
 
local mFloor= math.floor
local prevTime, frameCounter = 0, 0
local baseTimeStep, curTimeStep = M.fps, M.fps
local bTimeMachineOn = false
M.updateInterval = 1
 
physics.setTimeStep (0)
 
M.adjustFPS = function()
	if bTimeMachineOn then
		local curTime = system.getTimer()
		local dt = curTime - prevTime
		prevTime = curTime
		local fps = mFloor (1000/dt)
		local timeStep
		
		-- CHECK EVERY N FRAMES
		if (frameCounter == M.updateInterval) then 
			if (fps < baseTimeStep) then
				-- DROP IN FPS, SET NEW TIME STEP
				physics.setTimeStep (1/fps)
				curTimeStep = fps
				timeStep = fps
			else
				-- REVERT BACK TO BASE TIME STEP
				physics.setTimeStep (0)
				curTimeStep = baseTimeStep
				timeStep = baseTimeStep
			end
		 
			frameCounter = 0
			--print (timeStep)
		end
	
		frameCounter = frameCounter + 1
	end
end
 
M.start = function()
	prevTime, frameCounter = 0, 0
	physics.setTimeStep (0)
	bTimeMachineOn = true
	Runtime:addEventListener("enterFrame", M.adjustFPS)
end
 
M.stop = function()
	bTimeMachineOn = false
	Runtime:removeEventListener("enterFrame", M.adjustFPS)
end
 
return M