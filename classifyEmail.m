fprintf('Spam Email Classifier\n') 
%Training SVM 
load('spamTrain.mat'); 
fprintf('\nTraining Linear SVM (Spam Classification)\n') 
C = 0.1; 
model = svmTrain(X , y , X , @linearKernel); 
p = svmPredict(model,X);
%Training set Accuracy 
fprintf('Training Accuracy: %f\n', mean(double(p == y)) * 100);

email_data = input('Enter the file name to be identified: ' , "s"); 
file_contents = readFile(email_data);
word_indices = processEmail(file_contents); 
features = emailFeatures(word_indices); 

fprintf('Length of feature vector: %d\n', length(features));
fprintf('Number of non-zero entries: %d\n', sum(features > 0));
x             = emailFeatures(word_indices);
p = svmPredict(model, x);
fprintf('\nProcessed %s\n\nSpam Classification: %d\n', filename, p);
fprintf('(1 indicates spam, 0 indicates not spam)\n\n');