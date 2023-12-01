% model for french flag model patterning

global M0 a n
M0 = 50; % M level at x=0
a = 1;
n = 2; % exponent of self-degradation (n=1: no self-degradation)

% intergartion boudaries and initial guess of solutions
solinit = bvpinit(linspace(0,10),[5 0]);

% run simulation
% ode2 - differential equation(s), bc2 - boundary condition
sol = bvp4c(@ode2,@bc2,solinit);

% output the result
x = linspace(0,3); % we will plot only between x=0 and x=3
y1 = deval(sol,x);
figure
plot(x,y1(1,:))
hold on;
grid on;

M0 = M0/2;
sol = bvp4c(@ode2,@bc2,solinit);
y2 = deval(sol,x);
plot(x,y2(1,:))

% system of ODEs
function dydt = ode2(x,y)
global a n
M = y(1);
N = y(2);

dM = N;
dN = a*M^n;
dydt = [dM; dN];
end

% boundary condition
% M0 at left, 0 at right
function res = bc2(ya,yb)
global M0
res = [ ya(1)-M0; yb(1)-0 ];
end