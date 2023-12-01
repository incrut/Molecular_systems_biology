% Simple regulatiom of X
% X is produced with rate b and degrades with rate a

% Define constants
global a b
a = 20;
b = 2;

% Simulation time
tspan = [0 4]; % simulation starts at t=0 and ends at t=4

% Initial condition
X0 = 0;

% Run simulation
options = odeset('RelTol',1e-8,'AbsTol',1e-10); % useful for better accuracy
[t,X] = ode45(@simple_dxdt,tspan,X0,options);

% Plot results
figure
plot(t,X);

% Differential equation
function dxdt = simple_dxdt(t,X)
    global a b
    dxdt = b - a*X;
end