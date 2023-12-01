% Chemotaxis fine-tuned model
% Attractant is added at t=120

% Define constants
global K B R Vb Vr
K=1;
B=1;
R=1;
Vr=1;
Vb1=2; % demethylating rate without attractant
Vb2=1.1; % demethylating rate with attractant added
a1 = 10; % activity per receptor with no attractant
a2 = 1; % activity per receptor with attractant added

% Simulation time
tspan1 = [0 120]; % no attractant
tspan2 = [120 720]; % attractant added

% Initial condition
Vb = Vb1;
X0 = 0.5;

% Run simulation
[t1,X1] = ode45(@chemotaxis_dxdt,tspan1,X0);

Vb = Vb2;
X0 = X1(end); % new initial condition is the last value of the previous simulation

[t2,X2] = ode45(@chemotaxis_dxdt,tspan2,X0);

% Output results
A1 = X1*a1; % total activity without attractant
A2 = X2*a2; % total activity after attractant added

figure;
plot(t1,A1,t2,A2); % plotting the activity
axis([0 720 0 20]); % x-axis from 0 to 900, y-axis from 0 to 20
grid on