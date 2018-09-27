function [replies ErrorFlag] = tango_group_read_attributes2(group_id, attr_name, forward)
%TANGO_GROUP_WRITE_ATTRIBUTES - enhance function with error handling
%
%  INPUTS
%  1. Group identification number
%  2. Attr_name Attribute name
%  3. forward
%
%  See Also tango_group_read_attribute

%
%% Written by Laurent S. Nadolski

ErrorFlag = 0;

if nargin < 2
   error('At least 3 arguments required');
end
if nargin < 3
   forward = 0;
end

replies = tango_group_read_attributes(group_id, attr_name, forward);

if tango_error == -1
    tango_print_error_stack;
    ErrorFlag = 1;
    return;
else
    if replies.has_failed > 0
        ErrorFlag = 1;
        for k=1:length(replies.dev_replies),
            if replies.dev_replies(k).has_failed
                for ik=1:size(replies.dev_replies(k).attr_values,2)
                    tango_print_error_stack_as_it_is(replies.dev_replies(k).attr_values(ik).error);
                    replies.dev_replies(k).attr_values(ik).value = NaN;
                end
            end
        end
        ErrorFlag = 1;
        %return;
    end
end
