% n = number of state variables; m = number of inputs
% l  = number of outputs; 
n=4;
A = [-0.01357 -32.2 -46.3 0;
    0.00012 0 1.214 0;
    -0.0001212 0 -1.214 1;
    0.00057 0 -9.1 -0.6696];
B = [-0.433;0.1394;-0.1394;-0.1577];
C = eye(n);
D = zeros(n,1);

R1 = C'*C;
R2 = 1;

x0 = [1;1;1;1];
x0hat = [1.5;1.5;1.5;1.5];

e0 = x0-x0hat;

[Fopt, P] = lqr(A,B,R1,R2);

eig_observer = 5*eig(A-B*Fopt);

KT = place(A',C',eig_observer);
K = KT';

P22=lyap((A-K*C)',P*B*inv(R2)*B'*P);

Jloss = 0.5*e0'*P22*e0;