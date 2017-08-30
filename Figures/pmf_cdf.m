figure('name','pmf')
set(0,'DefaultAxesFontSize',16)

x = [-1 0 1 2 3 4 5];
y = [nan 0.15 0.2 0.4 0.2 0.05 nan];

h = bar(x(2:end), y(2:end), 'BarWidth',0.01, 'edgecolor','b');
hold
h = plot(x(2:end), y(2:end), 'b.','markersize',30);
box off
ylabel('P(x)')
xlabel('x')
title('pmf','fontsize',18)
print pmf -dpng

figure('name','cdf')
hold on
y(1) = 0;
y(end) = 0;
F = cumsum(y);
for i = 1:(length(x)-1)
    line([x(i) x(i+1)],[F(i) F(i)],'color','b')
end
h = plot(x(2:(end-1)), F(2:(end-1)), 'b.','markersize',30);
ylabel('F(x)')
xlabel('x')
title('cdf','fontsize',18)
print cdf -dpng


% figure('name','pmf')
% set(0,'DefaultAxesFontSize',16)
% 
% x = [- 1 0 1 2 3 4 5];
% y = [nan 0 0.25 0.7 0.05 0 nan];
% 
% h = bar(x, y, 'BarWidth',0.01, 'edgecolor','b');
% hold
% h = plot(x, y, 'b.','markersize',30);
% box off
% ylabel('P(x)')
% xlabel('x')
% title('pmf','fontsize',18)
% print pmf -dpng
