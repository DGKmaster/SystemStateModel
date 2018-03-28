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
A = [0, 1, 0;
     0, 0, 1;
    -0.2, -1, -1];

%B = rand(size(X,1),size(U,1));
B = [0; 0; 1];

E = rand(size(X,1),size(N,1));


% To update Y - second equation

%C = rand(size(Y,1),size(X,1));
C = [2, 1, 0];

%D = rand(size(Y,1),size(U,1));
D = 0;

F = rand(size(Y,1),size(N,1));

%% Determine stability
eigen_values = eig(A);
if([1, 1, 1]*(abs(eigen_values) > 1) > 0)
    fprintf("System instable\n");
else
    fprintf("System stable\n");
end

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

%% Determine step parameters
Y_derivative_history = zeros(size(Y,1),T/2);
% 0 - increasing, find maximumm, odd
% 1 - decreasing, find minimum, even
extreme_number = 1;
extreme = 0;
flag = 0;
for i = 1:(T-1)
   if(((Y_history(:,i+1) - Y_history(:,i))*(-1)^mod(flag,2)) > 0)
        extreme = Y_history(:,i+1);
   else
        Y_derivative_history(:,extreme_number) = extreme;
        ++extreme_number;
        ++flag;
   end
end
