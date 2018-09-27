function AM = getopc(ChannelNames)

global DA_GLOBAL DA_GROUP_GLOBAL

if isempty(DA_GLOBAL)
    tic;
    DA_GLOBAL = opcda('localhost','RSLinx Remote OPC Server');
    connect(DA_GLOBAL);
    fprintf('   Remote OPC Server Initialized (%f seconds)\n', toc);
end

%tic
%if isempty(DA_GROUP_GLOBAL)
    DA_GROUP_GLOBAL = addgroup(DA_GLOBAL);
%else
%    % You might have to flush old data out of the group, I'm not sure ???
%    flushdata(DA_GROUP_GLOBAL);
%end
%fprintf('   Addgroup call took %f seconds\n', toc);


% Que the gets
%tic
for i = 1:size(ChannelNames,1)
    item{i} = additem(DA_GROUP_GLOBAL, deblank(ChannelNames(i,:)));
end
%fprintf('   %d additem calls took %f seconds\n', size(ChannelNames,1), toc);


% Delay (should not be needed)
%pause(.5);


% Get the data
%tic
for i = 1:size(ChannelNames,1)
    tmp = read(item{i});
    AM(i,:) = tmp.Value;
end
%fprintf('   %d reads took %f seconds\n', size(ChannelNames,1), toc);

