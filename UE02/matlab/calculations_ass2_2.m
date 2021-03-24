% define given values
Is3 = 0.8;
Us2 = 0;
alpha = 4;

g1 = 1/10;
g2 = 1/5;
g3 = 1/8;
g4 = 1/12;
g5 = 1/6;
g6 = 1/20;

% Ut (test voltage) is arbitrarily choosen
U_t = 1;

% modified admittanzmatrix
A = [  g3+g4+g5,   -g3-g4,     -g5,     0, -1, 1;
       -g3-g4,     g2+g3+g4,   0,       -1, 0, 0;
       -g5,        0,          g1+g5,   1,  0, -1;
       0,          -1,         1,       0,  0, 0;
       -alpha*g3-1,alpha*g3,   0,       0,  0, 0;
       1,          0,          -1,      0,  0, 0];

b = [0; 0; 0; Us2; 0; U_t];

% calculate the unknown vector
x = inv(A) * b;

% name the test current 
I_t = x(6);

% calulate the equivalent resistance
R_th = U_t/I_t;

% display results
disp(['Test Voltage: ', 'U_t = ', num2str(U_t), 'V'])
disp(['Calculated test current: ', 'I_t = ', num2str(I_t), 'A']);   
disp(['equivalent resistance: ', 'U_t/i_t = ', num2str(R_th), 'ohm']);
