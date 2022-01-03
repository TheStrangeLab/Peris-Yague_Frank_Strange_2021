%Alba Peris-Yague
%December 29th 2021

clearvars
dir= '/Code';
cd(dir)
load alldata
% column 15= subject
% column 16= list
% column 17= type of oddball
% column 18= SOA
% column 19= oddball position
% column 20= control word position
% column 21= hits per list 

alldata(:,1:21)=cellfun(@num2str,alldata(:,1:21),'UniformOutput',false);

% Create a structure only with the recalled oddballs
for i=1:length(alldata)
    oddpos=str2double(alldata(i,19));
    if ~strcmp(alldata(i,oddpos),'0'); %remove the ~ when calculating the E-1 for forgotten odd
        remembered(i,:)=alldata(i,:);
    end 
end 

%Clean empty cells 
remembered=remembered(~any(cellfun('isempty', remembered), 2), :);
remembered=sortrows(remembered,17);

%separate between emotional and perceptual oddballs
emotional=str2double(remembered(1:850,:));
perceptual=str2double(remembered(851:1682,:));

%Find the position of the emotionall recalled oddball 
for k=1:length(emotional)
    odd=emotional(k,19);
    recall(k,1)=emotional(k,15); %subject
    recall(k,2)=emotional(k,odd); %position of the eodd recalled
    recall(k,3)=emotional(k,odd-1); %position of the e-1 recalled
    recall(k,4)=emotional(k,odd+1); %position of the e+1 recalled
    recall(k,5)=length(nonzeros(emotional(k,1:14))); %total recalled 
    recall(k,6)=emotional(k,18); %add SOA
end 

%Calculate the relative recall position 
cd(dir)
e_relative=recall(:,2)./recall(:,5);
em1_relative=recall(:,3)./recall(:,5);
ep1_relative=recall(:,4)./recall(:,5);

e_relative_recall=[[recall(:,2)./recall(:,5)] [recall(:,3)./recall(:,5)] [recall(:,4)./recall(:,5)] recall(:,6) recall(:,1)];

%E relative recall= E E-1 E+1
E_R=num2cell([e_relative_recall(:,1) e_relative_recall(:,4) e_relative_recall(:,5)]);
E_R=[repmat({'Emotional'},850,1) E_R];

cd(dir)

%% PERCEPTUAL ODDBALLS
clearvars -except perceptual E_R
%Perceptual oddballs
%Find the position of the emotionall recalled oddball 
for k=1:length(perceptual)
    odd=perceptual(k,19);
    recall(k,1)=perceptual(k,15); %added subject
    recall(k,2)=perceptual(k,odd); %position of the eodd recalled
    recall(k,3)=perceptual(k,odd-1); %position of the e-1 recalled
    recall(k,4)=perceptual(k,odd+1); %position of the e+1 recalled
    recall(k,5)=length(nonzeros(perceptual(k,1:14))); %total recalled 
    recall(k,6)=perceptual(k,18); %add SOA 
end 

p_relative=recall(:,2)./recall(:,5);
pm1_relative=recall(:,3)./recall(:,5);
pp1_relative=recall(:,4)./recall(:,5);

p_relative_recall=[[recall(:,2)./recall(:,5)] [recall(:,3)./recall(:,5)] [recall(:,4)./recall(:,5)] recall(:,6) recall(:,1)];
P_R=num2cell([p_relative_recall(:,1) p_relative_recall(:,4) p_relative_recall(:,5)]);
P_R=[repmat({'Perceptual'},832,1) P_R];

RR=[E_R; P_R];
RR=array2table(RR, 'VariableNames',{'oddballtype', 'relativerecall', 'SOA', 'subject'});

cd '/Raw_Results'
%writetable(RR, 'RR.csv')

%%Average to have 1 relative recall value per subject, per SOA, per emotion
clearvars -except RR

RR=table2array(RR);
RR=string(RR);
out=[];

subj_list=unique(RR(:,4)); %Find the subject lists

for i=1:length(subj_list); %For each subject 
    subj=subj_list(i);
    
    subj_select=strcmp(RR(:,4),subj); %Find the data for each subject 
    data=RR(subj_select,:);
    
    for e=1:2;
          em= {'Emotional'; 'Perceptual'}; %Average data for emotional and perceptual items differently 
          em_type=em(e);
          em_select=strcmp(data(:,1),em_type);
          data2=data(em_select,:);
          
    for k=1:5;
        soa_nums=[1, 2, 3, 4, 6]; %Find data for each SOA
        soa_select=num2str(soa_nums(k));
        soa_select2=strcmp(data2(:,3),soa_select);
        data3=data2(soa_select2,:);
        
        data4=str2double(data3);
        mean_val={mean(data4(:,2))};
        
        out=[out; em_type mean_val soa_select subj];
    end 
    end 
end 

RR_average=array2table(out, 'VariableNames',{'oddballtype', 'relativerecall', 'SOA', 'subject'});
%writetable(RR_average, 'RR_average.csv')
