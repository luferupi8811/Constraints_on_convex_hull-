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

%------------- example of convex hull of 2-dimensions ---------------------

% load the dataset
load('polytopeR2.mat'); 

% applying the constraint  
Case = 2;
a1 = 2;
a2 = -2;
a3 = 4;
hplane = [a1,a2,a3]; 
[new_convex,K] = LinearRestrictionFunction(R,hplane,Case);
x1=(5:35);
x2=(-a1*x1+a3)/a2;
plot(x1,x2,'color',[210, 100, 100]/255,'linewidth', 2)
hold on


% ploting the original convex hull
K_u=unique(K);
X_Pol=R(:,K_u);
for i=1:length(K)
      
c_n(1,:)=[R(1,(K(i,1))),R(2,(K(i,1)))]; 
c_n(2,:)=[R(1,(K(i,2))),R(2,(K(i,2)))]; 

hold on
plot(c_n(:,1),c_n(:,2),'k','LineWidth',2)  
end   
ylabel('x_{2}','FontSize',20,'FontName','times')
xlabel('x_{1}','FontSize',20,'FontName','times')
aa = get(gca,'XTickLabel');
set(gca,'XTickLabel',aa,'FontName','Times','fontsize',20)
plot(X_Pol(1,:),X_Pol(2,:),'ko',...
    'LineWidth',2,...
    'MarkerSize',8,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor',[0.5,0.5,0.5])
title('Convex hull with the constraint')
hold off

% ploting the new convex hull
clear K R        % keep comented to plot the original convex hull
R=new_convex';   % keep comented to plot the original convex hull
K=convhulln(R'); % keep comented to plot the original convex hull
K_u=unique(K);
X_Pol=R(:,K_u);
figure
for i=1:length(K)
      
c_n(1,:)=[R(1,(K(i,1))),R(2,(K(i,1)))]; 
c_n(2,:)=[R(1,(K(i,2))),R(2,(K(i,2)))]; 

hold on
plot(c_n(:,1),c_n(:,2),'k','LineWidth',2)  
end   
ylabel('x_{2}','FontSize',20,'FontName','times')
xlabel('x_{1}','FontSize',20,'FontName','times')
aa = get(gca,'XTickLabel');
set(gca,'XTickLabel',aa,'FontName','Times','fontsize',20)
plot(X_Pol(1,:),X_Pol(2,:),'ko',...
    'LineWidth',2,...
    'MarkerSize',8,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor',[0.5,0.5,0.5])
title('New convex hull')
hold off

