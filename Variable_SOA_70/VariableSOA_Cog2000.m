%this script present 14 words for each list, 40 lists; in between subject are requested to count

clear all
warning('off','MATLAB:dispatcher:InexactMatch'),


num_seq=40; %number of lists (of 14 words)

tpresent=800; %present words for 1 s


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%settings for screen
mode       = 1;        %0: window, 1: full screen, 2: presentation in scanner
resolution = 1;        %1: 640x480, 3: 1024x768 (good for Scanner)
background = [1 1 1];  %[0 0 0]: black, [1 1 1]: white

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
config_display(mode,resolution,background,[0 0 0], 'Helvetica',50, 15);
config_log;
config_keyboard(100,5,'exclusive');
% config_serial(comport, baudrate);
config_results('log.res');
config_mouse

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subj=input('please enter the subject number: ');

% go into that subject's directory
sdir=sprintf('sub%d',subj);
cd(sdir)

%in each subject's directory the words lists are stored as out.txt
stims = textread('out.txt','%s');

%the type of list is stored as 1 = E, 2 = P, and next number gives SOA 1,
%2, 3, 4, 6
load listtype

start_cogent

clearpict(1);
settextstyle('Times',40);
preparestring('¿La primera letra tiene un espacio cerrado?',1,0,100);
if rem(subj,2)
    preparestring('Si        No',1,0,0);
else
    preparestring('No        Si',1,0,0);
end
drawpict(1);
wait(3000)
clearpict(1);
wait(2000)
drawpict(1)

for ns=1:num_seq  %this sets the number of lists
    
    if listtype(ns)<20; isi1=listtype(ns)-10; else isi1=listtype(ns)-20; end
    isi = 200 + 1000*(isi1-1);

    preparestring('Nueva Lista',1,0,100);
    preparestring(num2str(isi1),1,0,-100);
    drawpict(1);
    wait(1000)
    clearpict(1);
    drawpict(1);
    wait(2000)
    for i=(ns-1)*16*2+3:2:(ns-1)*16*2+15*2
        f=str2num(stims{(i-1)});
        if f==0
            settextstyle('Times New Roman',40);
        elseif f==1
            settextstyle('Comic Sans MS',40);
        elseif f==2
            settextstyle('Courier New Italic',40);
        elseif f==3
            settextstyle('Lucida Console',40);
        elseif f==4
            settextstyle('Modern',48);
        elseif f==5
            settextstyle('Impact',40);
        elseif f==6
            settextstyle('Palatino Linotype Bold Italic',40);
        elseif f==7
            settextstyle('Roman',40);
        elseif f==8
            settextstyle('Script',40);
        elseif f==9
            settextstyle('Tahoma',40);
        elseif f==10
            settextstyle('WST_Germ',40);
        elseif f==11
            settextstyle('Palatino Linotype',40);
        elseif f==12
            settextstyle('Arial Black',40);
        elseif f==13
            settextstyle('Arial Italic',40);
        elseif f==14
            settextstyle('Times New Roman Bold Italic',40);
        elseif f==15
            settextstyle('Georgia Italic',40);
        elseif f==16
            settextstyle('Courier New',40);
        elseif f==17
            settextstyle('Lucida Console',40);
        elseif f==18
            settextstyle('Bodoni MT Negrita Cursiva',40);
        elseif f==19
            settextstyle('Broadway',40);
        elseif f==20
            settextstyle('Curlz MT',40);
        end

        clearpict(2);
        preparestring(char(stims(i)),2,0,100);
        drawpict(2);
        % Record time at which word is presented
        tON = time;

        logstring([sprintf('%d',tON),'   ', stims{i}]);
        % Clear all key events
        clearkeys;
        wait(tpresent);
        drawpict(1);
        wait(isi);


        % Read all key events since CLEARKEYS was called
        readkeys;

        % Write key events to log
        logkeys;

        % Check key press and calculate the reaction time
        [ key, t, n ] = getkeydown;
        if n == 0
            % no key press
            response = 0;
            rt = 0;
        elseif n == 1
            % single key press
            response = key(1);
            rt = t(1) - tON;
        else
            % multiple key press
            response = 0;
            rt = 0;
        end

        % Add the key press and reaction time to the results file.
        addresults(response, rt);
    end
    
    preparestring('-',1,0,100);
    drawpict(1);
    wait(1000) %3s baseline prior to number
    clearpict(1);
    clearpict(2);
    preparestring(char(stims((ns-1)*16*2+31)),2,0,100); %number to do serial recall
    drawpict(2)
    wait(1000)
    clearpict(2)
    drawpict(2)
        
    wait(30000); %waits 30 secs for subs to do distractor
    preparestring('Ahora recordar las palabras',1,0,100);
    drawpict(1);
    wait(2000)
    clearpict(1);
    drawpict(1);

    waitkeydown( inf, [37] ); % YOU NEED TO PRESS F1 TO START NEXT LIST
    
end

stop_cogent
cd ..



