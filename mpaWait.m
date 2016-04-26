function [kthSampleTimePlusLickHz, kthSamplePlus1]  = mpaWait(lickRate, kthSampleTime, kthSample)
%BMAWAIT Summary of this function goes here
%   Detailed explanation goes here

   while GetSecs - kthSampleTime < 1/lickRate; end;
   kthSampleTimePlusLickHz = GetSecs; 
   
   kthSamplePlus1 = kthSample + 1;

end

