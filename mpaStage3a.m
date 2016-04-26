%% BMA Experimental Stage 3a
% 4.24.16
%   
%%
mpaTrigStim(S, 'x');
mpaModPulseWidth(S,R.pulseWidth)
R.k             = 0;
trialMode       = 0;
behCorrctTrial  = 0;
trialTimeEnd    = 0;
sessStart       = GetSecs;
go              = sessStart;
F.sessStart     = sessStart;

while (GetSecs - sessStart <  T.preKDuration + T.sessDur) 
    mpaPlotRealTime(R, F)
    [go, R.k]               = mpaWait(R.sampHz, go, R.k);                       % wait until allowed to sample    
    [R.sgLick, isLicking]   = mpaStoreEvents(R.sgLick, R.k, mpaReadPorts(S));   % Record lick Event

if  ~trialMode && isLicking  &&...                              % If not in trial mode, is in the act of licking, 
    (GetSecs - trialTimeEnd > 1) &&...                          % some time has surpassed since last trial ended
    (GetSecs - sessStart > T.preKDuration)                      % and passed presampling period...

    trialMode       = 1;                                        % We're in trial Mode boyyy    
    trialTimeStart  = GetSecs;
    trialOnFrame    = R.k;                                      % remember trial onset frame
    wrongCount      = 0;                                        % prepare to Count # Wrong Licks
    trAns           = mpaBehCorrectiveStimulus(T.trialAnswers, 3, 4);  % determine stim position
    
    mpaTrigStim(S, T.trialChoices{trAns});                      % Trigger Stimulus    
    fprintf('Go!!! (Trial %d)\n', find(T.trialAnswers == 0,1)-1);
    
end


if  trialMode && isLicking &&...       % If in trial mode, is in the act of licking,
    (GetSecs - trialTimeStart > 1);    % and 1 secs have surpassed since trial intiated 
    
    if  mpaLastEvent(R.sgLick,2) == trAns                           % if licked correctly
        mpaFeedPorts(S,trAns);                                      % Send water to correct port
        mpaTrigStim(S, 'x');                                        % Turn stim off;                               
        
        T.trialAnswers          = mpaStoreEvents(T.trialAnswers,trialOnFrame,...
                                                [R.k,trAns,wrongCount]);    
             
        trialMode       = 0;                                    % exit trial mode      
        trialTimeEnd    = GetSecs;
        fprintf('Correct!!!\n');

    elseif mpaLastEvent(R.sgLick,2) ~= trAns                    % if licked incorrectly
        wrongCount = wrongCount + 1;
        mpaFeedBack('instructive')                              
        fprintf('Wrong!!!\n')
    end
    

end

end


mpaTrigStim(S, 'x');
fprintf('Time''s UP!!')



