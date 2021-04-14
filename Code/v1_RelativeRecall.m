%Alba Peris-Yague

clearvars
dir= '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Code';
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
end 

%Calculate the distance between E and E-1 to then correlate them (5.3.21)
%If we do E- E-1 --> a - result will be E --> E-1 (backwards) and a + result
%will be forwards E-1-->E
recalldir=sortrows(recall,3);
recalldir=recalldir(~recalldir(:,3)==0,:);
direction=[recalldir(:,2), [recalldir(:,2)-recalldir(:,3)]];
 figure; scatter(direction(:,1), direction(:,2))
 xlabel('E recall position')
 ylabel('E-1 relative to the E')
 ax = gca;
 ax.XAxisLocation = 'origin';
 ax.YAxisLocation = 'origin';
%Fit a line 
coefficients = polyfit(direction(:,1), direction(:,2), 1);
fitted_y = polyval(coefficients, direction(:,1));
 hold on;
plot(direction(:,1), fitted_y, 'r', 'LineWidth', 3);

%save for R
diremem1=array2table(direction,'VariableNames',{'E', 'E-1'});
cd '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Raw_Results'
writetable(diremem1,'diremem1.csv')
%E and E+1
p1recalldir=sortrows(recall,4);
p1recalldir=p1recalldir(~p1recalldir(:,4)==0,:);
p1direction=[p1recalldir(:,2), [p1recalldir(:,2)-p1recalldir(:,4)]];

figure; scatter(p1direction(:,1), p1direction(:,2))
 xlabel('E recall position')
 ylabel('E+1 relative to the E')
 ax = gca;
 ax.XAxisLocation = 'origin';
 ax.YAxisLocation = 'origin';
%Fit a line 
coefficients = polyfit(p1direction(:,1), p1direction(:,2), 1);
fitted_y = polyval(coefficients, p1direction(:,1));
 hold on;
plot(p1direction(:,1), fitted_y, 'r', 'LineWidth', 3);

cd(dir)
e_relative=recall(:,2)./recall(:,5);
em1_relative=recall(:,3)./recall(:,5);
ep1_relative=recall(:,4)./recall(:,5);

e_relative_recall=[[recall(:,2)./recall(:,5)] [recall(:,3)./recall(:,5)] [recall(:,4)./recall(:,5)]];

%E relative recall= E E-1 E+1
E_R=num2cell(e_relative_recall(:,1));
E_R=[repmat({'Emotional'},850,1) E_R];

%Given the oddball was recalled what was the relative recall position of
%E-1 and E+1? 
%e_relative recall convert the 0 to NaNs, because a 0 means that the word
%was not recalled at all
e_relative_recall(e_relative_recall(:,1:3)==0)=NaN; %Convert the 0 to NaN;

%Now, only include trials in which all three items were recalled E-1, E and
%E+1. 
e_RR_allrecalled=e_relative_recall;
    %Include only trials in which all three items were recalled
e_RR_allrecalled(isnan(e_RR_allrecalled(:,2)), 1:3)=NaN;
e_RR_allrecalled(isnan(e_RR_allrecalled(:,3)), 1:3)=NaN;

%What happens when all three items are recalled and neither E-1 nor E are
%recalled last (i.e RR=1) therefore, giving space to E+1 to be recalled?
e_relative(e_relative(:,1)==1)=NaN; %delete trials in which E was recalled last (1 to NaN)
em1_relative(em1_relative(:,1)==0)=NaN; %delete the trials in which E-1 was forgotten
em1_relative(em1_relative(:,1)==1)=NaN; %delete the trials in which E-1 was recalled last (1 to NaN)
ep1_relative(ep1_relative(:,1)==0)=NaN; %delete the trials in which E+1 was forgotten
e_RR_allrecalled_space= [e_relative em1_relative ep1_relative];
    %Include only trials in which all three items were recalled
e_RR_allrecalled_space(isnan(e_RR_allrecalled_space(:,1)),1:3)=NaN;
e_RR_allrecalled_space(isnan(e_RR_allrecalled_space(:,2)),1:3)=NaN;
e_RR_allrecalled_space(isnan(e_RR_allrecalled_space(:,3)),1:3)=NaN;

%What happens in relative recall positions in trials when the E-1 was
%recalled vs. those that it was not?
%Find where the E-1 is forgotten
e_relative_recall=sortrows(e_relative_recall,2);
em1_forg=e_relative_recall(443:850,1:3); %E, E-1, E+1
em1_rem=e_relative_recall(1:442,1:3);
%Forgotten dataset
em1_forg(em1_forg(:,1:3)==1)=NaN; %delete the trials where E or E+1 was recalled last
%include trials in which E and E+1 were recalled 
em1_forg(isnan(em1_forg(:,1)),1:3)=NaN; 
em1_forg(isnan(em1_forg(:,3)),1:3)=NaN;
%Remembered dataset
em1_rem(em1_rem(:,1:2)==1)=NaN;%Convert to NaN when E and E-1 was recalled last
em1_rem(isnan(em1_rem(:,1)),1:3)=NaN; %Include only trials that all are recalled
em1_rem(isnan(em1_rem(:,2)),1:3)=NaN; %Include only trials that all are recalled
em1_rem(isnan(em1_rem(:,3)),1:3)=NaN; %Include only trials that all are recalled

