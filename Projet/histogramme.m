function h=histogramme(img)
    [nl, nc]=size(img);
    h=zeros(1,256);
    for i=1:nl
        for j=1:nc
            val=img(i,j)+1;
            h(val)=h(val)+1;
        end
    end
end