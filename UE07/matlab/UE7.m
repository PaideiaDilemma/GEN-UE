%% The Signal

T = 4e-3;
R1 = 100;
R2 = 100;
R3 = 300;
C = 25e-6;
U0 = 2.5;

[uin, t] = finsig(1000, T, U0);
%calculated response at the capacitor
uout = foutsig(tin, T);

%% Plot it!!

fig1 = figure(1);
fig1.Position = [100 100 1200 500];
hold on
plot(t, uin, 'LineWidth',2, 'DisplayName', 'Input Signal');
plot(t, uout, 'LineWidth',2, 'DisplayName', 'Capacitor Voltage');
hold off
%title('transient response of the circuit')
legend
xlabel('t in ms')
ylabel('u(t) in V')
xt=arrayfun(@num2str,get(gca,'xtick')*1e+3,'un',0);
set(gca,'xticklabel',xt)
grid on
saveas(fig1, 'output_signal.png')

%% Calculations

function [f, t] = finsig(n, T, U0)
    t = linspace(0,4*T,n);
    f = -U0/T * t + U0 + U0/T * heaviside(t-T) .* (t-T); 
end

function f = foutsig(t, T)
    f = 3*heaviside(t) -3*exp(-500*t) - 500*t.*heaviside(t)+...
        500*(t-T).*heaviside(t-T) + heaviside(t-T).*exp(-500*(t-T))-heaviside(t-T);
    f(1) = 0;
end

