% define given values
Is1 = 6e-1;
Us2 = 4;
alpha = 5;

g1 = 1/2;
g2 = 1/4;
g3 = 1/8;
g4 = 1/3;

% modified admittanzmatrix
A = [  g2+g4,  -g4,    -g2,        0,      0, -1;
        -g4,    g4,     0,          0,      -1, 0;
        -g2,    0,      g1+g2+g3,   -g1,    1, 0;
        0,      0,      -g1,        g1,     0, 1;
        0,      1,      -1,          0,     0, 0;
        1,      0,      -alpha*g3,  -1,     0, 0    ];

b = [0; Is1; 0; 0; Us2; 0];

% calculate node voltages
x = inv(A) * b;

% name the node voltages
U_n1 = x(1);
U_n2 = x(2);
U_n3 = x(3);
U_n4 = x(4);

% calculate voltages across resistors
U_R1 = U_n4 - U_n3;
U_R2 = U_n1 - U_n3;
U_R3 = U_n3;
U_R4 = U_n2 - U_n1;

% calculate currents
I_R1 = U_R1 * g1;
I_R2 = U_R2 * g2;
I_R3 = U_R3 * g3; 
I_R4 = U_R4 * g4;
I_s2 = x(5);
I_s3 = x(6);

% controlled voltage source
U_s3 = alpha * I_R3;


    % display results
    disp('node voltages:');
    disp(['U_n1 = ', num2str(U_n1), 'V']);
    disp(['U_n2 = ', num2str(U_n2), 'V']);
    disp(['U_n3 = ', num2str(U_n3), 'V']);
    disp(['U_n4 = ', num2str(U_n4), 'V']);
 
    disp('voltages:');
    disp(['U_R1 = ', num2str(U_R1), 'V']);
    disp(['U_R2 = ', num2str(U_R2), 'V']);
    disp(['U_R3 = ', num2str(U_R3), 'V']);
    disp(['U_R4 = ', num2str(U_R4), 'V']);
    disp(['U_s3 = ', num2str(U_s3), 'V']);
    
    disp('currents:');
    disp(['I_R1 = ', num2str(I_R1), 'A']);
    disp(['I_R2 = ', num2str(I_R2), 'A']);
    disp(['I_R3 = ', num2str(I_R3), 'A']);
    disp(['I_R4 = ', num2str(I_R4), 'A']);
    disp(['I_s2 = ', num2str(I_s2), 'A']);
    disp(['I_s3 = ', num2str(I_s3), 'A']);
