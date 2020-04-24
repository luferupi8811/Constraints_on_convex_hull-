% written by Luis F. R. Pineda

% Inputs
% hplane = Vector containing the coefficients and the offset of the
%          constraint.
% Example: hplane=[a_1,a_2,...,a_n]. The coefficients are a_1,a_2,...,a_n-1, and the offset is a_n       
% Case = 1 : Upper constraint (a_1x_1 + a_2x_2 +...a_n-1x_n-1 <= a_n) 
% Case = 2 : Lower constraint (a_1x_1 + a_2x_2 +...a_n-1x_n-1 >= a_n)
% Case = 3 : Equal constraint (a_1x_1 + a_2x_2 +...a_n-1x_n-1 = a_n)
% Xp   =  the matrix containing the dataset, where the lines are the variables, 
%         and the columns are the samples of each variable.  
% Outputs
% new_convex: is the boundary points of the resulting convex hull. 
% K: is the matrix of the resulting convex hull, where each line repressents the a facet. 
 
function [new_convex,K] = LinearRestrictionFunction(Xp,hplane,Case)
  K=convhulln((Xp)');   % convex hull elements
  size=length(Xp(:,1)); % n-dimention of the convex hull
  XX1=zeros(size,size+1);          % initialization of the matrix cointainig the convex hull elements  
  var=zeros(1,length(hplane)+1); % initialization of the vector determinant 
  N=1; % intereception points counter
  Ni=1; % no interceptions points counter
  for i=1:length(K)  % for each facet
      XX=Xp(:,K(i,:));
      XX1(:,1:length(XX))=XX;
      XX1(:,length(XX)+1)=XX(:,1);
      if size>2
         n=length(XX);   % number of lines in the facet R^d dimention
      else
         n=length(XX)-1; % number de lines in the facet R^2 dimention
      end
      for j=1:n          % for each line
          line=[XX1(:,j),XX1(:,j+1)]; % matrix of the points
          I=-eye(length(hplane)-1,length(hplane)-1); % identity matrix
          M=[line,I;...                              % coeficient matrix    
             0,0,hplane(1:length(hplane)-1);...
             1,1,zeros(1,(length(hplane)-1))];
          B=[zeros((length(hplane)-1),1);hplane(1,length(hplane));1]; % independent terms vector
          D=det(M); % detereminant of the coeficient matrix
          for n=1:length(M)   % Determining each variable with Cramer
              Mn=M;     % permutation of the coeficient matrix
              Mn(:,n)=B; % permuting de respective column
              Dn=det(Mn); % determinant vector
              var(n)=Dn/D; % calculating the variable
          end
          if var(1)<0 || var(2)<0 % lines that are not intercepted 
              xn(N)=hplane(1:length(hplane)-1)*line(:,1); % independent term of the 1st point
              Nointercep1(N,:)=line(:,1); % 1st point
              N=N+1;
          else                    % lines that are intercepted
              belong(Ni,:)=var(3:length(var)); % interception points
              xi(Ni)=hplane(1:length(hplane)-1)*line(:,1); % independent term of the 1st point
              intercep1(Ni,:)=line(:,1); % 1st point
              Ni=Ni+1; 
          end
        
      end

  end 
  
  % stopping case the restriction doesnt intercept the convex hull
  if Ni==1
    msg = 'The restriction doesnt intercept the current convex hull.';
    error(msg)
    return
  end
  
  % no intercepted lines
  [upper_n]=find(xn<hplane(1,length(hplane)));
  [lower_n]=find(xn>hplane(1,length(hplane)));

  % intercepted lines 
  [upper_i1]=find(xi<hplane(1,length(hplane)));
  [lower_i1]=find(xi>hplane(1,length(hplane)));

  
  % To upper restriction  (/:)
  if Case==1
     new_convex=[belong;Nointercep1(upper_n,:);intercep1(upper_i1,:)];
 % To lower restriction (:/)
  elseif Case==2
    new_convex=[belong;Nointercep1(lower_n,:);intercep1(lower_i1,:)];
  % To equal restriction (:-:)
  elseif Case==3  
    new_convex=belong;
  end  
           
end 


