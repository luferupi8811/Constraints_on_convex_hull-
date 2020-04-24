% written by Luis F. R. Pineda

close all; clear all; clc
% Inputs
% hplane = Vector containing the coefficients and the offset of the
%          constraint.
% Example: hplane=[a_1,a_2,...,a_n]. The coefficients are a_1,a_2,...,a_n-1, and the offset is a_n       
% Case = 1 : Upper constraint (a_1x_1 + a_2x_2 +...a_n-1x_n-1 <= a_n) 
% Case = 2 : Lower constraint (a_1x_1 + a_2x_2 +...a_n-1x_n-1 >= a_n)
% Case = 3 : Equal constraint (a_1x_1 + a_2x_2 +...a_n-1x_n-1 = a_n)
% R =  the matrix containing the dataset, where the lines are the variables, 
%      and the columns are the samples of each variable.  
% Outputs
% new_convex: is the boundary points of the resulting convex hull. 
% K: is the matrix of the resulting convex hull, where each line repressents the a facet. 

%------------- example of convex hull of 4-dimensions ---------------------

% load the dataset
load('polytopeR4.mat'); 


% first constraint
Case = 1;
a = 2;
b = 2;
c = 2;
d = -1;
e = 100;
hplane = [a,b,c,d,e]; 
[new_convex,K] = LinearRestrictionFunction(R,hplane,Case);


% second constraint
clear a b c d e 
Case1 = 2;
a = 3;
b = 2.5;
c = 2;
d = -1.25;
e = 125;
hplane1 = [a,b,c,d,e];
[new_convex1,K1] = LinearRestrictionFunction(new_convex',hplane1,Case1);

% third constraint
clear a b c d e
Case2 = 2;
a = 0;
b = 0; 
c = 1;
d = 0;
e = 15;
hplane2 = [a,b,c,d,e];
[new_convex2,K2] = LinearRestrictionFunction(new_convex1',hplane2,Case2);

% fourth constraint
clear a b c d e
Case3 = 1;
a = 1;
b = 0; 
c = 0;
d = 0;
e = 20;
hplane3 = [a,b,c,d,e];
[new_convex3,K3] = LinearRestrictionFunction(new_convex2',hplane3,Case3);




