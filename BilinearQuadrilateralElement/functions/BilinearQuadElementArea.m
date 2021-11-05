function y = BilinearQuadElementArea(x1, y1, x2, y2, x3, y3, x4, y4)
yfirst = (x1*(y2-y3)+x2*(y3-y1)+x3*(y1-y2))/2;
ysecond = (x1*(y3-y4)+x3*(y4-y1)+x4*(y1-y3))/2;
y = yfirst+ysecond;