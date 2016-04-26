function S = mpaComm( comPort )
%BMA_COMARD Summary of this function goes here
%   Detailed explanation goes here

% Initialize Arduino and PTB Object
delete(instrfindall);

S.Ard = serial(comPort);
set(S.Ard,'DataBits',8);
set(S.Ard,'StopBits',1);
set(S.Ard,'BaudRate',115200);
set(S.Ard,'Parity','none');
set(S.Ard, 'terminator', 'LF');    % define the terminator for println
fopen(S.Ard);
S.Ard.ReadAsyncMode = 'continuous';
readasync(S.Ard);

S.Vis       = fopen('mpaPtbComm.txt', 'w+');


end
