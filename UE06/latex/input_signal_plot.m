tp = [0 15 15 20 20 25 25 40];
up = [0 3 1 2 -2 -1 -3 0] * (-1);

fig = plot(tp, up);

xlabel('t in ms')
ylabel('u_{in}(t) in V')
ylim([-4 4])
grid on

saveas(fig, 'Figures/inputsignal', 'epsc');


