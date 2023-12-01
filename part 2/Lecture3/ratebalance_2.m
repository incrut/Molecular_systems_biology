% % Rate-balance plots
% % 
% % 2) Ultrasensitive feedback, [S]=0
% % 
close all
clear

Astar = 0:0.01:1 ;
kplus = 2 ;
kfs = 30 ;
Kmf = 0.5 ;
kminus = 5 ;
%h = 1 ; % exponent
% h = 2 ; % exponent
h = 4 ; % exponent
% h = 16 ; % exponent

BR = kminus*Astar ;

figure
hold on 
plot(Astar,BR,'r','LineWidth',2)

FR = kfs*(Astar.^h./(Astar.^h+Kmf^h)).*(1-Astar) ;
plot(Astar,FR,'b','LineWidth',2)

set(gca,'TickDir','Out')
xlabel('[A*]/[A]')
ylabel('Rates')