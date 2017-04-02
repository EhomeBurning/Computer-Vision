function [model, loss] = train(model,input,label,params,numIters)

% Initialize training parameters
% This code sets default values in case the parameters are not passed in.

% Learning rate
if isfield(params,'lr') lr = params.lr;
else lr = .001; end
% Weight decay
if isfield(params,'wd') wd = params.wd;
else wd = .00005; end
% Batch size
if isfield(params,'batch_size') batch_size = params.batch_size;
else batch_size = 200; end

% There is a good chance you will want to save your network model during/after
% training. It is up to you where you save and how often you choose to back up
% your model. By default the code saves the model in 'model.mat'
% To save the model use: save(save_file,'model');
if isfield(params,'save_file') save_file = params.save_file;
else save_file = 'model.mat'; end

% update_params will be passed to your update_weights function.
% This allows flexibility in case you want to implement extra features like momentum.
update_params = struct('learning_rate',lr,'weight_decay',wd);
loss = zeros(10000,1);
%loss_test = zeros(1000,1);
x = 1;
% y = 1;
addpath pcode
tic
for i = 1:numIters
	% TODO: Training code
    
    %Update learning_rate.
    t = toc;
     if t > 60*x
         update_params.learning_rate = 0.97*update_params.learning_rate;
         x = x + 1;
     end

    
    
    sub_index = randsample(size(input,4),batch_size);
    batch_images = input(:,:,:,sub_index);
    batch_labels = label(sub_index);
    [output, activations] = inference(model, batch_images);
    
    [loss(i), dv_input] = loss_crossentropy(output, batch_labels, [], 1);

%     if i-y == 10
%         [score,~] = inference_(model,test_input);
%         [loss_test(i),~] = loss_crossentropy_(score,test_label,[],0);
%         y = i;
%     end

    if loss(i) < 10
        break
    end
    
    grad = calc_gradient(model, batch_images, activations, dv_input);
    

    model = update_weights(model, grad, update_params);

end


save(save_file,'model');