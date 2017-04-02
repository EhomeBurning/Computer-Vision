% ======================================================================
% Matrix size reference:
% input: in_height * in_width * num_channels * batch_size
% output: out_height * out_width * num_filters * batch_size
% hyper parameters: (used for options like stride, padding (neither is required for this project))
% params.W: filter_height * filter_width * filter_depth * num_filters
% params.b: num_filters * 1
% dv_output: same as output
% dv_input: same as input
% grad.W: same as params.W
% grad.b: same as params.b
% ======================================================================

function [output, dv_input, grad] = fn_conv(input, params, hyper_params, backprop, dv_output)

[~,~,num_channels,batch_size] = size(input);
[~,~,filter_depth,num_filters] = size(params.W);
assert(filter_depth == num_channels, 'Filter depth does not match number of input channels');

out_height = size(input,1) - size(params.W,1) + 1;
out_width = size(input,2) - size(params.W,2) + 1;
output = zeros(out_height,out_width,num_filters,batch_size);
% TODO: FORWARD CODE
for i = 1:batch_size
    for j = 1:num_filters
        for k = 1:num_channels
            output(:,:,j,i) = output(:,:,j,i) + conv2(input(:,:,k,i),params.W(:,:,k,j),'valid');
        end
        output(:,:,j,i) = output(:,:,j,i) + repmat(params.b(j),out_height, out_width);
    end
end



dv_input = [];
grad = struct('W',[],'b',[]);

if backprop
	dv_input = zeros(size(input));
    dv_input_temp = zeros(size(input));
    
    for i = 1:batch_size
        for j = 1:num_filters
            for k = 1:num_channels
                x = rot90(params.W(:,:,k,j));
                x = rot90(x);
                dv_input_temp(:,:,k,i) = conv2(x,dv_output(:,:,j,i));
            end
            dv_input(:,:,:,i) = dv_input(:,:,:,i) + dv_input_temp(:,:,:,i);
        end
    end
                
	grad.W = zeros(size(params.W));
    gradW_temp = zeros(size(params.W));
	grad.b = zeros(size(params.b));
	% TODO: BACKPROP CODE
    for i = 1:batch_size
        for j = 1:num_filters
            for k = 1:num_channels
                y = rot90(input(:,:,k,i));
                y = rot90(y);
                gradW_temp(:,:,k,j) = conv2(y, dv_output(:,:,j,i),'valid');
            end
            grad.W(:,:,:,j) = grad.W(:,:,:,j) + gradW_temp(:,:,:,j);
        end
    end
    
    x = sum(sum(dv_output));
    x = squeeze(x);
    grad.b = squeeze(sum(x,2));
    

end


        
        
        
        
        
        
        
        
        
        
        