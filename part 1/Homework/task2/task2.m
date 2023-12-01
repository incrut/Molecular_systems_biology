% Chemotaxis fine-tuned model
% Attractant is added at t=120

% Define constants
global K B R Vb Vr
K = 1;
B = 1;
R = 1;
Vr = 1;
Vb1 = 2; % demethylating rate without attractant
a1 = 10; % activity per receptor with no attractant
a2 = 1;  % activity per receptor with attractant added

% Simulation time
tspan1 = [0 120];  % no attractant
tspan2 = [120 720]; % attractant added

% Initial condition
X0 = 0.5;

% Initialize variables to store the best values
best_x1 = 0;
best_x2 = 0;
closest_ratio = Inf;

% Create variables to store table values
Vb2_values = 0.90:0.01:1.00;
A1_values = zeros(size(Vb2_values));
A2_values = zeros(size(Vb2_values));
A1_A2_ratios = zeros(size(Vb2_values));

% Scan values of Vb2
for i = 1:length(Vb2_values)
    Vb2 = Vb2_values(i);
    Vb = Vb1;
    [t1, X1] = ode45(@chemotaxis_dxdt, tspan1, X0);

    Vb = Vb2;
    X0 = X1(end);

    [t2, X2] = ode45(@chemotaxis_dxdt, tspan2, X0);

    A1 = X1 * a1;
    A2 = X2 * a2;

    % Calculate the ratio of steady-state levels
    ratio = A1(end) / A2(end);

    % Store values in arrays
    A1_values(i) = A1(end);
    A2_values(i) = A2(end);
    A1_A2_ratios(i) = ratio;

    % Print results for the table
    fprintf('Vb2: %.2f\tA1 steady-state: %.4f\tA2 steady-state: %.4f\tA1 / A2: %.4f\n', Vb2, A1(end), A2(end), ratio);

    % Check if the current ratio is closer to 1
    if abs(ratio - 1) < abs(closest_ratio - 1)
        closest_ratio = ratio;
        best_x1 = Vb2 - 0.01;  % Store the lower bound
        best_x2 = Vb2 + 0.01;  % Store the upper bound
    end
end

% Refine the search within the bounds to find a more precise value
best_ratio = Inf;
best_Vb2 = 0;
for Vb2 = best_x1:0.001:best_x2
    Vb = Vb1;
    [t1, X1] = ode45(@chemotaxis_dxdt, tspan1, X0);

    Vb = Vb2;
    X0 = X1(end);

    [t2, X2] = ode45(@chemotaxis_dxdt, tspan2, X0);

    A1 = X1 * a1;
    A2 = X2 * a2;

    % Calculate the ratio of steady-state levels
    ratio = A1(end) / A2(end);

    % Check if the current ratio is closer to 1
    if abs(ratio - 1) < abs(best_ratio - 1)
        best_ratio = ratio;
        best_Vb2 = Vb2;
    end
end

% Display the final result
fprintf('Final answer: %.3f\n', best_Vb2);

% Create a table for values
table_values = [Vb2_values; A1_values; A2_values; A1_A2_ratios];
