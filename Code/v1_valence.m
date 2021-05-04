%Alba Peris-Yague April 28th 2021
%The goal of this script is obtain a list with the words and their valence

clearvars
cd '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Raw_data'

subjects = [4:7 9:12 14:75];

numberofsubjects=size(subjects,2);
recall=zeros(length(subjects),10);

index=0;
arvalrec_R={};

for sub=subjects
    cd '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Raw_data'
    index=index+1;
    sdir=sprintf('sub%d',sub);

    cd(sdir)
 
    [r,words]=xlsread('recout.xls'); %0= not recalled, a number= position of the word recalled
    words(640,1)={NaN};
    words=words(:,1);
    r=r(:,2);   
    r=num2cell(r);
    r(:,1)=cellfun(@num2str,r(:,1),'UniformOutput',false);
    
    if sub==6 %contains empty spaces at the end 
        words=words(1:640,:);
    end 
    
    recall=[words r];
    
    
    %Delete the E and E-1 items of problematic lists
   if sub==7
         recall(568:569,:)=[]; %(list 36) 
   end 
   if sub==46
        recall(552:553,:)=[];%(list 35)
   end 
   if sub==51
        recall(455:456,:)=[];%(list 29)
   end 
   if sub==52
        recall(633:634,:)=[];% (list 40)
   end 
   if sub==63
       recall(24:25,:)=[]; %(list 2)
   end 
   if sub==60
       recall(216:217,:)=[]; % (list 14)
   end
   if sub==64
       recall(551:552,:)=[]; %(list 35)
   end 
   if sub==68
       recall(503:504,:)=[]; % (list 32)
   end  
    if sub==65
        recall(375:376,:)=[]; % (list 24)
    end 
    if sub==43
         recall(568:569,:)=[];%(list 36)
    end 
    
    for i=1:length(recall); %get rid of the accents from the words that have them
        if strcmp(recall(i,1),'violaci�n')
            recall(i,1)={'violacion'};
        end
        if strcmp(recall(i,1), 'c�ncer')
            recall(i,1)={'cancer'};
        end
        if strcmp(recall(i,1),'parapl�gico')
            recall(i,1)={'paraplegico'};
        end 
        if strcmp(recall(i,1),'amputaci�n')
            recall(i,1)={'amputacion'};
        end 
    end 
    
    %Delete all the words that are not the oddballs or E-1 items
    %Ahogado and paraplegico were excluded from the analisis because we do
    %not have values for their valence from the paper. The paper/database
    %chosen was the one that contained most words. 
    i=[];
    item={};
    row=1;
    for i=1:length(recall);
         if strcmp(recall(i,1),'violacion')
             item(row:row+1,1:2)= recall(i-1:i,1:2);
             item(row:row+1,3)={'Em1';'E'};
             row=row+2;
         elseif strcmp(recall(i,1),'nazi')
            item(row:row+1,1:2)=[recall(i-1:i,1:2)];
            item(row:row+1,3)={'Em1';'E'};
            row=row+2;
         elseif strcmp(recall(i,1),'sufrimiento')
             item(row:row+1,1:2)=[recall(i-1:i,1:2)];
             item(row:row+1,3)={'Em1';'E'};
             row=row+2;
         elseif strcmp(recall(i,1),'asesino')
             item(row:row+1,1:2)=[recall(i-1:i,1:2)];
             item(row:row+1,3)={'Em1';'E'};
             row=row+2;
         elseif strcmp(recall(i,1),'asfixia')
             item(row:row+1,1:2)=[recall(i-1:i,1:2)];
             item(row:row+1,3)={'Em1';'E'};
             row=row+2;
         elseif strcmp(recall(i,1),'crimen')
             item(row:row+1,1:2)=[recall(i-1:i,1:2)];
             item(row:row+1,3)={'Em1';'E'};
             row=row+2;
         elseif strcmp(recall(i,1),'cancer')
             item(row:row+1,1:2)=[recall(i-1:i,1:2)];
             item(row:row+1,3)={'Em1';'E'};
             row=row+2;
         elseif strcmp(recall(i,1),'masacre')
             item(row:row+1,1:2)=[recall(i-1:i,1:2)];
             item(row:row+1,3)={'Em1';'E'};
             row=row+2;
         elseif strcmp(recall(i,1),'terrorista')
             item(row:row+1,1:2)=[recall(i-1:i,1:2)];
             item(row:row+1,3)={'Em1';'E'};
             row=row+2;
         elseif strcmp(recall(i,1),'suicida')
             item(row:row+1,1:2)=[recall(i-1:i,1:2)];
             item(row:row+1,3)={'Em1';'E'};
             row=row+2;
         elseif strcmp(recall(i,1),'ceguera')
             item(row:row+1,1:2)=[recall(i-1:i,1:2)];
             item(row:row+1,3)={'Em1';'E'};
             row=row+2;
%          elseif strcmp(recall(i,1),'ahogado')
%              item(row:row+1,1:2)=[recall(i-1:i,1:2)];
%              item(row:row+1,3)={'Em1';'E'};
%              row=row+2;
         elseif strcmp(recall(i,1),'morgue')
             item(row:row+1,1:2)=[recall(i-1:i,1:2)];
             item(row:row+1,3)={'Em1';'E'};
             row=row+2;
         elseif strcmp(recall(i,1),'hambruna')
             item(row:row+1,1:2)=[recall(i-1:i,1:2)];
             item(row:row+1,3)={'Em1';'E'};
             row=row+2;
         elseif strcmp(recall(i,1),'amputacion')
             item(row:row+1,1:2)=[recall(i-1:i,1:2)];
             item(row:row+1,3)={'Em1';'E'};
             row=row+2;
         elseif strcmp(recall(i,1),'sida')
             item(row:row+1,1:2)=[recall(i-1:i,1:2)];
             item(row:row+1,3)={'Em1';'E'};
             row=row+2;
