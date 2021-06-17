%chain Matrix
A = ZtoA(Z);
A = minreal(A);

%Transfer Function
H = 1/A(1,1);
H = minreal(H)
figure(1);
opts = bodeoptions('cstprefs');
opts.XLim = {[1 1e+5]};
bode(H, opts);
set(findall(gcf,'type','line'),'linewidth',2)
grid on