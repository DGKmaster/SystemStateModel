%% Prepare environment
clear all;
close all;
clc;

%% Parse initial condition
% Open input file
input_data = fopen('input.txt','r');

% Read file
for i = 1:5
    command = fgetl(input_data);
    eval(command);
end

% Close input file
fclose('input.txt');
