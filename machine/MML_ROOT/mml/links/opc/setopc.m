function ErrorFlag = setopc(ChannelNames, NewSP)

global DA_GLOBAL DA_GROUP_GLOBAL

if isempty(DA_GLOBAL)
    DA_GLOBAL = opcda('localhost','RSLinx Remote OPC Server');
    connect(DA_GLOBAL);
    fprintf('   Remote OPC Server Initialized.\n');
end

%if isempty(DA_GROUP_GLOBAL)
    DA_GROUP_GLOBAL = addgroup(DA_GLOBAL);
%else
%    % You might have to flush old data out of the group, I'm not sure ???
%    flushdata(DA_GROUP_GLOBAL);
%end


% Que the gets
for i = 1:size(ChannelNames, 1)
    item{i} = additem(DA_GROUP_GLOBAL, deblank(ChannelNames(i,:)));
end

% Set the data
for i = 1:size(ChannelNames, 1)
    %set(item{i}, 'Field', NewSP(i,:));
    write(item{i}, NewSP(i,:))
end


