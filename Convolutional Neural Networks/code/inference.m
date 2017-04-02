% input: batch_size * num_in_nodes 
% output: output of last layer
% activations: outputs of all layers

function [output,activations] = inference(model,input)
% Do forward propagation through the network to get the activation
% at each layer, and the final output

num_layers = numel(model.layers);
activations = cell(num_layers,1);

% TODO: FORWARD PROPAGATION CODE
params = model.layers(1).params;
hyper_params = model.layers(1).hyper_params;
backprop = false;
activations{1} = model.layers(1).fwd_fn(input, params, hyper_params, backprop);
for i = 2:num_layers
    input = activations(i-1);
    params = model.layers(i).params;
    hyper_params = model.layers(i).hyper_params;
    activations{i} = model.layers(i).fwd_fn( activations{i-1}, params, hyper_params, backprop );
end

output = activations{end};
