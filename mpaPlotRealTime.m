function mpaPlotRealTime(R, F)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

mn          = R.k - F.visWindow +1;

% Lick Tracker
    f           = R.sgLick ( R.sgLick(:,1) >= mn, : );
    f(:,1)      = f(:,1) - mn+1;    
    y           = zeros(F.visWindow,1);
    y(f(:,1))   = f(:,2);          
    
    y(y == 1) = -1;
    y(y == 2) = 1;
 set(F.rawLicks, 'ydata', y);

    
% % Stimulus Tracker
%     f           = R.sgVis ( R.sgVis(:,1) >= mn, : );
%     f(:,1)      = f(:,1) - mn+1;    
%     y = f(:,2);
%     y(y == 1) = -2;
%     y(y == 2) = 2;


% set(F.stimOn, 'xdata', f(:,1), 'ydata', y);

% Reward Tracker
    f           = R.sgH2O ( R.sgH2O(:,1) >= mn, : );
    f(:,1)      = f(:,1) - mn+1;    
    y = f(:,2);
    y(y == 1) = -2;
    y(y == 2) = 2;
    
    set(F.rewardTime, 'xdata', f(:,1), 'ydata', y);

% Reward count
set(F.rewardCount, 'string', sprintf('%d Rewards Given | ? uL)', sum(R.sgH2O(:,1)>0)))
    
% Time Tracker
set(F.time, 'string', sprintf('%.2f', GetSecs- F.sessStart))

drawnow;


%%


















