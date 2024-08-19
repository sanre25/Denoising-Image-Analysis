  

    nSig  = 1/5;
    %inSig = nSig;
    %nSig = nSig/255;
    O_Img = double(imread('lena_gray.bmp'))./255;
    O_Img = im2double(imread("house.png"));
    %O_Img = double(imread('1_amplitude_gray.bmp'))./255;
    % assumption of nsig=1/2
    nSig  = 1/2;
    imshow(O_Img)

    %randn('seed', 0);
    N_Img = O_Img + nSig* randn(size(O_Img));                                   %Generate noisy image
    imshow(N_Img)
    PSNR1  =  psnr( N_Img, O_Img);
    fprintf( 'Noisy Image: nSig = %2.3f, PSNR = %2.2f \n\n\n', inSig, PSNR );
    
    Par   = ParSet(nSig);   
    E_Img = WSNM_DeNoising( N_Img, O_Img, Par );                                %WNNM denoisng function
    E_Img = WSNM_DeNoising( O_Img, O_Img, Par );   
    imshow(E_Img)
    PSNR2  = psnr( O_Img, E_Img);
    
    fprintf( 'Estimated Image: nSig = %2.3f, PSNR = %2.2f \n\n\n', nSig, PSNR );
    imshow(uint8(E_Img.*255));