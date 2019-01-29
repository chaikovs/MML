fid = fopen('tls_sr_w200_22p365.resolve','r+');
fid2 = fopen('test.resolve','w');
tline = fgetl(fid);
while ischar(tline)
% disp(tline);
if isempty(strfind(tline,'QUAD'))==0
    Quad = sscanf(tline(1:strfind(tline,':')-1),'%s');
    fprintf(fid2,'%s\n',tline);
    tline = fgetl(fid);
    fprintf(fid2,'%s\n',tline);
    tline = fgetl(fid);
    Str = tline(1:strfind(tline,'='));
    Data = num2str(ConfigSetpoint.(Quad).Setpoint.Data*getbrho*10);
    fprintf(fid2,'%s\n',[Str,'   ',Data(1,:),'     ;']);
    ConfigSetpoint.(Quad).Setpoint.Data(1,:) = [];
elseif isempty(strfind(tline,'BEND'))==0
    Bend = sscanf(tline(1:strfind(tline,':')-1),'%s');
    fprintf(fid2,'%s\n',tline);
    tline = fgetl(fid);
    fprintf(fid2,'%s\n',tline);
    tline = fgetl(fid);
    Str = tline(1:strfind(tline,'='));
    if strfind(Bend,'KICKER')==0
        Data = num2str(ConfigSetpoint.(Bend).Setpoint.Data*getbrho*10);
        fprintf(fid2,'%s\n',[Str,'   ',Data,'     ;']);
    else
        fprintf(fid2,'%s\n',tline);
    end
elseif isempty(strfind(tline,'XCOR'))==0
    Xcor = sscanf(tline(1:strfind(tline,':')-1),'%s');
    fprintf(fid2,'%s\n',tline);
    tline = fgetl(fid);
    Str = tline(1:strfind(tline,'='));
    Data = num2str(ConfigSetpoint.HCM.Setpoint.Data);
    fprintf(fid2,'%s\n',[Str,'   ',Data(1,:),'     ;']);
    ConfigSetpoint.HCM.Setpoint.Data(1,:) = [];
elseif isempty(strfind(tline,'YCOR'))==0
    Ycor = sscanf(tline(1:strfind(tline,':')-1),'%s');
    fprintf(fid2,'%s\n',tline);
    tline = fgetl(fid);
    Str = tline(1:strfind(tline,'='));
    Data = num2str(ConfigSetpoint.VCM.Setpoint.Data);
    fprintf(fid2,'%s\n',[Str,'   ',Data(1,:),'     ;']);
    ConfigSetpoint.VCM.Setpoint.Data(1,:) = [];
else
    fprintf(fid2,'%s\n',tline);
end
tline = fgetl(fid);
end
fclose(fid);
fclose(fid2);