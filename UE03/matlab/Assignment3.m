%define given Values
R_1 = 2; R_2 = 4; R_3 = 3; R_4 = 2; R_5 = 3; R_6 = 5;
L = 5; U_s1 = 4; I_s2 = 0.3; U_s3 = 1; T_0 = 1;

%initial value
i_LT0 = (-U_s1 - I_s2*R_3) / (R_1 + R_3 + R_4);

%Differential Equation
i_L = @(t) ((-U_s1 - I_s2*R_3) / (R_1 + R_3 + R_4) - U_s3 / (R_4 + R_5)) * exp(-(R_4 + R_5)/L * (t - T_0)) + U_s3/(R_4 + R_5);
    %K
    K = ((-U_s1 - I_s2*R_3) / (R_1 + R_3 + R_4) - U_s3 / (R_4 + R_5));
    %tau
    tau = L/(R_4 + R_5);
    %particular
    i_Lp = U_s3/(R_4 + R_5);
    
i_L = @(t) K * exp(-(t - T_0)/tau) + i_Lp;

disp(['initial value: ', num2str(i_LT0)])
disp(['K = ', num2str(K), 'A']);
disp(['tau = ', num2str(tau), 'ms']);
disp(['particular part: ', num2str(i_Lp), 'A']);
disp('Solution of the differential equation:')
disp(['i_L(t) = ', num2str(K), ' * exp(-t + ', num2str(T_0), ') + ', num2str(i_Lp)]);