function [testingclassified,likelihood,error]=Bayes(testingsorted,mean,covar,Numtest)
[l,~]=size(testingsorted(1).Data);
[m,~]=size(mean);
testingclassified=[];
likelihood=zeros(Numtest,m);
for i=1:Numtest
    maxlikelihood=0;
    for j=1:m
       likelihood(i,j)= det(covar(j).ClassCov)^-.5 * exp(-(.5)*((testingsorted(i).Data-(mean(j,:).')).')*(inv(covar(j).ClassCov))*(testingsorted(i).Data-(mean(j,:).')));
    end
    [~,maxlikelihood]=max(likelihood(i,:));
    testingclassified=[ testingclassified struct('PredictedLabel', maxlikelihood, 'ActualLabel', testingsorted(i).Label, 'Data', testingsorted(i).Data)];
end
count=0;
for i=1:Numtest
    if testingclassified(i).PredictedLabel~= testingclassified(i).ActualLabel
        count=count+1;
    end
end
error=(count/Numtest)*100;
end