function [LL]=SHY(beta_all,lwage,X)
prob_wage=zeros(size(lwage));
for i=1:size(lwage)
prob_wage(i)=normpdf(lwage(i),[1 X(i,:)]*beta_all(1:6),beta_all(7));
end 
% loglikelihood for wage we observe
LL=sum(log(prob_wage));
end 