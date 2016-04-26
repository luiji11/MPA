function currentTrialPosition = mpaBehCorrectiveStimulus(trialAnswers, posIndx, wrongCountIndx)
% mpaSetStimPosition sets the position of the to-be-presented stimulus with
% respect to the outcome of the previous trial. If the last trial was a
% miss, then the stimulus remains in the same position. If the last trial
% was correct, then the stimulus switches to the other side.
% 
% Note that if there was no previous trial (e.g. the first trial), the
% stimulus is positioned on the left side (i.e. 1).
% 
% How to call this function...
% nextTrialPosition = mpaBehCorrectiveStimulus(trialAnswers, posIndx, wrongCountIndx)
% 
% INPUT
%       trialAnswers: data matrix where you store your trial answers + info
%
%       posIndx: column w/in 'trialAnswers' where the previous trial's
%       stimulus position information is located
%
%       wrongCountIndx: column w/in 'trialAnswers' where the previous
%       trial's outcome (e.g. hit or miss) is located. Note that a hit is
%       considered to be a value of zero in this case, and a miss is
%       anything above 1. I do this b/c I am sampling continuously and,
%       instead of checking whether the trial was wrong or right, I simply
%       count the number of times the animal incorrectly licks. So if the #
%       of incorrect licks is zero, then I assume its a HIT trial.
% OUTPUT 
%       nextTrialPosition: either 1 or 2, left or right, depending on
%       previous trial's position.
%


evnt = mpaLastEvent(trialAnswers,[posIndx wrongCountIndx]);

if  (evnt(1) == 0)
    evnt(1) = 2; 
end

currentTrialPosition =  (evnt(2) == 0) * abs(evnt(1) - 3) +  evnt(1) * (evnt(2) > 0);






    


