function y = LinearBarElementStiffness(E, A, L)
y = [E*A/L -E*A/L; -E*A/L E*A/L];