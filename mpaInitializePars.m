function [T, R] = mpaInitializePars(expStage)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%%
R.sampHz        = 15;                       % Sampling rate of animal's lick response
R.pulseWidth    = 15;                       % pulse width of water valve stimuluation


  %%  
if strcmp( expStage, '1a') || strcmp( expStage, '2a') || strcmp( expStage, '3a') 
    T.sessDur       = 2 * 60;                % duration of session (in seconds)
    T.preKDuration  = 2;                     % duration of pre Recording (sampling starts before session does) 
    
    estNumSamples   = round(R.sampHz*(T.preKDuration+T.sessDur)/10);
    R.sgLick        = zeros(estNumSamples, 2);            % Frame (c1) and Port (c2) of Lick

    R.mxRewardHz    = 1/2;                                % Rate of water release         
    R.sgH2O         = zeros((T.sessDur*R.mxRewardHz),2);  % Frame (c1) and Port (c2) of water Reward       
    T.trialAnswers  = zeros(round(size(R.sgLick,1)/5),4);    
   
end


if strcmp( expStage, '2a') || strcmp( expStage, '3a') 
    R.mxRewardHz    = .5;                                       % max Rate of water release         
    
    T.trialChoices  = {'old', 'ord'}; % left or right side, for triggering stimulus
end

