%% Introduction to Matlab
% Mai Le
% 09-04-13


%% Declaring variables
keyboard;
x = 2
abc_123 = 0.005
% 1ab = 2 % you cannot begin a variable name with a number
y = 'eecs451' % string
eecs_451_is_fun = true % boolean

% Comments are preceded by '%'
% Semicolons supress output
% '%%' delineates cells

% Matlab has some special values with reserved names
radius = 5/3;
circ = 2*pi*radius
inf
NaN 
i % very useful!
j 

%% Relational Operators
4 < 4
4 <= 4
x = 6;
y = 3;
x > y
x >= y
z = 3;
y == z
y ~= z % not != like in C

% Use logical operators to combine boolean expressions
% not
~eecs_451_is_fun
% and
(x >= y) & (y == z)
% or
(x < y) | (y == z)

%% Matrices
% scalars
x = 23
u = 7/4 + 0.3*i

% row vectors
y = [12, 10, 3] 
v = [12 10 3] 

% column vector
z = [12; 10; 3] 
w = y' 
% Note on transpose: If you use ' on a complex matrix, it will do transpose AND a
% complex conjugate (this is known as the Hermitian). If you seek to take
% just the transpose of a Hermitian matrix, use .'
% for example: B = A.';


% Extracting elements of vectors 
% Indexing begins at 1, not 0!
y(3)
y(end)
y(1)
% y(0) % this will yield an error!

% You can also create evenly spaced entries with the colon operator or
% linspace
x = 1:0.5:5
y = linspace(0,10,25)

clear; % this will clear all the variables from your workspace

% Matrices
X = [1 2 3; 4 5 6; 7 8 9]
X(2,3)
X(1,end)
% X(3,0) % this will yield an error!

X13 = X(3,1:3)
X22 = X(1:2,2:3)
X21 = X(1:2,1)
X(:,3) % equivalent to X(1:end,3)
X(:) % stretches out matrix column-by-column into a vector

%% Augmenting and Concatenating Matrices

X(4,2) = pi
X1 = [1 2; 3 4]
X2 = [5 6; 7 8]
Y = repmat(X,2,2)
Z1 = [X1; X2]
Z2 = [X1 X2]

%% Matrix Operations

Y1 = X1 + 5;
Y2 = X1 + X2;

Y1 = X1*X2;
Y2 = X1.*X2; % elementwise multiplication

Z1 = X1.^2; % elementwise exponentiation
Z2 = X1^2;
Z3 = X1.^X2; % elementwise exponentiation
Z4 = X1./X2; % elementwise division
Z5 = X1/X2; % X1*inv(X2)

% other ways to construct matrices
% zeros
% ones
% eye
% rand % random numbers from a uniform distribution
% randn % random numbers from a standard Gaussian
% diag

% other matrix functions
% size
% length
% det
% inv
% \ % this computes left-sided inverse. For AX=B, X = A\B.
% eig
% rank
% find

% abs % absolute value or magnitude
% sign
% sin
% cos
% asin
% acos
% exp
% log, log10
% ceil, floor
% round
% real
% image
% angle % calculates phase
% sort

% sum
% prod
% max
% min
% mean
% median
% std
% var

% help is a useful tool! type help <function name> for syntax help

%% Plotting commands

t = 0:0.01:6;
y = t.*(t >= 1)+(1./t).*(t < 1);
plot(t,y);
xlabel('t values');
ylabel('y values');
title('sample plot');

%% Importing/Exporting Data

load data.mat

save('info.mat','X1','X2')

%% Flow Control

if (eecs_451_is_fun)
    display('hip hip hooray');
end

counter = 0;
for ii = 1:12 % be careful not to overwrite i and j
    counter = counter + 1;
end

% you can nest for loops
n = 5;
m = 6;
a  = zeros(n,m);
for ii = 1:n
    for jj = 1:m
        a(ii,jj) = 1/(ii+jj);
    end
end

sum = 0;
while (counter > 2)
    sum = sum + counter;
    counter = counter - 1;
end

%% publishing your scripts

publish('Homework10','pdf')


% for more info, http://www.mathworks.com/help/matlab/matlab_prog/publishing-matlab-code.html
