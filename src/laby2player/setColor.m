function img =setColor(img,imgRef,colors,indice)
%img=repmat(imgRef,[1 1 1]);
[indY,indX]=find(imgRef==indice);
for i = 1:3
    for a = 1 : size(indX)
        img(indY(a),indX(a),i) = colors(i);
    end
end
end