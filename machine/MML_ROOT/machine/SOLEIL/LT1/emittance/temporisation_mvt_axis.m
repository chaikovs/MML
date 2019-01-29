function err = temporisation_mvt_axis(dev)
err = 0;
disp('temporisation_mvt_axis <-')
while (1)
    %           ms = tango_command_inout(dev,'AxisGetMotionStatus');
    ms = tango_command_inout(dev,'State');
    % si erreur tango : sortir avec diagnostic
    if (tango_error == -1)
      tango_print_error_stack;
      err = -1;
      break;
    end
    % tant que le moteur est resté en butée (errorstatus à 22, 4 21 ou 3) ou qu'il n'a pas démarré
    % (motionstatus à 0) rester dans la boucle
    if strcmp(ms,'MOVING')
        %               if (isequal(ms, 1))
        break;
    end
    disp('temporisation mvt moteur');
    Blimitswitch = tango_read_attribute(dev,'backwardLimitSwitch');
    Flimitswitch = tango_read_attribute(dev,'forwardLimitSwitch');
    
    %           es = tango_command_inout(dev,'AxisGetErrorStatus');
    if (tango_error == -1)
        tango_print_error_stack;
        err = -1;
        break;
    end
%     if ~Blimitswitch.value&~Flimitswitch.value&~strcmp(ms,'STANDBY')
%     %           if ~isequal(es,22)&~isequal(es,4)&~isequal(es,21)&~isequal(es,3)&~isequal(ms,0)
%         disp('probleme')
%        break
%     end
%     if strcmp(ms,'ALARM')|strcmp(ms,'STANDBY')
%     %           if ~isequal(es,22)&~isequal(es,4)&~isequal(es,21)&~isequal(es,3)&~isequal(ms,0)
%         disp('arret normal')
%        break
%     end
    pause(2);
end
disp('temporisation_mvt_axis ->')

