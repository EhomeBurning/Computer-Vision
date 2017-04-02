% ======================================================================
% Matrix size reference:
% ----------------------------------------------------------------------
% input: num_classes * batch_size
% output: num_classes * batch_size
% ======================================================================

function [output, dv_input, grad] = fn_softmax(input, params, hyper_params, backprop, dv_output)

[num_classes,batch_size] = size(input);
output = zeros(num_classes, batch_size);
% TODO: FORWARD CODE

temp = exp(input);
temp_1 = temp;        
temp = sum(temp,1);
temp_2 = repmat(temp,num_classes,1);
output = temp_1./temp_2;


dv_input = [];

% This is included to maintain consistency in the return values of layers,
% but there is no gradient to calculate in the softmax layer since there
% are no weights to update.
grad = struct('W',[],'b',[]); 

template = ones(num_classes, num_classes);
if backprop
	dv_input = zeros(size(input));
    for j = 1: batch_size
        for i = 1: num_classes
            %template(i,:) = -temp_1.*temp_1(i)/temp^2;
            template(i,:) = -temp_1(:,j).*temp_1(i,j)/temp(j)^2;
            template(i,i) = (temp_1(i,j)*temp(j) - temp_1(i,j)^2)/temp(j)^2;       
        end
        dv_input(:,j) = template*dv_output(:,j);
    end

    
end
