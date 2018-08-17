function [best_distance, best_cities, bestind,  worse_distance, worse_cities, worseind] = simulatedannealing(inputdip,inputind, initial_temperature,...
    cooling_rate,threshold,numberofdipolestoswap)
% SIMULATEDANNEALING
% S = SIMULATEDANNEALING(inputdip,initial_temperature,cooling_rate)
% returns the new configuration of cities with an optimal solution for the
% traveling salesman problem for n cities. 
%
%The input arguments are
% inputdip         - The cordinates for n cities are represented as 2
%                       rows and n columns and is passed as an argument for
%                       SIMULATEDANNEALING.
% INITIAL_TEMPERATURE - The initial temperature to start the
%                       simulatedannealing process.
% COOLING_RATE        - Cooling rate for the simulatedannealing process. 
%                       Cooling rate should always be less than one.
% THRESHOLD           - Threshold is the stopping criteria and it is the
%                       acceptable distance for n cities.
% numberofdipolestoswap- Specify the maximum number of pair of cities to
%                       swap. As temperature decreases the number of cities
%                       to be swapped decreases and eventually reaches one
%                       pair of cities.

% Keep the count for number of iterations.
global iterations;

% Set the current temperature to initial temperature.
temperature = initial_temperature;

% This is specific to TSP problem. In this algorithm as the temperature
% decreases the number of pairs of cities to swap reduces. Which means as
% the temperature cools down the search is carried without by gradient
% descent and search is carried out locally.
initial_cities_to_swap = numberofdipolestoswap;

% Initialize the iteration number.
iterations = 1;

% This is a flag used to cool the current temperature after 10 iterations
% irrespective of wether or not the function is minimized. This is my
% receipie and done based on my experience. This is not part of the
% original algorithm.
complete_temperature_iterations = 0;

% This is my objective function, the total distance for the routes.
%inputdip_init = inputdip(randperm(14,8));
[previous_distance previous_orbitrms] = orbit_merit(inputdip);


best_distance = previous_distance;
best_cities = inputdip;
worse_distance = previous_distance;
worse_cities = inputdip;
it_best = 1;
it_worse = 1;
bestind = inputind;%zeros(1,length(inputdip));
worseind = inputind;%zeros(1,length(inputdip));

while iterations <= threshold
    [temp_cities temp_ind] = swapdipoles(inputdip,inputind,numberofdipolestoswap);
    [current_distance current_orbitrms] = orbit_merit(temp_cities);
    diff = abs(current_distance - previous_distance);
%     cod_to_plot(1) =  previous_orbitrms;
%     diff_to_plot(1) =  diff;

    if current_distance < previous_distance
        inputdip = temp_cities;
        inputind = temp_ind;
        if rem(iterations,500) == 0
                plotorb(inputdip);
        end
        if complete_temperature_iterations >= 10
            temperature = cooling_rate*temperature;
            complete_temperature_iterations = 0;
        end
%         numberofdipolestoswap = round(numberofdipolestoswap...
%             *exp(-diff/(iterations*temperature)));
        numberofdipolestoswap = floor(numberofdipolestoswap...
            *exp(-diff/(iterations*temperature)))+1;
        if numberofdipolestoswap == 0
            numberofdipolestoswap = 1;
        end
        previous_distance = current_distance;
        previous_orbitrms = current_orbitrms;
        
        cod_to_plot(iterations) =  previous_orbitrms;
        cost_to_plot(iterations) =  previous_distance;
        diff_to_plot(iterations) =  diff;
        iter_ax = 1:iterations;

        iterations = iterations + 1; %fprintf('First IF %i \n', iterations);
        complete_temperature_iterations = complete_temperature_iterations + 1;
    else
        if rand(1) < exp(-diff/(temperature))
            
            inputdip = temp_cities;
            inputind = temp_ind; %%%% add
            if rem(iterations,500) == 0
                plotorb(inputdip);
            end
%             numberofdipolestoswap = round(numberofdipolestoswap...
%                 *exp(-diff/(iterations*temperature)));
                numberofdipolestoswap = floor(numberofdipolestoswap...
            *exp(-diff/(iterations*temperature)))+1;    
            if numberofdipolestoswap == 0
                numberofdipolestoswap = 1;
            end
            previous_distance = current_distance;
            previous_orbitrms = current_orbitrms;
            complete_temperature_iterations = complete_temperature_iterations + 1;
            
          cod_to_plot(iterations) =  previous_orbitrms;
          diff_to_plot(iterations) =  diff;
          cost_to_plot(iterations) =  previous_distance;
          iter_ax = 1:iterations;  
          
            iterations = iterations + 1; %fprintf('Then ELSE %i \n',iterations);
        end
             
    end
    
    if current_distance < best_distance
        best_distance = current_distance;
        best_cities = temp_cities;
        bestind = temp_ind;
        it_best = iterations-1;
    end
    
    if current_distance >= worse_distance
        worse_distance = current_distance;
        worse_cities = temp_cities;
        worseind = temp_ind;
        it_worse = iterations-1;
    end

% % cod_to_plot = zeros(1,threshold);
% % diff_to_plot = zeros(1,threshold);
% % 
% % cod_to_plot(iterations) =  previous_orbitrms;
% % diff_to_plot(iterations) =  diff;

%COD
% figure(2)
% h1 = subplot(3,1,1);
% set(gca,'FontSize',14)
% plot(iter_ax, 1e3*cod_to_plot,'.-r', 'Markersize',10)
% hold all
% ylabel('Cost Func Wx1000]');
% title('Convergence of SA for the sorting ');
% h1 = subplot(3,1,2);
% set(gca,'FontSize',14)
% plot(iter_ax, 1e3*cost_to_plot,'.-m', 'Markersize',10)
% hold all
% ylabel('COD RMS [mm]');
% h1 = subplot(3,1,3);
% set(gca,'FontSize',14)
% plot(iter_ax, 1e3*diff_to_plot,'.-b', 'Markersize',10)
% hold all
% xlabel('Iteration')
% ylabel('Diff x1000 ]');

% % figure(2)
% % h1 = subplot(3,1,1);
% % set(gca,'FontSize',14)
% % plot(iter_ax, 1e3*cod_to_plot,'.-r', 'Markersize',10)
% % hold all
% % ylabel('COD RMS [mm]');
% % title('Convergence of SA for the sorting ');
% % h1 = subplot(3,1,2);
% % set(gca,'FontSize',14)
% % plot(iter_ax, 1e3*cost_to_plot,'.-m', 'Markersize',10)
% % hold all
% % ylabel('COD max [mm]]');
% % h1 = subplot(3,1,3);
% % set(gca,'FontSize',14)
% % plot(iter_ax, 1e3*diff_to_plot,'.-b', 'Markersize',10)
% % hold all
% % xlabel('Iteration')
% % ylabel('Diff: current - previous [mm]');
   
%clc
if rem(iterations,500) == 0
    fprintf('\t\tIterations = %d\n', iterations-1);
    fprintf('\t\tTemperature = %3.8f\n', temperature);
    fprintf('\t\tIn current temperature for %d times\n', complete_temperature_iterations);
    fprintf('\t\tBest iteration %d times\n', it_best);
    fprintf('\t\tWorse iteration %d times\n', it_worse);
end
    
    
    
end
 %clf
