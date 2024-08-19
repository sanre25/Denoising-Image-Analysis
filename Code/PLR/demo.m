clear
path(path,'images')
imdir=dir('images\*.tif');
siglist=[10 20 50 100];
for j=[1 2]%1:length(imdir)%[1 3 5 7]%
     image=im2double(imread(imdir(j).name));
         
     for i=1:length(siglist)
        sigma=siglist(i);
        randn('seed', 0);
        [nx,nx]=size(image);
        noisy=image+sigma*randn(nx);  
                      
        tic
        u  = plr(noisy,sigma); 
        time=toc;
        timem(i,j)=time;
        psnr(i,j)=10*log10(1*1/var(image(:)-u(:))); % it is 255*255 for 256
      
     end
end
psnr
timem

