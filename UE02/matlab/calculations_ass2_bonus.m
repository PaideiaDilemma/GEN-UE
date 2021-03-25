Uth = -3.3838;
Rth = 1.212121;
R6 = 20;

% Is3 = 0mA, voltage divider
Ur6_0 = Uth * R6/(Rth+R6);

% Uth = 0V, Is3=1A, current divider
Is3 = 1;
Ir6_1 = Is3 * Rth/(Rth+R6);

% Ur6 = k*Is3 + d, d = Ur6_0
Ur6 = Ur6_0 + Ir6_1*R6;
k = (Ur6 - Ur6_0)/Is3;

% Ur6 = 20, 20 =f k*Is3 + Ur6_0
Is3 = (20 - Ur6_0)/k
