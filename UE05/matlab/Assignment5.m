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