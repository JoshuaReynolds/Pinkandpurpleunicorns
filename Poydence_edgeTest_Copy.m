
% TerraSarX_1.jpg  SABR_1.jpg  Pentagon.jpg

A = imread('Pentagon.jpg');
A = A(:,:,1)*0.2989+A(:,:,2)*0.5870+A(:,:,3)*0.1140;
BW1 = edge(A,'canny');
B = imread('GM_pentagon.png');
B = B(:,:,1)*0.2989+B(:,:,2)*0.5870+B(:,:,3)*0.1140;
B = B;
BW2 = edge(B,'canny');
[m n] = size(BW2);
BW2a = zeros(m,n);
for p = 2:n-1
    for q = 2:m-1
        BW2a(q,p) = ~~(BW2(q-1,p-1)+BW2(q-1,p)+BW2(q-1,p+1)...
                    +BW2(q,p-1)+BW2(q,p-1)+...
                    BW2(q+1,p-1)+BW2(q+1,p)+BW2(q+1,p+1))...
                    *BW2(q,p); % Remove single pixel speckles
    end
end
BW2 = BW2a;
for p = 2:n-1
    for q = 2:m-1
        BW2a(q,p) = ~~(BW2(q-1,p-1)+BW2(q-1,p)+BW2(q-1,p+1)...
                    +BW2(q,p-1)+BW2(q,p-1)+...
                    BW2(q+1,p-1)+BW2(q+1,p)+BW2(q+1,p+1)); % 8-neighbor dilate
    end
end
BW2 = BW2a;
for p = 2:n-1
    for q = 2:m-1
        num = (        BW2(q-1,p) ...
          +BW2(q,p-1)+               BW2(q,p-1)+...
                     + BW2(q+1,p) ); % 4-neighbor erode
        BW2a(q,p) = (num == 4);
    end
end
figure(1)
subplot(2,1,1)
imshowpair(A,BW1,'montage')
subplot(2,1,2)
imshowpair(B,BW2a,'montage')