%% The Signal 

tp = [0 15 15 20 20 25 25 40];
up = [0 3 1 2 -2 -1 -3 0] * (-1);
[ud, td] = fsig(1000);
T = tp(end);


%% Numerical calc of the fourier-series

n = 250;

[ffour_num, tx] = ffour(ud, td, T, length(td), n);
ffour_num_sum = sum(ffour_num, 1);
fig1 = figure(1);
tiledlayout(2,1)

% n = 5
ax1 = nexttile;
plot(td, ud); 
title('Input  signal')
xlabel('t in ms')
ylabel('u(t) in V')
grid on

ax2 = nexttile;
hold on
for k = 1:5
    plot(tx, ffour_num(k, :));
end
plot(tx, sum(ffour_num(1:5, :), 1), 'LineWidth',2);
hold off
title('Fourier series, n=5')
xlabel('t in ms')
ylabel('u(t) in V')
grid on
linkaxes([ax1 ax2],'xy')
saveas(fig1, 'fourier_n5.png');

%n=250
fig2 = figure(2);
tiledlayout(2,1)

ax1 = nexttile;
plot(td, ud); 
title('Input  signal')
xlabel('t in ms')
ylabel('u(t) in V')
grid on

ax2 = nexttile;
hold on
for k = 1:n
    plot(tx, ffour_num(k, :));
end
plot(tx, ffour_num_sum, 'LineWidth',2);
hold off
title('Fourier series, n=250')
xlabel('t in ms')
ylabel('u(t) in V')
grid on
saveas(fig2, 'fourier_n250.png')
linkaxes([ax1 ax2],'xy')


%% Analytical
ffour_ana = zeros(1, numel(tx));
w = 2*pi/T;
for k = 1:n
    bk1 = - (80*sin((3*pi*k)/4) - 60*pi*k*cos((3*pi*k)/4))/(pi^2*k^2);
    bk2 = - (80*sin(pi*k) - 40*pi*k*cos(pi*k)...
        -80*sin((3*pi*k)/4)+20*pi*k*cos((3*pi*k)/4))/(pi^2*k^2);
    bk3 = - (80*sin((5*pi*k)/4) + 20*pi*k*cos((5*pi*k)/4)...
        -80*sin(pi*k)-40*pi*k*cos(pi*k))/(pi^2*k^2);
    bk4 = - (80*sin(2*pi*k)-80*sin((5*pi*k)/4)-60*pi*k*cos((5*pi*k)/4))/(pi^2*k^2);
    bk = (bk1 + bk2 + bk3 + bk4) * 2/T;
    ffour_ana = ffour_ana + bk*sin(k*w*tx);
end

%figure(3)
%plot(tx, ffour_ana)


function [f, t] = fsig(n)
    T = 40;
    t = linspace(0,T,n);
    f = -1/5*t;
    for i = 1 : length(t)
        if t(i) > 15 && t(i) < 20
            f(i) = f(i) + 2;
        elseif t(i) > 20 && t(i) < 25
            f(i) = f(i) + 6;
        elseif t(i) > 25
            f(i) = f(i) + 8;
        end
    end
end

function [f, t] = ffour(ud, td, T, tn, n)
    t = linspace(0, T, tn);
    w = 2*pi/T;
    f = zeros(n, numel(t));
    for k = 1:n
        bk = 2/T * trapz(td, ud.*sin(k*w*td));
        f(k,:) = bk*sin(k*w*t);
        if k < 5
            disp(['coefficient b_k with k=',num2str(k), ' is appox. '...
                num2str(bk)]);
        end
    end
end