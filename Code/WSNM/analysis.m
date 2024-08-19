

    nSig  = 10;
    inSig = nSig;
    nSig = nSig/255;
    O_Img = im2double(imread("test_images\cameramen_test.jpg")) 

    N_Img = O_Img + nSig* randn(size(O_Img));                                   %Generate noisy image
    PSNR_Noise  =  psnr( N_Img, O_Img);
    
    Par   = ParSet(nSig);   
    [E_Img,objective] = WSNM_DeNoising( N_Img, O_Img, Par );                                %WNNM denoisng function
    PSNR_Est  = psnr( O_Img, E_Img);
    
                                    
