% -----------------------------------------------------------------------------
% Based on lecture5 script by Michael Kolm
% -----------------------------------------------------------------------------



% NOT FINISHED YET


clear all; close all; clc

%% Values
R = 100;
w = 1000;
U0 = 30;
C = 10e-6;
L = 70e-3

%% Calculations
Urc = 10; % test voltage
Zc = 1/(1i*w*C)
Xc = -1/(w*C);  % --> Zc = jXc
Zl = 1i*w*L;
Xl = w*L;
Ic = Urc/Zc;
Ir = Urc/R;
Ix = Ir + Ic;
Ul = Ix*Zl;
 
% %%%  trigonometric calc. of unknown element.
alpha = angle(Ix)-pi/6;
beta = angle(Ix)+pi/2;
gamma = pi-alpha-(180-beta);
Ux_ = abs(Urc)/sin(gamma-0.118)* sin(alpha);
Ux = Ux_*exp(1i*beta);

U1 = Urc + Ux;
Us = U1 + Ul;


% syms Xx
% F = (1i*Xx*R2)/((R1*R2-Xx*Xc)+1i*(Xx*R2+Xc*R1+Xc*R2) );
% eqn = imag(F)/real(F) == 1;
% Xx_syms = vpasolve(eqn,Xx);
% Lx_syms = Xx_syms/w;

% directly to avoid miscaletakes
% Zstar = R1+R2*1i*Xc/(R2+1i*Xc);
% syms Xx_dir
% F_dir = R2/(R2+1i*Xc)*1i*Xx_dir/(1i*Xx_dir+Zstar);
% eqn = imag(F_dir)/real(F_dir) == 1;
% Xx_d = vpasolve(eqn,Xx_dir);

% %%% Resiscaletor as an unknown element
% Rx = -(R1*R2+R2*Xc+R1*Xc)/(R2+Xc);
% IRx = Ux/Rx;

%% Phasor diagram (lecture5_complete)
iscale = 15; % scales
uscale = 1/5;

arrowSize = 0.5;
set(gcf,'color','w');

figure3=figure(1);
set(gcf,'color','w');
    clf
    s = axes();
    hold on; grid on; box on;
        
    xlabel('Re')
    ylabel('Im')
    axis equal;
    title('Phasor diagram','Fontsize',20)
    vectorPlot(Ir*iscale, Ic*iscale, '-r' ,'I_{C}', arrowSize)
    vectorPlot(0, Ir*iscale, '-r' ,'I_{R}', arrowSize)
    vectorPlot(0, Ix*iscale, '-r' ,'I_{X}', arrowSize)
    vectorPlot(U1*uscale, Ul*uscale, '-b' ,'U_{L}', arrowSize)
    vectorPlot(0, Urc*uscale, '-b' ,'U_{RC}', arrowSize)
    
    % calculated
    vectorPlot(Urc*uscale, Ux*uscale, '-b' ,'U_{x}', arrowSize)
    vectorPlot(0, U1*uscale, '-b' ,'U_{1}', arrowSize)
    vectorPlot(0, Us*uscale, '-g' ,'U_{s}', arrowSize)

    % lines + angle
    line = 2*exp(1i*alpha);
    plot([-0*real(line),real(line)],[-0*imag(line),imag(line)],'--k');
    drawAngle(0.7,angle(Ix),angle(Ix)-pi/6,'-30°','-k')  
    line = 1.5*exp(1i*(angle(Ix)+pi/2));
    plot([real(Urc*uscale),real(Urc*uscale) + real(line)],...
    [imag(Urc*uscale),imag(Urc*uscale)+imag(line)],'--k');

    h=gca;
    hold off
