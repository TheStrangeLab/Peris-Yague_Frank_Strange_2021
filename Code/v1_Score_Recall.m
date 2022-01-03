%Bryan Strange and Alba Peris-Yague 

%The goal of this script is to calculate the total amount of recalled
%words. 

clearvars
cd '/Raw_data'

subjects = [4:7 9:12 14:75];

numberofsubjects=size(subjects,2);
recall=zeros(length(subjects),10);

index=0;

for sub=subjects
    index=index+1;
    sdir=sprintf('sub%d',sub);

    cd(sdir)


    load pop
    load cpp
    load listtype
    
    emotion_index = find(listtype<20); %find emotional lists
    percept_index = find(listtype>20); %find perceptual lists
       
    eop=pop(emotion_index); %eop number in each list where the emotional odd is 
    cep=cpp(emotion_index); % '' '' with control word
    pop=pop(percept_index); %pop number in each list where the perceptual odd is 
    cpp=cpp(percept_index); % '' '' with control word
    
    [r,words]=xlsread('recout.xls'); %0= not recalled, a number= position of the word recalled
    r=r(:,2);

    rec=[];
    for i=1:40 %it selects from 'r' the corresponding words for each list. Gets rid of the 'nueva lista' and blank cell in between lists.   
        rec=[rec; r((i-1)*16+2:(i-1)*16+15)];
    end
    
    e=[];
    for i=1:20 %emotional oddball in rec list 
        e=[e 14*(emotion_index(i)-1)+eop(i)]; 
    end
    
    % Delete the subject lists that have mistakes in the raw data in emotional lists. 
   if sub==7
         e(:,[19])=[]; %column 19(list 36) 
   end 
   if sub==46
       e(:,[18])=[]; %column 18(list 35)
   end 
   if sub==51
       e(:,[15])=[]; %column 15 (list 29)
   end 
   if sub==52
       e(:,[20])=[]; %column 20 (list 40)
   end 
   if sub==63
       e(:,[2])=[]; %column 2(list 2)
   end 
   if sub==60
       e(:,[7])=[]; %column 7 (list 14)
   end
   if sub==64
       e(:,[16])=[]; %column 16 (list 35)
   end 
   if sub==68
       e(:,[16])=[]; %column 16 (list 32)
   end  
    if sub==65
        e(:,[9])=[]; %column 9 (list 18) 
        %e(:,[13])=[]; %column 13 (list 24)- 329
        e(:,[12])=[]; %column 12 (list 24) because I deleted a previous list this shifted -1
    end 
    if sub==43
        e(:,[12])=[]; %column 12 (list 36)
    end 
    bbe=e-2; %before before emotional (E-2)
    be=e-1; %before emotional (E-1)
    ae=e+1; %after emotional  (E+1)

    p=[];%perceptual oddball in rec list 
    for i=1:20
        p=[p 14*(percept_index(i)-1)+pop(i)]; 
    end
    
    if sub==9
        p(:,[17])=[]; %column 17 (list 32)
    end 
    if sub==16
         p(:,[2])=[]; %column 2 (list 7)
    end 
     if sub==25
         p(:,[13])=[]; %column 13 (list 27)
     end 
     if sub==71
         p(:,[13])=[]; %column 13 (list 22)
     end 
     if sub==33
         p(:,[2])=[]; %column 2 (list 3)
     end 
    if sub==44
         p(:,[1])=[]; %column 1 (list 3)
     end 
    
             
    bbp=p-2; %before before perceptual (P-2)
    bp=p-1; %before perceptual (P-2)
    ap=p+1; %after perceptual(P+1)

    ce=[];
    for i=1:20
        ce=[ce 14*(emotion_index(i)-1)+cep(i)];
    end
    % Delete the lists that had a problem in the raw data
   if sub==7
         ce(:,[19])=[]; %column 19(list 36) 
   end 
   if sub==46
       ce(:,[18])=[]; %column 18(list 35)
   end 
   if sub==51
       ce(:,[15])=[]; %column 15 (list 29)
   end 
   if sub==52
       ce(:,[20])=[]; %column 20 (list 40)
   end 
   if sub==63
       ce(:,[2])=[]; %column 2(list 2)
   end
    if sub==60
       ce(:,[7])=[]; %column 7 (list 14)
   end
   if sub==64
       ce(:,[16])=[]; %column 16 (list 35)
   end 
   if sub==68
       ce(:,[16])=[]; %column 16 (list 32)
   end 
    if sub==65
        ce(:,[9])=[]; %column 9 (list 18) 
        %ce(:,[13])=[]; %column 13 (list 24)- 329
        ce(:,[12])=[]; %column 12 (list 24) because I deleted a previous list this shifted -1
    end 
    if sub==43
        ce(:,[12])=[]; %column 12 (list 36)
    end 

    cp=[];
    for i=1:20
        cp=[cp 14*(percept_index(i)-1)+cpp(i)];
    end
    
    %Delete the lists that had a problem in the raw data
     if sub==9
        cp(:,[17])=[]; %column 17 (list 32)
     end 
    if sub==16
         cp(:,[2])=[]; %column 2 (list 7)
    end 
     if sub==25
         cp(:,[13])=[]; %column 13 (list 27)
     end 
     if sub==71
         cp(:,[13])=[]; %column 13 (list 22)
     end 
     if sub==33
         cp(:,[2])=[]; %column 2 (list 3)
     end  
     if sub==44
         cp(:,[1])=[]; %column 1 (list 3)
     end 
    
    eo=length(find(rec(e))); %finds how many emotional oddballs are recalled
    po=length(find(rec(p))); %finds how many perceptual oddballs are recalled
    bbeo=length(find(rec(bbe))); %finds how many E-2 words are recalled
    bbpo=length(find(rec(bbp)));%finds how many P-2 words are recalled
    beo=length(find(rec(be)));%finds how many E-1 words are recalled
    bpo=length(find(rec(bp)));%finds how many P-1 words are recalled
    aeo=length(find(rec(ae)));%finds how many E+1 words are recalled
    apo=length(find(rec(ap)));%finds how many P+1 words are recalled

    ceo=length(find(rec(ce)));%finds how many control words from the emotional oddball lists are recalled
    cpo=length(find(rec(cp)));%finds how many control words from the perceptual oddball lists are recalled


    recall(index,:) = [bbeo/length(bbe) beo/length(be) eo/length(e) aeo/length(ae) bbpo/length(bbp) bpo/length(bp) po/length(p) apo/length(ap) ceo/length(ce) cpo/length(cp)];

