function topup
% premier test top up
% prealable :
%          charger table i jection en mode 3/4
%          profondeur table à 1


temp=tango_read_attribute2('ANS-C03/DG/DCCT','current');anscur=temp.value;
maxcur=300;
t=gettime

while (anscur > 1)

    % check ring current
    temp=tango_read_attribute2('ANS-C03/DG/DCCT','current');anscur=temp.value;
    pause(2)
  
    
    if (anscur < maxcur)
        
        t1=gettime;
        laps=t1-t;
        t=t1;
        % booster en mode on
        set_booster_mode('on'); pause(15) % (temps de montée)
        
        
        % initialise les rendements
        temp=tango_read_attribute2('ANS-C03/DG/DCCT','current');anscur0=temp.value;
        q1=0;q2=0;n=0;

        % injection
        tango_command_inout2('ANS/SY/CENTRAL','FireBurstEvent');
        pause(1)
        set_booster_mode('eco')
        pause(5) % durée rafale + pause lecture DCCT
        [q1,q2,n]=getcharge(q1,q2,n);
        

        % Calcul des rendements
        temp=tango_read_attribute2('ANS-C03/DG/DCCT','current');anscur=temp.value;
        dcur=anscur-anscur0;
        if (dcur>0.05) % cas injection OK
            r1=0;if (q1~=0);r1=q2/q1*100;end
            r2=0;if (q2~=0);r2=dcur/q2*0.524*416/184*100;end
            if(r1<0);r1=0;elseif(r1>100);r1=100;end
            if(r2<0);r2=0;elseif(r2>100);r2=100;end
            q1=q1/n;q2=q2/n;dcur=dcur/n;

            % Calcul durée de vie
            [Tau, I0, t5, DCCT, chi2n] = measlifetime_nowrite(30);

            % Print data
            fprintf('Current = %5.2f mA   tau= %5.2f h     Laps== %5.2f s     Rendements=%5.2f %5.2f  \n',anscur,Tau,laps,r1,r2);
            
        end

    end

end


