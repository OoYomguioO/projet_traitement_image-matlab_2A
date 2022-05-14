function out=multiseuilsNB(img,NBseuil)

    [nl,nc]=size(img);
    out=zeros(nl,nc);

    for i=1:NBseuil
       temp=(img<(255/NBseuil)*i) & (img>=(255/NBseuil)*(i-1));
       temp=temp*(((255/NBseuil)*i)+((255/NBseuil)*(i-1)))/2;
       out=out+temp;
    end

    out=uint8(out);
end