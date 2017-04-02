function updated_model = update_weights(model,grad,hyper_params)

num_layers = length(grad);
a = hyper_params.learning_rate;
lmda = hyper_params.weight_decay;
updated_model = model;

% TODO: Update the weights of each layer in your model based on the calculated gradients

for i = 1:num_layers
    updated_model.layers(i).params.W = model.layers(i).params.W - (a*grad{i}.W + a*lmda*model.layers(i).params.W);
    updated_model.layers(i).params.b = model.layers(i).params.b - (a*grad{i}.b + a*lmda*model.layers(i).params.b);
end