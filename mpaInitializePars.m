function [T, K] = mpaInitializePars
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%%
% Stuff about Sampling 
K.sampHz        = 15;   % Sampling rate of animal's lick response
K.pulseWidth    = 15;   % default pulse width of water valve stimuluation
K.k             = 0;    % Start all sessions with the zeroth sample
K.mxRewardHz    = .2;   % Max Rate of water dispense 

T.sessDur       = 2 * 60;                % duration of session (in seconds)
T.preKDuration  = 2;                     % duration of pre Recording (sampling starts before session does) 

% Relevent Info
estNumSamples   = round(K.sampHz*(T.preKDuration+T.sessDur)/10);
I.lick          = zeros(estNumSamples, 2); 
I.trial         = zeros(round(size(I.lick,1)/5),4); % this needs to be adjusted in the future once i figure out average animal lick rate   
I.water         = zeros((T.sessDur*K.mxRewardHz),2);  % Frame (c1) and Port (c2) of water Reward       

CMD  = {'1a',   '',     '';...
        '2a',   '',     '';...
        '3a',   'old',  'ord';...
        '4',    '',     ''};        % left or right side, for triggering stimulus



