function y = BeamElementShearDiagram(f, L)
x = [0; L];
z = [f(1) ; -f(3)];
hold on;
title('Shear Force Diagram');
plot(x,z);
y1 = [0; 0];
plot(x,y1,"k")