% Test Vis Stim 
clc;
clear ;
Screen('CloseAll');
AssertOpenGL;
        Screen('Preference','SkipSyncTests',1);
% w     = Screen('OpenWindow',max (Screen('Screens')), [127 127 127]);

screen = 2;
% screen = max( Screen('Screens') );
% scrnPos = [0 0 1920 1080];
scrnPos = [20 40 1920/2 1080/2];
% scrnPos = [1920 0 1920/2 1080];



w        = Screen('OpenWindow',screen, [0 0 0], scrnPos);

%%
wOff     = Screen('OpenOffScreenWindow',screen, [0 0 0], scrnPos);

P     = mpaInitializePatches(w,wOff);
Screen('PreloadTextures', w, [P.G; P.B])

%%
commandwindow;
S.Vis       = fopen('mpaPtbComm.txt', 'a+' );
              fprintf('***\nPTB is Listening\n***\n')


sf      = 1; 

while 1

cmd     = fread(S.Vis,3,'char=>char')';
% fprintf('%s', cmd) 
switch cmd;
        
case {'fbg'}     %Flip Both Grating
    Screen('DrawTexture',   w, P.G(sf))
    Screen('Flip',          w);
    sf = sf+1; if sf > length(P.G); sf = 1; end
    
case {'old','ord'}        %Occilate L or R Disk 
    
    theta = strcmp(cmd, 'ord') * 180;
    
    while 1
        t= GetSecs;
        Screen('DrawTexture',   w, P.B, [], [], theta)
        Screen('Flip', w, t + 1/P.blinkHz); %pause(1/P.blinkHz);
        
        t= GetSecs;
        Screen('Flip', w, t + 1/P.blinkHz); %pause(1/P.blinkHz);
    
        if strcmp(fread(S.Vis,1,'char=>char')', 'x')
            break;
        end        
                
    end
    Screen('Flip', w)
    
case 'ext'
break;


end
           
% pause(.1)
    
end

%%
fclose(S.Vis);
sca;
exit;