function test_butee_axis(dev,edit_butee_haute,edit_butee_basse)


%dev=device_name.lentille_haute;
                %errorstatus=tango_command_inout(dev,'AxisGetErrorStatus');
Blimitswitch = tango_read_attribute(dev,'backwardLimitSwitch');
Flimitswitch = tango_read_attribute(dev,'forwardLimitSwitch');

% errorstatus=21 d�c�l�ration ou arr�t d� � un limit switch sens +
% errorstatus=3  limitswitch forward
% errorstatus=22 d�c�l�ration ou arr�t d� � un limit switch sens -
% errorstatus=4  limitswitch backward

if (tango_error == -1)
        %- handle error
        tango_print_error_stack;
        return;
        errordlg('erreur tango !','Erreur');

else
        % cas ou l'axe est en butee backward (en haut)
        if isequal(Blimitswitch.value,1)
                %if isequal(errorstatus,22)|isequal(errorstatus,4)
            set(edit_butee_haute,'BackgroundColor','red');
        end
        % cas ou l'axe est en butee forward (en bas)
        if isequal(Flimitswitch.value,1)
                %if isequal(errorstatus,21)|isequal(errorstatus,3)
            set(edit_butee_basse,'BackgroundColor','red');
        end

end         