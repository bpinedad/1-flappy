--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    -- Display Medal and message accrding to result
    scale = 0.4
    if (self.score >= 15) then
        -- Gold medal
        self.trophy = love.graphics.newImage('gold.png')
        love.graphics.draw(self.trophy, VIRTUAL_WIDTH / 2 - (130 * scale / 2) , 130, 0, scale, scale)
        love.graphics.printf('Great game!', 0, 200, VIRTUAL_WIDTH, 'center')
    elseif (self.score >= 10) then
        -- Silver medal
        self.trophy = love.graphics.newImage('silver.png')
        love.graphics.draw(self.trophy, VIRTUAL_WIDTH / 2 - (130 * scale / 2) , 130, 0, scale, scale)
        love.graphics.printf('You can do better!', 0, 200, VIRTUAL_WIDTH, 'center')
    elseif (self.score >= 5) then
        -- Bronze medal
        self.trophy = love.graphics.newImage('bronze.png')
        love.graphics.draw(self.trophy, VIRTUAL_WIDTH / 2 - (130 * scale / 2) , 130, 0, scale, scale)
        love.graphics.printf('Is that all you got?', 0, 200, VIRTUAL_WIDTH, 'center')
    else    
        -- No medal
        love.graphics.printf('Are you even trying?', 0, 200, VIRTUAL_WIDTH, 'center')
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 240, VIRTUAL_WIDTH, 'center')
end