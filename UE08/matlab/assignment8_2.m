s = tf('s');

R = 8;
L = 15 * 10^(-3);
C = 60 * 10^(-6);
U_0 = 15;

U_L = U_0 * (s*L*R*C + L)/(L*C*R*s^2 + s*L + R);


[y,x] = impulse(U_L, 0.06);
                      
                      
%Plot
figure(1)
    clf; hold on; grid on; box on
    set(gcf,'color','w')
    h = plot(x*1000,y);
    legend('U_{L} [V]')
    title('Transient response of Voltage U_{L}')
    xlabel('Time [ms]')
    ylabel('Voltage')