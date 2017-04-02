function [grad] = calc_gradient(model, input, activations, dv_output)
% Calculate the gradient at each layer, to do this you need dv_output
% determined by your loss function and the activations of each layer.
% The loop of this function will look very similar to the code from
% inference, just going in reverse this time.

num_layers = numel(model.layers);
grad = cell(num_layers,1);

% TODO: Determine the gradient at each layer with weights to be updated
for i = num_layers:-1:2
    params = model.layers(i).params;
    hyper_params = model.layers(i).hyper_params;
    backprop = true;
    [~,dv_output,grad{i}] = model.layers(i).fwd_fn( activations{i-1}, params, hyper_params, backprop, dv_output);
end
params = model.layers(1).params;
hyper_params = model.layers(1).hyper_params;
[~,~,grad{1} ]= model.layers(1).fwd_fn(input, params, hyper_params, backprop, dv_output);
    
