
function TestDialog()
prompt = {'COURANT DE PS1 [A]:','COURANT DE PS2 [A]:','COURANT DE PS3 [A]:'};
dlg_title = 'HU640';
num_lines = 1;
def = {'600','440','360'};
options.Resize='on';
options.WindowStyle='normal';
options.Interpreter='tex';
answer = inputdlg(prompt,dlg_title,num_lines,def);
PS1=answer(1)
