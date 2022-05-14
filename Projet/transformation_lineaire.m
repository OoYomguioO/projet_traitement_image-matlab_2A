function out=transformation_lineaire(img)
    img=double(img);

    MinImg=min(min(img));
    MaxImg=max(max(img));

    beta=(-255*MinImg)/(MaxImg-MinImg);
    alpha=255/(MaxImg-MinImg);
    
    out=uint8(alpha*img+beta);
end