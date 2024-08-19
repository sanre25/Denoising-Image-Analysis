  

    nSig  = 1/5;
   % O_Img = im2double(imread('house.png'));
    O_Img = imread('house.png');
    O_Img = im2double(O_Img);

   % randn('seed', 0);
    N_Img = O_Img + nSig * randn(size(O_Img));                                   %Generate noisy image
    PSNR  =  psnr( N_Img, O_Img);
    fprintf( 'Noisy Image: nSig = %2.3f, PSNR = %2.2f \n\n\n', nSig, PSNR );
    
    Par   = ParSet(nSig);    
    E_Img = WNNM_DeNoising( N_Img, O_Img, Par );                                %WNNM denoisng function
    PSNR  = psnr( O_Img, E_Img);
    
    fprintf( 'Estimated Image: nSig = %2.3f, PSNR = %2.2f \n\n\n', nSig, PSNR );
    %imshow(uint8(E_Img)); %uint8 lagane pe img black dhabba
    imshow(E_Img);

    % for nSig<=1 this algo gives only correct answer 
    % for nSig>1 it tptaly disapper original image
    % the main reason is  im2double function scaled the 1 to 256 values
    % to 0 to 1 ,, and nISg * random(0,1) it values change very much

