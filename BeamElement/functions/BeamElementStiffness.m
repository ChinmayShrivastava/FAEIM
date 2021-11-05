function y = BeamElementStiffness(E,I,L)
y = E*I/(L*L*L)*[12 6*L -12 6*L; 6*L 4*L*L -6*L 2*L*L ;
    -12 -6*L 12 -6*L; 6*L 2*L*L -6*L 4*L*L];