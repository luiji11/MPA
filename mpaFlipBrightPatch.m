function   t = mpaFlipBrightPatch(w,brightPatch, Hz, angle, when)

    Screen('DrawTexture',   w, brightPatch, [], [], angle)
    [~, t] = Screen('Flip', w, when);
    
    [~, t] = Screen('Flip', w, t+1/Hz);    
    
            
end