% Calculate E-1 in remembered trials 

for j=1:length(emotional)
    em1=emotional(j,19)-1; %this is where the e-1 is 
    ec=emotional(j,20);
    em1data(j,1)=(emotional(j,15))';
    em1data(j,2)=(emotional(j,em1))';
    em1data(j,3)=(emotional(j,ec))';
    em1data(j,4)=(emotional(j,18))';
end %ended up with a matrix with subject, E-1, control, SOA

%Get E-1 normalized recall including the first two recalled items 
s= unique(em1data(:,1));
for a=1:length(s)
    subject=s(a);
    rows=em1data(:,1)==subject;
    trial=em1data(rows,:);
    e_final(a,1)=subject;
    e_final(a,2)=length(nonzeros(trial(:,2)))/length(trial(:,2)); %column 2 is E-1
    e_final(a,3)=length(nonzeros(trial(:,3)))/length(trial(:,3)); %column 3 is Control
end 

em1_normalized_rec=[e_final(:,1) [e_final(:,2)-e_final(:,3)]];

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
end 

p_relative=recall(:,2)./recall(:,5);
pm1_relative=recall(:,3)./recall(:,5);
pp1_relative=recall(:,4)./recall(:,5);

p_relative_recall=[[recall(:,2)./recall(:,5)] [recall(:,3)./recall(:,5)] [recall(:,4)./recall(:,5)]];
P_R=num2cell(p_relative_recall(:,1));
P_R=[repmat({'Perceptual'},832,1) P_R];

%Given the oddball was recalled what was the relative recall position of
%P-1 and P+1?
%p_relative recall convert the 0 to NaNs, because a 0 means that the word
%was not recalled at all
p_relative_recall(p_relative_recall(:,1:3)==0)=NaN; %Convert the 0 to NaN;

%Now, only include trials in which all three items were recalled P-1, P and
%P+1. 
p_RR_allrecalled=p_relative_recall;
    %Include only trials in which all three items were recalled
p_RR_allrecalled(isnan(p_RR_allrecalled(:,2)), 1:3)=NaN;
p_RR_allrecalled(isnan(p_RR_allrecalled(:,3)), 1:3)=NaN;

%What happens when all three items are recalled and neither E-1 nor E are
%recalled last (i.e RR=1) therefore, giving space to E+1 to be recalled?
p_relative(p_relative(:,1)==1)=NaN; %delete trials in which E was recalled last (1 to NaN)
pm1_relative(pm1_relative(:,1)==0)=NaN; %delete the trials in which E-1 was forgotten
pm1_relative(pm1_relative(:,1)==1)=NaN; %delete the trials in which E-1 was recalled last (1 to NaN)
pp1_relative(pp1_relative(:,1)==0)=NaN; %delete the trials in which E+1 was forgotten
p_RR_allrecalled_space= [p_relative pm1_relative pp1_relative];
    %Include only trials in which all three items were recalled
p_RR_allrecalled_space(isnan(p_RR_allrecalled_space(:,1)),1:3)=NaN;
p_RR_allrecalled_space(isnan(p_RR_allrecalled_space(:,2)),1:3)=NaN;
p_RR_allrecalled_space(isnan(p_RR_allrecalled_space(:,3)),1:3)=NaN;

%What happens in relative recall positions in trials when the P-1 was
%recalled vs. those that it was not?
%Find where the P-1 is forgotten
p_relative_recall=sortrows(p_relative_recall,2);
pm1_forg=p_relative_recall(443:832,1:3); %P, P-1, P+1
pm1_rem=p_relative_recall(1:442,1:3);
%Forgotten dataset
pm1_forg(pm1_forg(:,1:3)==1)=NaN; %delete the trials where E or E+1 was recalled last
%include trials in which E and E+1 were recalled 
pm1_forg(isnan(pm1_forg(:,1)),1:3)=NaN; 
pm1_forg(isnan(pm1_forg(:,3)),1:3)=NaN;
%Remembered dataset
pm1_rem(pm1_rem(:,1:2)==1)=NaN;%Convert to NaN when E and E-1 was recalled last
pm1_rem(isnan(pm1_rem(:,1)),1:3)=NaN; %Include only trials that all are recalled
pm1_rem(isnan(pm1_rem(:,2)),1:3)=NaN; %Include only trials that all are recalled
pm1_rem(isnan(pm1_rem(:,3)),1:3)=NaN; %Include only trials that all are recalled

RR=[E_R; P_R];
RR=array2table(RR, 'VariableNames',{'oddballtype', 'relativerecall'});

cd '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Raw_Results'
writetable(RR, 'RR.csv')
