% sanityCheck(trainFunc,testFunc)
%
% sanityCheck will check if the functions trainRegressor and testRegressor
% conform to the accepted programming interface.
% sanityCheck will not check if the values of results are reasonable, only
% that the right number of results are returned.
%
% Inputs:
%
% trainFunc    to test your regressor code type@trainRegressor    type exactly this!
%
% @testRegressor     type exactly this!
%
% These are function handles which you may not be familiar with and are not
% within the scope of this course. Ask a TA if you want to know more.
%
function sanityCheck(trainFunc,testFunc)
%generate some data
trainData=rand(randi([90 110],1),3);
testData=rand(randi([90 110],1),2);
trainIn=trainData(:,1:2);
trainOut=trainData(:,3)*1000+300;
testIn=testData;
%train classifier
try
    param=trainFunc(trainIn,trainOut);
catch exception
    fprintf('Something went wrong in your training Function:\n')
    fprintf(exception.message)
    fprintf('\n\n')
    return
end
%test classifier
try
    results=testFunc(testIn,param);
catch exception
    fprintf('Something went wrong in your testing Function:\n')
    fprintf(exception.message)
    fprintf('\n\n')
    return
end
%check correct number of results is returned
if(((size(results,1)==length(testIn))...
        &...
        (size(results,2)==1))...
        |...
        ((size(results,2)==length(testIn))...
        &...
        (size(results,1)==1)))
    fprintf('Congratulations, your functions return the correct number of results.\n')
else
    fprintf('your testing function did not return the correct number of results.\n')
end
if(isa(results,'double')==0)
    fprintf('your testing function did not return floating point numbers.\n')
end
