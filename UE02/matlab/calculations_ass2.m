% define given values
Is3 = 0.8;
Us2 = 5;
alpha = 4;

g1 = 1/10;
g2 = 1/5;
g3 = 1/8;
g4 = 1/12;
g5 = 1/6;
g6 = 1/20;

% modified admittanzmatrix
A = [  g3+g4+g5,   -g3-g4,     -g5,     0, -1;
       -g3-g4,     g2+g3+g4,   0,       -1, 0;
       -g5,        0,          g1+g5,   1,  0;
       0,          -1,         1,       0,  0;
       -alpha*g3-1,alpha*g3,   0,       0,  0];

b = [0; 0; 0; Us2; 0];

% calculate node voltages
x = inv(A) * b;

% name the node voltages
U_n1 = x(1);
U_n2 = x(2);
U_n3 = x(3);

% calculate voltages across resistors
U_R1 = U_n3;
U_R2 = U_n2;
U_R3 = U_n2 - U_n1;
U_R4 = U_n1 - U_n2;
U_R5 = U_n3 - U_n1;

% calculate currents
I_R1 = U_R1 * g1;
I_R2 = U_R2 * g2;
I_R3 = U_R3 * g3; 
I_R4 = U_R4 * g4;
I_R5 = U_R5 * g5;
I_s2 = x(4);
I_s1 = x(5);

% controlled voltage source
U_s3 = alpha * I_R3;


    % display diaresults
    disp('node voltages:');
    disp(['U_n1 = ', num2str(U_n1), 'V']);
    disp(['U_n2 = ', num2str(U_n2), 'V']);
    disp(['U_n3 = ', num2str(U_n3), 'V']);
    disp(' ');
 
    disp('voltages:');
    disp(['U_R1 = ', num2str(U_R1), 'V']);
    disp(['U_R2 = ', num2str(U_R2), 'V']);
    disp(['U_R3 = ', num2str(U_R3), 'V']);
    disp(['U_R4 = ', num2str(U_R4), 'V']);
    disp(['U_R5 = ', num2str(U_R5), 'V']);
    disp(['U_s3 = ', num2str(U_s3), 'V']);
    disp(' ');
    
    disp('currents:');
    disp(['I_R1 = ', num2str(I_R1), 'A']);
    disp(['I_R2 = ', num2str(I_R2), 'A']);
    disp(['I_R3 = ', num2str(I_R3), 'A']);
    disp(['I_R4 = ', num2str(I_R4), 'A']);
    disp(['I_R5 = ', num2str(I_R5), 'A']);
    disp(['I_s2 = ', num2str(I_s2), 'A']);
    disp(['I_s1 = ', num2str(I_s3), 'A']);