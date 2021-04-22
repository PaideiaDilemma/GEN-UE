% tidy up the Matlab environment
clear all; close all; clc;     

%% Given values
R1 = 50;
R2 = 200;
R3 = 50;
C = 10e-6;
L = 100e-3;
U = 10;
f = 1000;
il0 = 50e-3;
uc0 = -5;
w = 2*pi*f;


%% Both Switches are in their initial Position
%time constant 
tau1 = L/(R1+R3);
t_switch = 2*tau1;
%Generate linearly spaced vector of 10000 evenly spaced points
ta = linspace(0,t_switch,10000); 

lambda1 = 1/tau1;
%The Value ila at t_switch (2tau)
il_2tau = U/(R1+R3)+(il0 - U/(R1+R3))*exp(-lambda1*t_switch);
ila = U/(R1+R3)+(il0- U/(R1+R3))*exp(-lambda1*ta);
ula = L*diff(ila)./(diff(ta));

%% The Switches filipped!
tb = linspace(t_switch,10e-3,10000);
tbh = tb-t_switch;
%attenuation (Daempfung)
delta = (1/(R2*C) + R3/L)/2
%resonanzfrequenz
omega_sqr = 1/(C*L) + R3/(R2*C*L);
omega = sqrt(omega_sqr);
%eigenfrequency
omega_d = sqrt(omega_sqr - delta^2); 
K2 = ((uc0-il_2tau*R3)/L+(delta*il_2tau))/omega_d
ilb = exp(-delta*tbh).*(il_2tau*cos(omega_d*tbh)+K2*sin(omega_d*tbh));
ulb = L*diff(ilb)./(diff(tbh));

%% Plot Current iL
figure(2) 
   
    subplot(2,1,1); hold on % divides the current figure into an 2-by-1 grid
    plot(ta*1000, ila,'r','linewidth',2)
    plot(tb*1000, ilb,'r','linewidth',2)
    grid on; box on;
    title('Current over Inductor L, for t in [0ms, 10ms]')
    xlabel('Time [ms]')
    ylabel('Current [A]')
    legend('Current i_L(t)','Location','south')
    
    subplot(2,1,2); hold on
    plot(ta(1:end-1)*1000, ula, 'b','linewidth',2)
    plot(tb(1:end-1)*1000, ulb, 'b','linewidth',2)
    grid on; box on
    %ylim([-6,2])
    title('Voltage in Inductor L, for t in [0ms, 10ms]')
    xlabel('Time [ms]')
    ylabel('Voltage [V]')
    legend('Voltage u_L(t)','Location','south')
    
 
