%% The Signal

tp = [0 15 15 20 20 25 25 40] * 1e-3;
up = [0 3 1 2 -2 -1 -3 0] * (-1);

[ud, td] = fsig(1000);
td = td * 1e-3;
T = tp(end);
R = 5000/pi;
C = 0.8e-6;
%% Numerical calc of the fourier-series

n = 250;

[ffour_num, tx] = ffour(ud, td, T, length(td), n);
ffour_num_sum = sum(ffour_num, 1);

[hfour_num, tx_] = hfour(ud, td, T, length(td), n);
hfour_num_sum = sum(hfour_num, 1);

fig1 = figure(1);
tiledlayout(2,1)

% n = 6
ax1 = nexttile;
plot(td, ud); 
title('Input  signal')
xlabel('t in ms')
ylabel('u(t) in V')
grid on

ax2 = nexttile;
hold on
plot(tx_, sum(hfour_num(1:6, :), 1), 'LineWidth',2);
plot(tx, sum(ffour_num(1:6, :), 1), 'LineWidth',2);
hold off
title('Output signal, n=5')
xlabel('t in s')
ylabel('u(t) in V')
grid on
saveas(fig1, 'fourier_n5.png');

%n=250
fig2 = figure(2);
tiledlayout(2,1)

ax1 = nexttile;
plot(td, ud); 
title('Input  signal')
xlabel('t in s')
ylabel('u(t) in V')
grid on

ax2 = nexttile;
hold on
plot(tx_, hfour_num_sum, 'LineWidth',2);
plot(tx, ffour_num_sum, 'LineWidth',2);
hold off
title('Output signal')
xlabel('t in ms')
ylabel('u(t) in V')
grid on
saveas(fig2, 'fourier_n250.png')
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
%%
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


function [f, t] = hfour(ud, td, T, tn, n)
    R = 5000/pi;
    C = 0.8e-6;
    t = linspace(0, T, tn);
    w = 2*pi/T;
    f = zeros(n, numel(t));
    for k = 1:n
        H = 1/(1+1i*k*w*R*C);
        arg_H = atan(imag(H)/ real(H)); %<---
        bk = 2/T * trapz(td, ud.*sin(k*w*td)); %<---
        %bk = 2/T * trapz(td, abs(H) * ud.*sin(k*w*td + arg_H)); %<---
        f(k,:) = abs(H) * bk*sin(k*w*t + arg_H);
        if k < 5
            disp(['coefficient b_k with k=',num2str(k), ' is appox. '...
                num2str(bk)]);
        end
    end
end
function [f, t] = ffour(ud, td, T, tn, n)
    t = linspace(0, T, tn);
    w = 2*pi/T;
    f = zeros(n, numel(t));
    for k = 1:n
        bk = 2/T * trapz(td, ud.*sin(k*w*td)); %<---
        f(k,:) = bk*sin(k*w*t);
        if k < 5
            disp(['coefficient b_k with k=',num2str(k), ' is appox. '...
                num2str(bk)]);
        end
    end
end