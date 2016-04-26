function [updatedSig, event] = mpaStoreEvents(sig, eventFrame, otherEventOrIgnore)
%MPASTOREEVENTS stores events in the next available position within your
%'sig' data matrix.
% Inputs:
%   sig: Your MxN data matrix, such as your lick signal, your trial
%   matrix, or your reward matrix
%
%   eventFrame: the frame number the event(s) coincided with. You tend to
%   have this value stored as R.k
%
%   otherEventsOrIgnore: a code for the event, or list of codes. These code
%   can refer to the port that was licked (0,1 or 2), or the side where the
%   stimulus appeared (1, 2, etc.)). You can include more than one event by
%   placing them together in brackets (e.g. [1 3])
% Outputs:
%   updatedSig: An updated version of the matrix, with a new event if one
%   occured.
%    
% Why the fudge do I have this function? This function has proven to be
% VERY usefull for collecting lick data in real time (and also for storing
% other data - e.g. stimulus timestamps, frames when water was dispensed,
% etc.). 
%
% Specifically, the function's efficiency is demonstrated by its abilty to
% ignore anything that is not an event (e.g. when 'otherEventOrIgnore'
% equals zero, and if it is greater than zero, then the frame will be
% stored AND 'otherEventOrIgnore' will also be stored.) For example, when
% sampling a lick response repeatedly, I dont want to save a frame when
% there is no licking behavior. In such a case, otherEventorIgnore would
% take on the value of zero, and no information will be saved. But if it
% reads greater than zero (1 or 2, left or right port), then it will store
% this. This will also prove crucial once I figure out how to sample from
% the visual stimulus platform as well.
%
%Oh, one more thing!: This function increases the size of your storage matrices in
%case you run out of space. This is important because I have no idea how
%much space I should preallocate to store the raw lick response, the number
%of trials, the amount of times that water is dispensed, or the number of
%times stimuli are displayed.

i = find(sig==0,1); % find the first available position in your data matrix

if i == length(sig) % if there are no more positions available, make more space
    sig = [sig; zeros(round(length(sig)/3),2)];
end

% If otherEventOrIgnore is zero, (i.e. if there is no event), dont store
% anything. If it is greater than zero, store the frame and the event too.
event = (sum(otherEventOrIgnore) > 0);

sig(i,1:size(otherEventOrIgnore,2)+1) = [eventFrame, otherEventOrIgnore] * event ;   %     

updatedSig =    sig;




end