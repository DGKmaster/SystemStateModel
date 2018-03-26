%% Prepare environment
clear all;
close all;
clc;

%% Crash course

% X = A*X + B*U + E*N
% Y = C*X + D*U + F*N

% Rows
% size(Y, 1)
% Columns
% size(Y, 2)

%% Parse initial condition
% Open input file
input_data = fopen('input.txt','r');

% Read file
for i = 1:5
    command = fgetl(input_data);
    eval(command);
end

% Close input file
fclose(input_data);

%% Make vector-columns from vector-rows
X = X';
U = U';
N = N';
Y = Y';

%% Create state matrices
% To update X - first equation
%A = rand(size(X,1),size(X,1));
%B = rand(size(X,1),size(U,1));
A = [0, 1, 0;
    0, 0, 1;
    -3, -2, -1];
B = [0; 0; 1];
E = rand(size(X,1),size(N,1));

% To update Y - second equation
%C = rand(size(Y,1),size(X,1));
%D = rand(size(Y,1),size(U,1));
C = [2, 1];
D = 0;
F = rand(size(Y,1),size(N,1));

%% Model system
% Initialize history array for plot
X_history = zeros(size(X,1),T);
Y_history = zeros(size(Y,1),T);

% Modelling
for i = 1:T
    X = A*X + B*U + E*N;
    Y = C*X + D*U + F*N;
    % Save history
    X_history(:,i) = X;
    Y_history(:,i) = Y;
end

% Plot graph
% X states
figure(1);
plot(X_history');
grid on;
title('X');

% Y states
figure(2);
plot(Y_history');
grid on;
title('Y');

%% Determine stability
% L - Symbolic matrix self values
% Q - Symbolic matrix
% Lans - vector-column with real matrix self values
syms L Q;
Q = L*eye(size(A)) - A;
%Lans = linsolve(Q,zeros(size(A,1),1));
Lans = solve(det(Q) == 0, L);