%get variables 
E_2=bbeo/length(bbe);
E_1=beo/length(be); 
Emo=eo/length(e); 
A_E=aeo/length(ae);
P_2=bbpo/length(bbp);
P_1=bpo/length(bp);
Per=po/length(p);
A_P=apo/length(ap);
C_E=ceo/length(ce);
C_P=cpo/length(cp);

final_recall(index,1:11)=[sub E_2 E_1 Emo A_E P_2 P_1 Per A_P C_E C_P];
%Normalize recalls table
normalized_recall(index,1:9)=[sub (E_2-C_E) (E_1-C_E) (Emo-C_E) (A_E-C_E) (P_2-C_P) (P_1-C_P) (Per-C_P) (A_P-C_P)];
    
    cd ..
    end
 

final_recall=array2table(final_recall, 'VariableNames',{'Subject', 'E-2', 'E-1',...
    'E', 'E+1', 'P-2', 'P-1', 'P', 'P+1', 'Control_Emotional', 'Control_Perceptual'});
cd '/Raw_Results';
writetable(final_recall, 'v1final_recall_AP.csv');

norm_rec=normalized_recall(:,2:9); %for plotting later on 
normalized_recall=array2table(normalized_recall, 'VariableNames',{'Subject','E-2', 'E-1',...
    'E', 'E+1', 'P-2', 'P-1', 'P', 'P+1'});

cd '/Raw_Results'
writetable(normalized_recall, 'v1normalized_final_recall_AP_Jan2021.csv');

%% Reorganize csv for R analysis
clearvars -except normalized_recall
recall=table2cell(normalized_recall);
% subject, oddball type, word position, normalized recall 
Em2=[recall(:,1) repmat({'E'},70,1) repmat({'m2'},70,1) recall(:,2)]; 
Em1=[recall(:,1) repmat({'E'},70,1) repmat({'m1'},70,1) recall(:,3)];
E=[recall(:,1) repmat({'E'},70,1) repmat({'odd'},70,1) recall(:,4)];
Ep1=[recall(:,1) repmat({'E'},70,1) repmat({'p1'},70,1) recall(:,5)];
Pm2=[recall(:,1) repmat({'P'},70,1) repmat({'m2'},70,1) recall(:,6)];
Pm1=[recall(:,1) repmat({'P'},70,1) repmat({'m1'},70,1) recall(:,7)];
P=[recall(:,1) repmat({'P'},70,1) repmat({'odd'},70,1) recall(:,8)];
Pp1=[recall(:,1) repmat({'P'},70,1) repmat({'p1'},70,1) recall(:,9)];

normrec=[Em2;Em1;E;Ep1;Pm2;Pm1;P;Pp1];
normrec=cell2table(normrec,'VariableNames',{'subject', 'oddballtype', 'wordposition', 'normrec'});
cd '/Raw_Results';
writetable (normrec, 'normrec_R.csv');

