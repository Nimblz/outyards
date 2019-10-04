local function calcTrajectoryTheta(start,goal,speed,pickHighAngle)
    local xzStart = start * Vector3.new(1,0,1)
    local xzGoal = goal * Vector3.new(1,0,1)
    local range = (xzGoal-xzStart).Magnitude
    local yDiff = goal.Y - start.Y
    local g = workspace.Gravity
    if range == 0 then return math.pi/2 end
    if g == 0 then
        return math.atan(yDiff/range) -- simply return angle to the goal
    end

    local insideSqrt = (speed*speed*speed*speed) - (g * (g*range*range + 2*yDiff*speed*speed))
    if insideSqrt < 0 then return nil end -- NaN will happen

    local sqrt = math.sqrt(insideSqrt)

    local angleOne = (speed*speed + sqrt)/(g*range)
    local angleTwo = (speed*speed - sqrt)/(g*range)

    angleOne = math.atan(angleOne)
    angleTwo = math.atan(angleTwo)

    if pickHighAngle then
        return math.max(angleOne,angleTwo)
    else
        return math.min(angleOne,angleTwo)
    end
end

local function directionToReachGoal(start,goal,speed,pickHighAngle)
    local theta = calcTrajectoryTheta(start,goal,speed,pickHighAngle)
    if not theta then return nil end
    local facingDirection = ((goal-start) * Vector3.new(1,0,1)).Unit -- direction on xz plane towards our goal
    local facingCFrame = CFrame.new(Vector3.new(), facingDirection) -- get a cframe at 0,0,0 pointing in our target direction
    local angledCFrame = facingCFrame * CFrame.fromAxisAngle(Vector3.new(1,0,0), theta) -- tilt up by theta

    return angledCFrame.LookVector
end

return {
    directionToReachGoal = directionToReachGoal
}