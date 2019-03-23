%% main - Yale B deep learning approach
% retrieve data
clear; clc; close all;

filepath = "{local_path}";
dataName = "YaleFaceCrop.mat";
load( [filepath + dataName]);

fprintf('size of the data set is %i x %i \n',size(x))
%% reshape data from row to image format

reshapeX = reshape(tx,64,64,1,[]);
%trainX = permute(reshapeX,[3 1 2]);

reshapeTX = reshape(tstx,64,64,1,[]);
%% resize image
trX = zeros(28,28,1,size(reshapeX,4));
for i = 1:size(reshapeX,4)
    trx(:,:,1,i) = imresize(reshapeX(:,:,1,i),[28,28]);
    disp(i)
end

%% norm
reshapeX_ = reshapeX./256 - 0.5;
%% shuffle


%% create a simple cnn
%55688 yeung ming moutain

layers = [
            imageInputLayer([64 64 1], 'Name', 'input')
            convolution2dLayer(3, 16, 'Padding',1,'Name', 'conv_1')
            batchNormalizationLayer('Name','bn_1')
            reluLayer('Name', 'relu_1')
            maxPooling2dLayer(2,'Stride',2,'Name','mp_1')
            convolution2dLayer(3, 32, 'Padding', 1, 'Name', 'conv_2')
            batchNormalizationLayer('Name','bn_2')
            reluLayer('Name', 'relu_2')
            maxPooling2dLayer(2,'Stride',2,'Name','mp_2')
            convolution2dLayer(3, 32, 'Padding', 1, 'Name', 'conv_3')
            batchNormalizationLayer('Name','bn_3')
            reluLayer('Name', 'relu_3')
            %additionLayer(2,'Name', 'add')
            %maxPooling2dLayer(2,'Stride',2,'Name','mp_1')
            %convolution2dLayer(1, 28, 'Padding', 0, 'Name', 'conv_2')
            fullyConnectedLayer(28, 'Name', 'fc')
            softmaxLayer('Name', 'softmax')
            classificationLayer('Name', 'classoutput')];

lgraph = layerGraph(layers);
%lgraph = connectLayers(lgraph, 'relu_1', 'add/in1');
%%
plot(lgraph);
 
%% training
catY = categorical(ty);
catTY = categorical(tsty);
options = trainingOptions('sgdm', ...
    'ValidationData',{reshapeTX,catTY},...
    'ValidationFrequency',50, ...
    'InitialLearnRate',0.01, ...    
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropFactor', 0.5, ...
    'MaxEpochs',4, ...  
    'MiniBatchSize',64, ...
    'Verbose',false, ...
    'Plots','training-progress');

net = trainNetwork(reshapeX,catY,lgraph,options);

%%
YPred = classify(net,reshapeTX);
%%
YValidation = catTY';
accuracy = sum(YPred == YValidation)/numel(YValidation);
%%
a = randi(3000,[1,16]);
b= figure(1);
for i = 1:16
subplot(4,4,i);
imshow(reshapeTX(:,:,1,a(i)));
xlabel(['class:' + int2str(YValidation(a(i))) + " pred:" + int2str(YPred(

