function P = mpaInitializePatches(w,wOff)
%%
scrnHeightCm    = 29.9;        %mcGee lab monitor
viewingDistInCm = 36;


V       = mpaGetPixelSizeInDegrees(viewingDistInCm, scrnHeightCm);
lx      = V.screenSize_pix(1);
ly      = V.screenSize_pix(2);
D       = V.oneDeg_pix;                                 % a degree of visual angle in pixels
L       = mean([BlackIndex(w) WhiteIndex(w)]);          % Mean luminance of gabors

f       = D./linspace(.05, .5, 3);                      % Wavelength of gabors, in pixels
F       = f + (lx - floor(lx./f).*f) ./ floor(lx./f);   % adjusted wavelength (for equaluminance)
% adjF  = [D./F;D./f]';

y       = 0:ly-1;
Yf      = @(x,f) sin(y*2*pi/f)' * ones(1,round(lx/2)) ; % Sinewave Grating filling half the screen

[X,Y]   = meshgrid(1:round(lx/2),y);
Sg      = 7*D;                                           % Sigma of Gaussian in of visual angle                   
Gf      = @(x,y,cx,cy,s) exp( -((x-cx).^2 + (y-cy).^2)/(2*s^2) );

P.G          = zeros(length(F),1);
for i = 1:length(F)
    
   Gbp            =  (Gf(X,Y,lx/4,ly/2,Sg) .* Yf(y,F(i) ) + 1)* L ;
   P.G(i)    = Screen('MakeTexture',   w, [Gbp Gbp]);    
   

end


%% Bright Patches


% c = [lx/4, ly/2];
c = [lx/10, ly/4];
r = 2*D;

        Screen('FillOval', wOff, [255 255 255], [c(1)-r, c(2)-r, c(1)+r, c(2)+r]);
CI  =   Screen('GetImage', wOff); 

imagesc(CI)

%%
P.B =   Screen('MakeTexture',   w, CI);



P.blinkHz = 3;



Screen('Close', wOff);








