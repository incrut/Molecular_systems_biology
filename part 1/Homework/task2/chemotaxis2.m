% Chemotaxis Barkai-Liebler robust model
% Attractant is added at t=120

% Define constants
global a K B R Vb Vr
K=1;
B=1;
R=1;
Vb=2;
Vr=1;
a1 = 0.5; % probability of active state without attractant
a2 = 0.1; % probability of active state with attractant added

% Simulation time
tspan1 = [0 120]; % no attractant
tspan2 = [120 300]; % attractant added

% Initial conditions
a = a1;
X0 = 3;

% Run simulation
[t1,X1] = ode45(@chemotaxis2_dxdt,tspan1,X0);

a = a2;
X0=X1(end); % new initial condition is the last value of the previous simulation

[t2,X2] = ode45(@chemotaxis2_dxdt,tspan2,X0);

% Output results
A1 = X1*a1; % activity without attractant
A2 = X2*a2; % activity after attractant added

figure;
plot(t1,A1,t2,A2); % plotting the activity
ylim([0,2]);
grid on