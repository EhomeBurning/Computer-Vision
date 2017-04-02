% ======================================================================
% Matrix size reference:
% ----------------------------------------------------------------------
% input: num_nodes * batch_size
% labels: batch_size * 1
% ======================================================================

function [loss, dv_input] = loss_crossentropy(input, labels, hyper_params, backprop)

assert(max(labels) <= size(input,1));

[num_nodes, batch_size] = size(input);
% TODO: CALCULATE LOSS
index = sub2ind(size(input),labels,[1:size(labels,1)]');
template = -log(input(index));
loss = sum(template);

dv_input = zeros(size(input));
if backprop
	% TODO: BACKPROP CODE
    dv_input(index) = -1./input(index);
    for i = 1:size(labels,1)
        haha(labels(i),i) = -1/input(labels(i),i);
    end
end
