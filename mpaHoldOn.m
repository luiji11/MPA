function mpaHoldOn(R, startTime, endTime)


while (GetSecs - trialStart <  1)
        go          = mpaWait(R.sampHz, go);
        R.k         = R.k + 1;
        R.sgLick    = mpaStoreEvents(R.sgLick, R.k, mpaReadPorts(S)); % Check For licks
                      mpaPlotRealTime(R.sgLick,R.k, F)
end