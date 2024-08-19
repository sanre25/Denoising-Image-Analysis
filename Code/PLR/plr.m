
function u=plr(noisy,sigma)
% Hu Haijuan

%predefined parameters
%NOTE: psize*psize*csim<(N-psize+1)*(N-psize+1) shold be satisfied!!!!!
N=43;        % NxN:         train region size 
   
if sigma<30
    psize=7;  % psize*psize: patch size 
else if sigma<=70
        psize=9;
    else psize=11;
    end
end


csim=5; 
step=psize; % step         moving step of train region
thr=1.5*(sigma/255);
psize2=psize*psize;
numpatch=psize2*csim;

[nx,ny]=size(noisy);

%enlarge the noisy image
en1=floor((N-psize)/2);
modnx=mod(nx,step);
en2=en1+(step-modnx)*(modnx~=0);
modny=mod(ny,step);
en2r=en1+(step-modny)*(modny~=0);

newnoisy=enlarge(noisy,en1, en2,en2r);
newnx=nx+en1+en2;
newny=ny+en1+en2r;
% stack all the patches into a matrix
X  =  Im2Patch(newnoisy, psize );
  
%block matching to obtain the 1D location (corresponding to the above 
%matrix)  of similar patches for each central patch
blk_arr   =  Block_matching(newnoisy,X, N,psize,step,numpatch);

 %denoising process 
  %pre assain value for denoising process
    Ys        =   zeros( size(X) );        
    W         =   zeros( size(X) );
    L         =   size(blk_arr,2); 
  for  k  =  1 : L 
        B          =   X(:, blk_arr(:, k));
        mB         =   repmat(mean( B, 2 ), 1, size(B, 2));
        B          =   B-mB;        
        [ys] =   denoise( double(B), thr,mB ); 
        Ys(:, blk_arr(:,k))=Ys(:, blk_arr(:,k))+ys; 
        W(:, blk_arr(:,k))=  W(:, blk_arr(:,k))+ones( size(B) );
  end
    
    %final average
    Mimage=newnx-psize+1;
    Nimage=newny-psize+1;
   r        =   1:Mimage;
   c        =   1:Nimage;    
   im_out   =  zeros(newnx,newny);
   im_wei   =  zeros(newnx,newny);
   k        =   0;
    for i  = 1:psize
        for j  = 1:psize
            k    =  k+1;
            im_out(r-1+i,c-1+j)  =  im_out(r-1+i,c-1+j) + reshape( Ys(k,:)', [Mimage Nimage]);
            im_wei(r-1+i,c-1+j)  =  im_wei(r-1+i,c-1+j) + reshape( W(k,:)', [Mimage Nimage]);
        end
    end
 im_out = im_out./(im_wei+eps);
 u      = im_out(en1+1:en1+nx,en1+1:en1+ny);
return;

%------------------------------------------------------------------
% denoise the similarity matrix
% 
%------------------------------------------------------------------
function denoised = denoise(Scenter, thr,m )
     numpatch  =size(Scenter, 2);
     [bas,tmp] =eig((Scenter*Scenter'));
     diat      =diag(tmp)/(numpatch);
     thr2      =thr^2;
     diatthr   =(diat>thr2);
     multi     =bas*diag(diatthr)*bas'*Scenter;
     denoised  =(multi + m);

return;


function  X  =  Im2Patch( im, psize)
f       =  psize;
N       =   size(im,1)-f+1;
M       =   size(im,2)-f+1;
L       =   N*M;
X       =   zeros(f*f, L, 'single');
k       =   0;
for i  = 1:f
    for j  = 1:f
        k      =  k+1;
        blk    =  im(i:end-f+i,j:end-f+j);
        X(k,:) =  blk(:)';
    end
end
%------------------------------------------------------------------
% % stack all the patches into a matrix
%------------------------------------------------------------------
function  pos_arr   =  Block_matching(noisy,X, N,psize,step,numpatch)


Nimage         =   size(noisy,1)-psize+1;
Mimage         =   size(noisy,2)-psize+1;
r         =   1:step:size(noisy,1)-N+1; 
c         =   1:step:size(noisy,2)-N+1; 
swidth=N-psize+1;
swidth2=swidth^2;
% Index image
L     =   Nimage*Mimage;
I     =   (1:L);
I     =   reshape(I, Nimage, Mimage);
N1    =   length(r);
M1    =   length(c);
pos_arr   =  zeros(numpatch, N1*M1 );

mid=mod(swidth,2)*((swidth2+1)/2)+mod(swidth+1,2)*(swidth2+swidth)/2;  %middle index for with of S change here
for  i  =  1 : N1
    for  j  =  1 : M1
        
        row     =   r(i);
        col     =   c(j);
        idx     =   I(row: row+swidth-1,col:col+swidth-1); % neighborhood region of size (2S+1)^2 for non-boundary pixel (patch)
        idx     =   idx(:);
        B       =   X(:,idx);        %all the patches in the region
        v       =   X(:, idx(mid)); %central patch
        dis     =   B-v(:,ones(1,swidth2)); %Sr(:,mid) is the central patch
       meandis2=    mean(dis.^2);
               
        [~,ind]   =  sort(meandis2);  
        pos_arr(:,(j-1)*N1 + i)  =  idx( ind(1:numpatch) );       
    end
end

%------------------------------------------------------------------
% enlarge matrix by symmetry
%------------------------------------------------------------------
function y=enlarge(x,a,b,br)
% enlarge matrix 
[nlin,ncol]=size(x);
y=x(:,[a:-1:1 1:ncol ncol:-1:ncol-br+1]);
y=y([a:-1:1 1:nlin nlin:-1:nlin-b+1],:);
