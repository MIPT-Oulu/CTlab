function lineProf(ax,rec,ax5,color)

r1 = drawrectangle(ax,'Label','Lineprofile area','Color',color,'Rotatable', true);

p1=r1.Position;

size(rec)

Img=imcrop(rec,[p1(1) p1(2) p1(3) p1(4)]);

lineProf=sum(Img);

plot(lineProf,'Color',color, 'Parent',ax5);
end