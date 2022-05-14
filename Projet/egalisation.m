function out=egalisation(img)
    [nl, nc]=size(img);
    h=histogramme(img);
    p=h/(nl*nc);
    s(1)=p(1);
    
    for i=2:256
        s(i)=s(i-1)+p(i);
    end
    
    for i=1:nl
        for j=1:nc
            val=img(i,j)+1;
            out(i,j)=s(val)*255;
        end
    end
    out=uint8(out);
end