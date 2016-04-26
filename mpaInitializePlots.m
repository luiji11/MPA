function F = mpaInitializePlots(R,T,expStage)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
close(gcf)
clear F;
F.fg        = figure;

visWindow   = 10;               %plot responses occuring withing the last visWindow seconds 
F.visWindow = visWindow * R.sampHz; 

F.a1        = subplot(1,2,1);  
F.rawLicks  = plot(1:F.visWindow, nan(1,F.visWindow), 'c-'); hold on;
F.stimOn    = plot([nan nan], [-2 -2], 'o','color', [.3 .3 .2]);
F.rewardTime= plot(nan, nan, 'b*', 'markersize', 7);
F.rewardCount = text(1.1, .6, '0/0 Rewards taken', 'units', 'normalized');

F.time      = text(1.1, .9, '0', 'units', 'normalized');
              text(1.1, .8, sprintf('out of %.2f s',T.sessDur), 'units', 'normalized');

F.pulseWidth= text(-.3, .9, sprintf('pw %d', R.pulseWidth), 'units', 'normalized' ,'color', 'b');    


xlabel('k');  ylabel('Response');

xlim([-R.sampHz*2 F.visWindow+R.sampHz*2]); 
ylim([-3 3]); 
set(F.a1,'ytick', ([-1 0 1]),'yticklabel', {'Left', '~', 'Right'}, 'ygrid', 'on');

view(90,90);  

drawnow;
pause(.1)
        
        
end








