% -----------------------------------------------------------------------------
% Uebungsblatt 9
% Maximilian Seidler, Severin Wolf
% -----------------------------------------------------------------------------

clear all; close all; clc

R1 = 50;
R2 = 2e+3;
R3 = 600;
C = 400e-6;
L = 20e-3;
s = tf('s');

% transfer function rearranged
a = R1/R2 + R1/R3 + 1;
b = R1/L + R1/(C*R3*R2) + 1/(C*R3);
c = R1/(L*C*R3);

w1 = -(-b+sqrt(b^2 - 4*a*c))/(2*a);
w2 = -(-b-sqrt(b^2 - 4*a*c))/(2*a);
K = 1/((-w1)*(-w2));
H_arr = K * s^2/((1+s/w1)*(1+s/w2));

opts=bodeoptions('cstprefs');
opts.XLim={[1 1e+5]};
bode(H_arr, opts);
set(findall(gcf,'type','line'),'linewidth',2)
grid on
saveas(gcf, 'ue9_plot.png')