%          elseif strcmp(recall(i,1),'paraplegico')
%              item(row:row+1,1:2)=[recall(i-1:i,1:2)];
%              item(row:row+1,3)={'Em1';'E'};
%              row=row+2;
         elseif strcmp(recall(i,1),'plaga')
             item(row:row+1,1:2)=[recall(i-1:i,1:2)];
             item(row:row+1,3)={'Em1';'E'};
             row=row+2;
         elseif strcmp(recall(i,1),'traidor')
             item(row:row+1,1:2)=[recall(i-1:i,1:2)];
             item(row:row+1,3)={'Em1';'E'};
             row=row+2;
         elseif strcmp(recall(i,1),'tumor')
             item(row:row+1,1:2)=[recall(i-1:i,1:2)];
             item(row:row+1,3)={'Em1';'E'};
             row=row+2;
         end      
    end 
     
    cd '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Valence'
    
    %Get the valence values according to the paper Stadthagen-Gonzalez, Imbault et
    %al 2017
    [values items]=xlsread('valence.xlsx');
    values=num2cell(values);
    values(:,1:6)=cellfun(@num2str,values(:,1:6),'UniformOutput',false);
    valence=[items(1,:); [items(2:21,1) values(:,1:6)]];  
    valence=[valence(:,1:3) valence(:,5:6)];
    
    % Convert recalled items to a 1 and leave forgotten ones with a 0
    
    i=[];
    for i=1:length(item)
        if ~strcmp(item(i,2),'0')
             item(i,2)= {'1'};
        end
    end
    
 % Add the corresponding arousal and valence for each word 
 top={'word' 'recall' 'wordposition' 'valencemean' 'valencesd' 'arousalmean' 'arousalsd'};
 item= [top; [item num2cell(NaN((length(item)),4))]];
 
 i=[];
 for i=1:length(item);
     if strcmp(item(i,1),'violacion')
        item(i,4:7)=valence(2,2:5);
     elseif strcmp(item(i,1),'nazi')
        item(i,4:7)=valence(3,2:5);
     elseif strcmp(item(i,1),'sufrimiento')
        item(i,4:7)=valence(4,2:5);
     elseif strcmp(item(i,1),'asesino')
        item(i,4:7)=valence(5,2:5);
     elseif strcmp(item(i,1),'asfixia')
        item(i,4:7)=valence(6,2:5);
     elseif strcmp(item(i,1),'crimen')
        item(i,4:7)=valence(7,2:5);
     elseif strcmp(item(i,1),'cancer')
        item(i,4:7)=valence(8,2:5);
     elseif strcmp(item(i,1),'masacre')
        item(i,4:7)=valence(9,2:5);
     elseif strcmp(item(i,1),'terrorista')
        item(i,4:7)=valence(10,2:5);
     elseif strcmp(item(i,1),'suicida')
        item(i,4:7)=valence(11,2:5);
     elseif strcmp(item(i,1),'ceguera')
        item(i,4:7)=valence(12,2:5);
     elseif strcmp(item(i,1),'ahogado')
        item(i,4:7)=valence(13,2:5);
     elseif strcmp(item(i,1),'morgue')
        item(i,4:7)=valence(14,2:5);
     elseif strcmp(item(i,1),'hambruna')
        item(i,4:7)=valence(15,2:5);
     elseif strcmp(item(i,1),'amputacion')
        item(i,4:7)=valence(16,2:5);
     elseif strcmp(item(i,1),'sida')
        item(i,4:7)=valence(17,2:5);
     elseif strcmp(item(i,1),'paraplejico')
        item(i,4:7)=valence(18,2:5);
     elseif strcmp(item(i,1),'plaga')
        item(i,4:7)=valence(19,2:5);
     elseif strcmp(item(i,1),'traidor')
        item(i,4:7)=valence(20,2:5);
     elseif strcmp(item(i,1),'tumor')
        item(i,4:7)=valence(21,2:5);
     end
 end 
 
 item=item(2:end,:);
 arvalrec=[num2cell(repmat(sub, length(item),1)) item];
 
 arvalrec_R=[arvalrec_R; arvalrec];

 
   cd ..
end 
header={'subject' 'word' 'recall' 'wordposition' 'valencemean' 'valencesd' 'arousalmean' 'arousalsd'};

arvalrec_R=[header; arvalrec_R];

cd     '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Raw_Results';
writecell (arvalrec_R, 'arvalrec_R.csv');

 %Reorganize data to predict E-1 recall as a function of valence and
 %arousal on E recall
i=[];
row=1;
for i=3:length(arvalrec_R);
    if strcmp(arvalrec_R(i,4),'E')
        Em1_arvalrec(row,:)=[arvalrec_R(i,:) arvalrec_R(i-1,:)];
        row=row+1;
    end
end 

%E-1 (0-1) E(0-1) ValenceMean ArousalMean
Em1_arvalrec_R=[Em1_arvalrec(:,11) Em1_arvalrec(:,3) Em1_arvalrec(:,5) Em1_arvalrec(:,7)];
header={'Em1' 'E' 'valencemean' 'arousalmean'};
Em1_arvalrec_R=[header;Em1_arvalrec_R];

cd     '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Raw_Results';
writecell (Em1_arvalrec_R, 'Em1arvalrec_R.csv');