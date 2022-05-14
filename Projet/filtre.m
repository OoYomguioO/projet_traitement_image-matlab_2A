function out=filtre(img,type)
[nl,nc]=size(img);

 switch type
        case 1
            out=img;
        
        case 2
            moy=1/9*ones(3,3);
            out=uint8(abs(conv2(img,moy)));
        
        case 3
            out=zeros(nl,nc);
            for i=2:nl-1
               for j=2:nc-1
                   med=sort([img(i-1,j-1) img(i-1,j) img(i-1,j+1) img(i,j-1) img(i,j) img(i,j+1) img(i+1,j-1) img(i+1,j) img(i+1,j+1)]);
                   out(i,j)=med(5);
               end
            end
            out=uint8(abs(out));
            
        case 4
            out=zeros(nl,nc);
            for i=2:nl-1
               for j=2:nc-1
                   mil=sort([img(i-1,j-1) img(i-1,j) img(i-1,j+1) img(i,j-1) img(i,j) img(i,j+1) img(i+1,j-1) img(i+1,j) img(i+1,j+1)]);
                   out(i,j)=(mil(1)+mil(9))/2;
               end
            end
            out=uint8(abs(out));
end