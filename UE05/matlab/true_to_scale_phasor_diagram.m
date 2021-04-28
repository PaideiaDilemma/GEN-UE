%given values
R = 100;
C = 10 * 10^(-6);
L = 70 * 10^(-3);
Lx = 21.13 * 10^(-3);
U0 = 30;
w = 1000;

para = @(a,b) a*b/(a+b);

ZC = 1/(1i*w*C);
ZL = 1i*w*L;
ZLx = 1i*w*Lx;
ZR = R;

Zges = ZL + para(ZR, ZC) + ZLx;
disp(['Z_ges = (', num2str(Zges), ') Ohm']);

iL = U0/Zges;
uL = iL * ZL;
u1 = U0 - uL;
iR = iL * ZC/(ZC + ZR);
iC = iL - iR;
uRC = iR * ZR;
ux = u1 - uRC;
ix = iL;

disp(['i_L = (', num2str(iL), ') A']);
disp(['u_L = (', num2str(uL), ') V']);
disp(['u_1 = (', num2str(u1), ') V']);
disp(['i_R = (', num2str(iR), ') A']);
disp(['i_C = (', num2str(iC), ') A']);
disp(['u_RC = (', num2str(uRC), ') V']);
disp(['u_x = (', num2str(ux), ') V']);
disp(['i_x = (', num2str(ix), ') A']);


iscale = 15; % scales
uscale = 1/5;

arrowSize = 2;
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
    vectorPlot(iR*iscale, iC*iscale, '-r' ,'I_{C}', arrowSize)
    vectorPlot(0, iR*iscale, '-r' ,'I_{R}', arrowSize)
    vectorPlot(0, ix*iscale, '-r' ,'I_{X}', arrowSize)
    vectorPlot(u1*uscale, uL*uscale, '-b' ,'U_{L}', arrowSize)
    vectorPlot(0, uRC*uscale, '-b' ,'U_{RC}', arrowSize)
    
    % calculated
    vectorPlot(uRC*uscale, ux*uscale, '-b' ,'U_{x}', arrowSize)
    vectorPlot(0, u1*uscale, '-b' ,'U_{1}', arrowSize)
    vectorPlot(0, U0*uscale, '-g' ,'U_{s}', arrowSize)

    % lines + angle
%     line = 2*exp(1i*alpha);
%     plot([-0*real(line),real(line)],[-0*imag(line),imag(line)],'--k');
%     drawAngle(0.7,angle(Ix),angle(Ix)-pi/6,'-30°','-k')  
%     line = 1.5*exp(1i*(angle(Ix)+pi/2));
%     plot([real(Urc*uscale),real(Urc*uscale) + real(line)],...
%     [imag(Urc*uscale),imag(Urc*uscale)+imag(line)],'--k');

    h=gca;
    hold off