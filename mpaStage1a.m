%% MPA Experimental Stage 1a
% 4.21.16

                mpaModPulseWidth(S,R.pulseWidth)
ports2Feed  =   3; % feed both ports 
sessStart   =   GetSecs;
go          =   sessStart;
F.sessStart =   sessStart;
R.k = 0;
tic;


while (GetSecs - sessStart <  T.preKDuration + T.sessDur) 
    mpaPlotRealTime(R,F)
    [go, R.k]   = mpaWait(R.sampHz, go, R.k);    
    R.sgLick    = mpaStoreEvents(R.sgLick, R.k, mpaReadPorts(S));


if (toc >= 1/R.mxRewardHz) && (GetSecs - sessStart > T.preKDuration)
                        mpaTrigStim(S, 'fbg');
                        mpaFeedPorts(S,ports2Feed);                        
    T.trialAnswers =    mpaStoreEvents(T.trialAnswers, R.k, ports2Feed);                
                        tic;        

end


end


