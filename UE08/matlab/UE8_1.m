% -------------------------------------------------------------------------
% Uebungsblatt 8 - Assignment 1
% Based on Example from Lecture 7 by Michael Kolm
% Maximilian Seidler, Severin Wolf
% -------------------------------------------------------------------------

clear all; clc; close all

%% Values
R1 = 8; 
R2 = 2;
R3 = 2;
L1 = 6e-3;
L2 = 3e-3;
C = 450e-6;
U0 = 15;
w = 1000;
UC0 = 1;
IL2_0 = 1;

%% Calculations - Node Voltage Method with Laplace
s = tf('s');     % define the Laplace variable (transfer function)
A = [ 1/R1+1/(s*L1)   -1/R1-1/(s*L1)            0           -1
     -1/R1-1/(s*L1) 1/R1+1/R2+1/R3+1/(s*L1)+s*C -1/R2       0
        0               -1/R2               1/R2+1/(s*L2)   0
        -1                0                     0           0];
 
Us = tf(15*w, [1,0,w^2]);
IL2_s = tf(IL2_0, [1,0]);
UC0_s = tf(C*UC0, [0,1]);

b = [0 ; UC0_s ; -IL2_s ; Us];

un = inv(A)*b;
un = minreal(un); % Minimal realization or pole-zero cancelation
un = zpk(un);     % Constructs zero-pole-gain model
[y,x] = impulse(un, 20e-3);  %impulse calculates the unit impulse response
                             %of a dynamic system model
U_t = -y(:,1);              
                      
%Plot
figure(1)
    clf; hold on; grid on; box on; grid minor
    set(gcf,'color','w')
    plot(x*1000,U_t,x*1000,y(:,2));
    ylim([-16,16])
    yticks('auto')
    l = legend({'$u_{s}$ [V]','$u_{C}$ [V]'},'Interpreter','Latex');
    t = title('$u_s(t)$ and $u_C(t)$ calculated via node voltages', ...
    'Interpreter','Latex');
    xlabel('Time [ms]','Interpreter','Latex')
    ylabel('Voltage [V]','Interpreter','Latex')
    set(l, 'FontSize', 12)
    set(t, 'FontSize', 12)
    saveas(gcf, 'ue8_ass_1_plot.png')
