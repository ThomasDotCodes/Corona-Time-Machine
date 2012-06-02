local M = {}
 
M.fps = 30
 
local mFloor= math.floor
local prevTime, frameCounter = 0, 0
local baseTimeStep, curTimeStep = M.fps, M.fps
 
M.updateInterval = 1
 
physics.setTimeStep(1/baseTimeStep)
 
M.adjustFPS = function()
  local curTime = system.getTimer()
  local dt = curTime - prevTime
  prevTime = curTime
  local fps = mFloor(1000/dt)
 
  -- CHECK EVERY N FRAMES
  if frameCounter == M.updateInterval then
 
 
     if fps < baseTimeStep then
        -- DROP IN FPS, SET NEW TIME STEP
        physics.setTimeStep(1/fps)
        curTimeStep = fps
     else
        -- REVERT BACK TO BASE TIME STEP
        if curTimeStep < baseTimeStep then
             physics.setTimeStep(1/baseTimeStep)
             curTimeStep = baseTimeStep
        end
     end
 
    frameCounter = 0
    --print(fps)
  end
 
  frameCounter = frameCounter + 1
end
 
M.start = function()
  Runtime:addEventListener("enterFrame", M.adjustFPS)
end
 
M.stop = function()
  Runtime:removeEventListener("enterFrame", M.adjustFPS)
end
 
return M