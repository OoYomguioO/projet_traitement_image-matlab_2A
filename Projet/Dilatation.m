function out=Dilatation(img)
    [nl, nc]=size(img);
    out=img;
    for x=2:nl-1
       for y=2:nc-1
          Max=0;
          for i=y-1:y+1
             for j=x-1:x+1
                 if (img(i,j)>Max)
                     Max=img(i,j);
                 end
             end
          end
          out(i,j)=Max;
       end
    end
    out=uint8(out);
end