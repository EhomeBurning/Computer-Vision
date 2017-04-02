% Basic script to create a new network model

addpath layers;
run('load_MNIST_data');


l = [init_layer('conv',struct('filter_size',2,'filter_depth',1,'num_filters',3))
	init_layer('pool',struct('filter_size',2,'stride',2))
    init_layer('relu',[])
    init_layer('flatten',struct('num_dims',4))
	init_layer('linear',struct('num_in',507,'num_out',507))
    init_layer('relu',[])
    init_layer('linear',struct('num_in',507,'num_out',10))
    init_layer('softmax',[])];

numIters = 500; % Can be varied
model = init_model(l,[28 28 1],10,true);
%params.learning_rate = 0.01; params.weight_decay = 0.0005; params.batch_size = 128;
params.learning_rate = 0.35; params.weight_decay = 0.00025; params.batch_size = 128;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For train loss
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
input = train_data; label = train_label; 
 
[model,loss] = train(model,input,label,params,numIters,test_data,test_label);
random = randi(60000,[60000 1]);
input_batch = input(:,:,:,random);
ground_truth = label(random);
[output,activations] = inference_(model,input_batch);
[~, predLabel] = max(output);
accuracy = (predLabel' == ground_truth);
accuracy = sum(accuracy);
train_accuracy = (accuracy/60000)*100
train_loss = loss

%save('CNN.mat','model','params','loss','accuracy','-append');


