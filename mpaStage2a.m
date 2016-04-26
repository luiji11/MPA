%% BMA Experimental Stage 2a
% 4.22.16
%   Some Notes here
%%

                mpaModPulseWidth(S,R.pulseWidth)
sessStart   =   GetSecs;
go          =   sessStart;
F.sessStart =   sessStart;

tic;
R.k  = 1;
while (GetSecs - sessStart <  T.preKDuration + T.sessDur)
    mpaPlotRealTime(R, F)    
    [go, R.k]               = mpaWait(R.sampHz, go, R.k);
    [R.sgLick, isLicking]   = mpaStoreEvents(R.sgLick, R.k, mpaReadPorts(S));

if  (toc >= 1/R.mxRewardHz) && isLicking &&...
    (GetSecs - sessStart > T.preKDuration)

    p               =   mpaLastEvent(R.sgLick,2);
                        mpaTrigStim(S, 'fbg');
                        mpaFeedPorts(S,p);
    T.trialAnswers  =   mpaStoreEvents(T.trialAnswers, R.k, p);                
    tic;

end
    
    


end



