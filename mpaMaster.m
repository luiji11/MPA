%% MPA Captain Script Version 2

clear; close all; clc;

cd C:\users\Trach_McGee\Documents\Arduino\MPA_Logic  
% cd C:\Users\McgeeLab\Desktop\LuisOneDrive\CurrentWork\MPA\MPA_Logic
% cd C:\Users\Luis\OneDrive\CurrentWork\MPA\MPA_Logic\   

expStage    = '3a';
comPort     = 'COM4';


%% Establish Communication with Arduino and Open Visual Stimulus Platform
% (e.g. Psychophysics Tool Box)...
S   = mpaComm(comPort);
% !matlab -r "mpaInitializePtbPlatform" & 
%%
clear R T
[T, R]      = mpaInitializePars(expStage);
F           = mpaInitializePlots(R,T,expStage);     

switch expStage
    case '1a';
        mpaStage1a;
    case '2a';
        mpaStage2a;        
    case '3a'; 
        mpaStage3a;
    case 4;
        
end

%%
fclose(S.Vis);
fclose(S.Ard);
delete(S.Ard);
delete(S.Vis)
clear S 

%%
Screen('CloseAll')
close all

