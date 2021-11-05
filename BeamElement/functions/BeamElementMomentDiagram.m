function y = BeamElementMomentDiagram(f, L)
x = [0; L];
z = [-f(2); f(4)];
hold on;
title('Bending Moment Diagram');
plot(x, z);
y1 = [0; 0];
plot(z, y1, 'k')