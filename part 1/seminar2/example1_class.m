% Timing of linear degradation and self-enhanced degradation

% TASKS:
% 1) Currently there is only linear degradation. Implement self-enhanced degradation! 
% 2) Currently only one curve is plotted. Add the seocnd curve for the initial
% condition equal to X0/2 !

global a n
a = 1;
n = 2;
T = 4;

% Simulation time
tspan = [0 2]; % simulation starts at t=0 and ends at t=2

% Initial condition
X0 = 20;

% Run simulation
options = odeset('RelTol',1e-8,'AbsTol',1e-10); % useful for better accuracy
[t1,X1] = ode45(@ode1,tspan,X0,options);
X0 = X0 / 2;
[t2,X2] = ode45(@ode1, tspan, X0, options);

% Plot results
figure
plot(t1,X1, t2, X2);
grid on
hold on

X3 = 0*t1 + T; % add the threshold line to the plot
plot(t1,X3);

% Differential equation
function dydt = ode1(t,y)
    global a n
    dydt = -a*y^n;
end