%Alba Peris-Yague September 16 2020
%The goal of this script is to calculate the total amount of recalled
%words. 

clearvars
dir=     '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Raw_data';
cd(dir)

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
    %% !! THE SOA number needs to be changed here 
    SOA=4;
   
    emotion_index = find((rem(listtype,10)==SOA&listtype<20)); %find emotional lists
    percept_index = find((rem(listtype,10)==SOA&listtype>20)); %find perceptual lists
    
       
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
    for i=1:length(emotion_index) %emotional oddball in rec list 
        e=[e 14*(emotion_index(i)-1)+eop(i)]; 
    end
    
    % Delete the subject lists that have mistakes in the raw data in emotional lists. 
   if sub==7 && SOA==3%SOA3 
         e(:,[4])=[]; 
   end 
   if sub==46 && SOA==3%SOA3
       e(:,[4])=[]; 
   end 
    if sub==51 && SOA==4%SOA4
        e(:,[4])=[]; %column 15 (list 29)
    end 
    if sub==52 && SOA==3%SOA 3
        e(:,[4])=[]; %column 20 (list 40)
    end 
    if sub==63 && SOA==2%SOA 2
        e(:,[1])=[]; %column 2(list 2)
    end 
    if sub==60 && SOA==2 %SOA2
        e(:,[3])=[]; %column 3 (list 14)
    end 
    if sub==65 && SOA==3
        e(:,[3])=[]; %column 3 (list 24)
    end 
    if sub==43 && SOA==6
        e(:,[3])=[]; %column 3 (list 26)
    end 
   
    bbe=e-2; %before before emotional (E-2)
    be=e-1; %before emotional (E-1)
    ae=e+1; %after emotional  (E+1)

    p=[];%perceptual oddball in rec list 
    for i=1:length(percept_index)
        p=[p 14*(percept_index(i)-1)+pop(i)]; 
    end
    
     if sub==9 && SOA==3 %SOA 3
         p(:,[3])=[]; %column 17 (list 32)
     end 
     if sub==16 && SOA==4 %SOA 4
          p(:,[4])=[]; %column 2 (list 7)
     end 
      if sub==25 && SOA==3%SOA 3
          p(:,[4])=[]; %column 13 (list 27)
      end 
      if sub==71 && SOA==6%SOA 6
          p(:,[2])=[]; %column 13 (list 22)
      end 
      if sub==33 && SOA==2 %SOA 2
          p(:,[1])=[]; %column 2 (list 3)
      end 
      if sub==44 && SOA==2 %SOA 2
          p(:,[1])=[]; %column 1 (list 3)
      end 
     
         
    bbp=p-2; %before before perceptual (P-2)
    bp=p-1; %before perceptual (P-2)
    ap=p+1; %after perceptual(P+1)

    ce=[];
    for i=1:length(emotion_index)
        ce=[ce 14*(emotion_index(i)-1)+cep(i)];
    end
    % Delete the lists that had a problem in the raw data
   if sub==7 && SOA==3%SOA 3
         ce(:,[4])=[]; 
   end 
    if sub==46 && SOA==3%SOA3
        ce(:,[4])=[]; %column 18(list 35)
    end 
   if sub==51 && SOA==4%SOA 4
        ce(:,[4])=[]; %column 15 (list 29)
    end 
    if sub==52 && SOA==3%SOA 3
        ce(:,[4])=[]; %column 20 (list 40)
    end 
     if sub==63 && SOA==2 %SOA 2
         ce(:,[1])=[]; %column 2(list 2)
     end
    if sub==60 && SOA==2 %SOA2
        ce(:,[3])=[]; %column 3 (list 14)
    end 
    if sub==65 && SOA==3
        ce(:,[3])=[]; %column 3 (list 24)
    end 
    if sub==43 && SOA==6
        ce(:,[3])=[]; %column 3 (list 26)
    end 

    cp=[];
    for i=1:length(percept_index)
        cp=[cp 14*(percept_index(i)-1)+cpp(i)];
    end
    
    %Delete the lists that had a problem in the raw data
      if sub==9 && SOA==3%SOA3
         cp(:,[3])=[]; 
      end 
     if sub==16 && SOA==4%SOA 4
          cp(:,[3])=[]; %column 2 (list 7)
     end 
      if sub==25 && SOA==3%SOA 3
          cp(:,[3])=[]; %column 13 (list 27)
      end 
      if sub==71 && SOA==6%SOA 6
          cp(:,[2])=[]; %column 13 (list 22)
      end 
      if sub==33 && SOA==2%SOA 2
          cp(:,[1])=[]; %column 2 (list 3)
      end  
       if sub==44 && SOA==2 %SOA 2
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
 
    
%For SOA 4 recall is really bad. Check whether this is due to control
%nouns being really well remembered. 

soa4_control=mean(final_recall(:,11))
soa4_odd=mean(final_recall(:,8))

%  final_recall=array2table(final_recall, 'VariableNames',{'Subject', 'E-2', 'E-1',...
%      'E', 'E+1', 'P-2', 'P-1', 'P', 'P+1', 'Control_Emotional', 'Control_Perceptual'});
%  cd     '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/OddballTask_code/Results';
%  writetable(final_recall, 'SOA6_v1final_recall_AP_Sept2020.xls');

