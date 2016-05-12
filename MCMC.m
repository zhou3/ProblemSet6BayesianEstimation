%HW 6
%problem 1\
k=1;
X=[educ exper smsa black south];
[beta,std,std_roubust,my_sigma,r]=OLS(lwage,X,1);
%problem 2
%(a)
% because it assume the flat prior, so
% Q(theta_t+1|theta_t)=Q(theta_t|theta_t+1)
% from deduction, we know wage(i) is N(betaX(i),my_sigma]
%Y = normpdf(X,mu,sigma)  matlab hint
%likelihood for one observation
%beta_all=[beta
 %   sqrt(my_sigma)];
%switch to this if for question b
beta_all=[beta(1)
          0.06
          beta(3:6)
        sqrt(my_sigma)];

LL_orignal=SHY(beta_all,lwage,X);
%update the new parameter given the old paramters

%cov_mat=diag([std.^2' sqrt(var(r))]);
%set the initial value of the beta
%beta_all=[beta
 %         sqrt(my_sigma)];
  beta_final=zeros(size(beta_all,1),1000);
  beta_final(:,1)=beta_all;
  acc=0;
  %for question b
   std(2)=2*std(2);  
 for j=1:1000
%beta_new=normrnd(beta_all,k*[std.^2' sqrt(var(r))]');
%switch to below if for question (b)
 
beta_new=normrnd(beta_all,k*[std.^2' sqrt(var(r))]');

% choose the appropariate k 
LL_new=SHY(beta_new,lwage,X);
if LL_new>LL_orignal 
beta_final(:,j+1)=beta_new;
else 
 acc_prob=LL_orignal/LL_new;
 u=rand;
 if u<acc_prob
   beta_final(:,j+1)=beta_new;
   acc=acc+1;
 else 
     beta_final(:,j+1)=beta_all;
 end 
end 
beta_all=beta_final(:,j+1);
 end 
 histogram(beta_final(1,:));

 %acc_prob=0.3835 is still high, we want to the golden rule which render the
%acc_prob to be .25, so we need to increase the cov_mat a little bit,
%muptiply by a constant

