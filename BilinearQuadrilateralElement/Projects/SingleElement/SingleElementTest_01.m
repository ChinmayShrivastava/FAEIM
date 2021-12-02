%% Variables
width = 0.01; %meters
height = 0.01;
t = 0.002;
NU = 0.30;
E = 2E11;
p = 1;
x = [];
x(1) = 0;
x(2) = x(1)+width;
x(3) = 0;
x(4) = x(3)+width;
y = [];
y(1) = 0;
y(2) = 0;
y(3) = y(1)+height;
y(4) = y(3)+height;
u = [0 0 1 1 0 0 1 1];

%% Element Stiffness
k = BilinearQuadElementStiffness(E, NU, t, x(1), y(1), x(2), y(2), x(3), y(3), x(4), y(4), p);

%% Element Area
A = BilinearQuadElementArea(x(1), y(1), x(2), y(2), x(3), y(3), x(4), y(4));

%% Element stresses
S = BilinearQuadElementStresses(E, NU, x(1), y(1), x(2), y(2), x(3), y(3), x(4), y(4), u);














