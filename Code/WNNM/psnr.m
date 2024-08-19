
function s=psnr(A,B)

[n,m]=size(B);
A=double(A);
B=double(B);

e=A-B;
e=e(1:n,1:m);
me=mean(mean(e.^2));
s=10*log10(1/me);
end
