function ws_reduce(sys)

%open(sys)
warning off

assignin('base','vars',evalin('base','who'));
vars_in=evalin('base','vars');
evalin('base',['save tmpvars']);
nomefile=['ws_' sys '.mat'];

if exist(nomefile,'file'),
    delete(nomefile);
end

try
   sim(sys,0.2); 
catch
   disp('NUN PO MAI FUNZIUNA!')
   delete('tmpvars.mat')
   return
end

evalin('base',['clear']);




h = waitbar(0,'Please wait...');

for i=1:length(vars_in),
    evalin('base',['load tmpvars']);
    evalin('base',['clear ' vars_in{i}]);
    waitbar(i/length(vars_in),h,sprintf('%3.1f%%',i*100/length(vars_in)));
    try
       sim(sys,0); 
       %set_param(sys,'SimulationCommand','Update')
       evalin('base',['save tmpvars']);
        
        
        
    catch
        
       evalin('base',['load tmpvars']);
       if exist(nomefile,'file'),
           evalin('base',['save ' nomefile ' ' vars_in{i} ' -append']);    
       else
           evalin('base',['save ' nomefile ' ' vars_in{i}]);  
       end
       
    end
    
end
delete('tmpvars.mat')
close(h)
warning on