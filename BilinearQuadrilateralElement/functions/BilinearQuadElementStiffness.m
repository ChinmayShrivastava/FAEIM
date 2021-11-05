function w = BilinearQuadElementStiffness(E, NU, h, x1, y1, x2, y2, x3, y3, x4, y4, p)
syms s t;
a = (y1*(s-1)+y2*(-1-s)+y3*(1+s)+y4*(1-s))/4;
b = (y1*(t-1)+y2*(1-t)+y3*(1+t)+y4*(-1-t))/4;
c = (x1*(t-1)+x2*(1-t)+x3*(1+t)+x4*(-1-t))/4;
d = (x1*(s-1)+x2*(-1-s)+x3*(1+s)+x4*(1-s))/4;
B1 = [a*(t-1)/4-b*(s-1)/4 0; 0 c*(s-1)/4-d*(t-1)/4;
c*(s-1)/4-d*(t-1)/4 a*(1-t)/4-b*(-1-s)/4];
B2 = [];