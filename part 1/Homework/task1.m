% Simple regulation of Y with self-enhanced degradation
% Y is produced with rate b and degrades with rate a

% Define constants
global a b
a = 0.75;  % Given degradation rate
b = 3;     % Given production rate for Y %2.1 - 30% decreased %3.9 - 30% increased

% Simulation time
tspan_primary = [0 8];  % Simulation starts at t=0 and ends at t=8 for the primary curve
tspan_secondary = [8 16];  % Simulation starts at t=8 and ends at t=16 for the secondary curve

% Initial condition for the primary curve
Y0_primary = 0;

% Gene Z activation threshold
K = 1;

% Run simulation for the primary curve
options = odeset('RelTol', 1e-8, 'AbsTol', 1e-10);  % Useful for better accuracy
[t_primary, Y_primary] = ode45(@simple_dydt, tspan_primary, Y0_primary, options);

% Find T1 (activation when Y concentration grows above threshold K)
T1 = t_primary(find(Y_primary > K, 1));

% Initial condition for the secondary curve (based on Y at t=8 from the primary curve)
Y0_secondary = Y_primary(end);

% Run simulation for the secondary curve (for T2 calculation)
%[t_secondary, Y_secondary] = ode45(@simple_dydt, tspan_secondary, Y0_secondary, options);
[t_secondary, Y_secondary] = ode45(@reversed_dydt, tspan_secondary, Y0_secondary, options);


% Find T2 (activation when Y concentration falls below threshold K)
T2 = t_secondary(find(Y_secondary < K, 1));

% Plot the time course of Y with T1 and T2
figure
plot(t_primary, Y_primary, 'b', 'LineWidth', 2);  % Blue for Y concentration in the primary curve
xlabel('Time (t)');
ylabel('Y Concentration');
title('Time Course of Y Concentration');
grid on
hold on
plot(t_secondary, Y_secondary, 'r', 'LineWidth', 2);  % Blue for Y concentration in the secondary curve
% Plot T1 (Y activates Z) as a red dot
plot(T1, K, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
% Plot T2 (Y represses Z) as a blue dot
plot(T2, K, 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'b');

% Display T1 and T2
disp(['T1 (Y activates Z): ', num2str(T1)]);
disp(['T2 (Y represses Z): ', num2str(T2)]);

% Differential equation for Y with self-enhanced degradation
function dydt = simple_dydt(t, Y)
    global a b
    dydt = b - a * Y.^2;
end

function dydt = reversed_dydt(t, Y)
    global a b
    dydt = - b + sqrt(Y.^2)/a;
end
