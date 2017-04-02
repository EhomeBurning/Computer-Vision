% ======================================================================
% Matrix size reference:
% ----------------------------------------------------------------------
% input: num_in * batch_size
% output: num_out * batch_size
% hyper_params:
% params.W: num_out * num_in
% params.b: num_out * 1
% dv_output: same as output
% dv_input: same as input
% grad: same as params
% ======================================================================

function [output, dv_input, grad] = fn_linear(input, params, hyper_params, backprop, dv_output)

[num_in,batch_size] = size(input);
assert(num_in == hyper_params.num_in,...
	sprintf('Incorrect number of inputs provided at linear layer.\nGot %d inputs expected %d.',num_in,hyper_params.num_in));

% TODO: FORWARD CODE
output_1 = params.W*input;
b = repmat(params.b,1,batch_size);
output = output_1+b;



dv_input = [];
grad = struct('W',[],'b',[]);

if backprop
	dv_input = zeros(size(input));
    dv_input = (params.W') * dv_output;
	grad.W = zeros(size(params.W));
	grad.b = zeros(size(params.b));
	% TODO: BACKPROP CODE
    grad.W = dv_output * input';
    grad.b = dv_output * ones(batch_size, 1);
end
