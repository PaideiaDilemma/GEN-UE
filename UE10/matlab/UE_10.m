%-------------------------------------------------------------------------------------------------
% Uebungsblatt 10
% Maximilian Seidler, Severin Wolf
%-------------------------------------------------------------------------------------------------

clear all; close all; clc

%%useful functions
%parallel Impedances
para = @(a,b) (a*b)/(a+b);
%determinat of a 2*2 Matrix
det = @(M) minreal(M(1,1) * M(2,2) - M(1,2) * M(2,1));
%chain Matrix
ZtoA = @(M) minreal(1/M(1,2)) * minreal([M(1,1), det(M); 1, M(2,2)]);

%Values
L_1 = 2;
R_1 = 2;
L_2 = 4;

L_3 = 6;
R_2 = 5;

R_3 = 2;
C_1 = 1;
L_4 = 1;
s = tf('s');

%Impedances of the derived T_Network
Z_a = L_1*s + para(R_1, L_2*s);
Z_b = para(L_3*s, R_2);
Z_c = R_3 + para(1/(C_1*s), L_4*s);
Z_c = minreal(Z_c);
%Z_Matrix
Z = [Z_a + Z_b, Z_b; Z_b, Z_b + Z_c]
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