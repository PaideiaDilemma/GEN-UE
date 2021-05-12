t = linspace(-2, 6, 1000);

T = 4;
U0 = 5;

k = U0 / T;

u = heaviside(t) .* (U0 - k * t) + heaviside(t - T) .* k .* (t - T);

fig = plot(t, u, 'LineWidth', 3);
xlabel('t');
ylabel('u(t)');
grid on;
yticks([0, U0])
xticks([0, T])
ylim([0, U0 + 1]);

xticklabels({'$0$', '$T$'})
yticklabels({'$0$', '$U_0$'})

set(gca,'TickLabelInterpreter','latex')

set(gca, 'fontsize', 18);
saveas(fig, 'Figures/input-signal', 'epsc');



