% Define the boundary conditions
M0 = 1; % Initial concentration at x=0
L = 1;  % Length of the region
M_L = 0; % Concentration at x=L

% Define the differential equation: d^2M/dx^2 = 0
eqn = @(x) 0;

% Define the spatial grid
x = linspace(0, L, 100); % You can adjust the number of points for accuracy

% Calculate the concentration profile
M = M0 - (M0 - M_L) * (x / L);

% Plot the steady-state concentration profile
plot(x, M);
xlabel('Position (x)');
ylabel('Concentration (M)');
title('Steady-State Concentration Profile of M');
