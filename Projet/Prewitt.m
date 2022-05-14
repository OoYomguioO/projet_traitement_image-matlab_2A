function out=Prewitt(img,type)

    Hs1=[1 1 1; 0 0 0; -1 -1 -1];
    Hs2=[1 0 -1; 1 0 -1; 1 0 -1];

    switch type
        case 1
            out=img;
        case 2
            out=uint8(abs(conv2(img,Hs1)));
        case 3
            out=uint8(abs(conv2(img,Hs2)));
        case 4
            out=uint8(abs(conv2(img,Hs1))+abs(conv2(img,Hs2)));
end