norm_rec=normalized_recall(:,2:9); %for plotting later on 
normalized_recall=array2table(normalized_recall, 'VariableNames',{'Subject','E-2', 'E-1',...
     'E', 'E+1', 'P-2', 'P-1', 'P', 'P+1'});
cd         '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Raw_Results'

%writetable(normalized_recall,sprintf('SOA%d_v1normalized_final_recall_AP_Jan21.csv',SOA));

%For R, manually change the SOA!!
recall=table2cell(normalized_recall);
Em2=[recall(:,1) repmat({'E'},70,1) repmat({'m2'},70,1) repmat({sprintf('%d',SOA)},70,1) recall(:,2)]; 
Em1=[recall(:,1) repmat({'E'},70,1) repmat({'m1'},70,1) repmat({sprintf('%d',SOA)},70,1) recall(:,3)]; 
E=[recall(:,1) repmat({'E'},70,1) repmat({'odd'},70,1) repmat({sprintf('%d',SOA)},70,1) recall(:,4)]; 
Ep1=[recall(:,1) repmat({'E'},70,1) repmat({'p1'},70,1) repmat({sprintf('%d',SOA)},70,1) recall(:,5)]; 
Pm2=[recall(:,1) repmat({'P'},70,1) repmat({'m2'},70,1) repmat({sprintf('%d',SOA)},70,1) recall(:,6)];
Pm1=[recall(:,1) repmat({'P'},70,1) repmat({'m1'},70,1) repmat({sprintf('%d',SOA)},70,1) recall(:,7)];
P=[recall(:,1) repmat({'P'},70,1) repmat({'odd'},70,1) repmat({sprintf('%d',SOA)},70,1) recall(:,8)]; 
Pp1=[recall(:,1) repmat({'P'},70,1) repmat({'p1'},70,1) repmat({sprintf('%d',SOA)},70,1) recall(:,9)]; 

normrec=[Em2;Em1;E;Ep1;Pm2;Pm1;P;Pp1];
normrec=cell2table(normrec,'VariableNames',{'subject', 'oddballtype', 'wordposition', 'SOA', 'normrec'});
cd     '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Raw_Results'

writetable (normrec, sprintf('normrec_SOA6_R.csv',SOA));

%% Uncomment this to get data for R
clearvars
SOA1=readtable('/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/OddballTask_code/Results/normrec_SOA1_R.csv');
SOA2=readtable('/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/OddballTask_code/Results/normrec_SOA2_R.csv');
SOA3=readtable('/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/OddballTask_code/Results/normrec_SOA3_R.csv');
SOA4=readtable('/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/OddballTask_code/Results/normrec_SOA4_R.csv');
SOA6=readtable('/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/OddballTask_code/Results/normrec_SOA6_R.csv');

normrec_SOA_R=[SOA1; SOA2; SOA3; SOA4; SOA6];
cd     '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Raw_Results'

writetable (normrec_SOA_R, 'normrec_SOA_R.csv');

% cd '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/September2020/v1/v1_figures';
% %Plot the final recall in percentage
% figure, bar(mean(recall))
% hold
% errorbar(mean(recall),std(recall)/sqrt(numberofsubjects), 'Linestyle','none','Color','k');
% title('SOA6 Memory scores for word position')
% xlabel('word position')
% set(gca,'XTick',[1:10])
% set(gca,'XTickLabel',{'E-2','E-1','E','E+1','P-2','P-1','P','P+1','ConE','ConP'})
% ylabel('Recall')
%  saveas(gcf, 'SOA6_v1_Fig1_FinalRecall.png');
% % 
% % %Plot the normalized recall 
% figure, bar(mean(norm_rec))
% hold 
% errorbar(mean(norm_rec), std(norm_rec)/sqrt(numberofsubjects), 'Linestyle','none','Color','k');
% title('SOA6 Memory scores for word position normalized (- control)')
% xlabel('word position')
% set(gca,'XTick',[1:8])
% set(gca,'XTickLabel',{'E-2','E-1','E','E+1','P-2','P-1','P','P+1'})
% ylabel('Normalized recall')
%  saveas(gcf, 'SOA6_v1_Fig2_FinalRecallNormalized.png');

%% CALCULATE HOW MANY ITEMS ARE RECALLED PER LIST PER SOA 
clearvars
cd '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Code'

load alldata.mat

% Columns 1:14 are recalled items, column 18 is SOA

data=[alldata(:,1:14) alldata(:,18)];
data(:,1:15)=cellfun(@num2str,data(:,1:15),'UniformOutput',false);

recall=double(~strcmp(data(:,1:14),'0'));
recall=[recall str2double(data(:,15))];

for i=1:length(recall);
    total=sum(recall(i,1:14));
    totalrec(i,1)=total;
end 

totalrec=[totalrec str2double(data(:,15))];
totalrec=array2table(totalrec,'VariableNames',{'total_recall_list', 'SOA'});

cd '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Raw_Results'

writetable (totalrec,'list_recall_SOA_R.csv');