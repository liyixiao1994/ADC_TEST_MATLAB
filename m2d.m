
function [b]=m2d(ah,spa,spect)
aa=0;
Fin=ah(1);
ch=ah;
bd=[];
b=[];
for i=1:10
   if abs(ch(i)-ch(1))>0.1 & abs(ch(i)-1)>0.1
       bd=[bd ch(i)];
       aa=aa+1;
   end
end
p=1;
bh=[bd(1)];
for i=2:aa
   ww=0;
   for j=1:p
      if bd(i)==bh(j);
         ww=1;
         break
      end
   end
      if ww==0
         bh=[bh bd(i)];
         p=p+1;
   end
end 
 ed=[];
 R=0;
 e=Fin-spa;
 ee=Fin+spa;
 for i=1:p
        y=0;
         for k=e:ee
            if abs(bh(i)-k)<0.1;
                y=1;
             break
            end
        end   
        if y==0
            ed=[ed bh(i)];
            R=R+1;
        end
 end
  if Fin>11
      q=0;
    for i=1:R
        ww=0;
        for j=1:5
            if abs(ed(i)-j)<0.1
                ww=1
                break;
            end
        end
        if ww==0
            b=[b ed(i)];
            q=q+1;
        end
    end
else
    q=R;
    b=ed;
end
cd=[];
for i=1:q
    d=abs(b);
    cd=[cd spect(d)];
end 
b=max(cd(1:q));
    
return