%Alba Peris-Yague

%Get all trials lags separated by those where the odd was Remembered vs not
%(controls)

%Column 15=subject, column 16=list number, column 17=type of oddball,
%column 18=SOA, column 19=position oddball

%This script combines the code with functions from the Computational Memory
%Lab which are avaibalable here: http://memory.psych.upenn.edu/Behavioral_toolbox

clearvars
dir= '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Code';
cd(dir)
dir_func='/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/September2020/v1'; %directory where the functions from
%the computational memory lab are.

load emotional_v1_CRP

emotional_v1_CRP(:,1:19)=cellfun(@num2str,emotional_v1_CRP(:,1:19),'UniformOutput',false);
emotional_v1_CRP=str2double(emotional_v1_CRP);

list_length=14;
emotional_subjects=emotional_v1_CRP(:,15);

E_all=emotional_v1_CRP(:,1:14);

cd(dir_func)
E_CRP_all=lag_crp(E_all,emotional_subjects,list_length);
% figure;plot_crp(E_CRP_all)
% title('E_CRP_all')

emotional_v1_CRP=num2cell(emotional_v1_CRP);
emotional_v1_CRP(:,1:19)=cellfun(@num2str,emotional_v1_CRP(:,1:19),'UniformOutput',false);

%find trials where odd Remembered 
for j=1:length(emotional_v1_CRP)
    oddnum=emotional_v1_CRP(j,19);
    if any(strcmp(emotional_v1_CRP(j,1:14),oddnum));
        Remembered_emotional_v1_CRP(j,1:19)=emotional_v1_CRP(j,1:19); %create empty rows when the oddball is not Remembered
    end 
    j=j+1;
end 

%Create matrix with words with Forgotten odd
E_all_odd_forgot=str2double(emotional_v1_CRP(cellfun(@isempty,Remembered_emotional_v1_CRP (:,1)), :));
E_all_odd_rem=str2double(Remembered_emotional_v1_CRP(~cellfun(@isempty,Remembered_emotional_v1_CRP (:,1)), :));

E_all_odd_forgot_CRP=lag_crp(E_all_odd_forgot(:,1:14), E_all_odd_forgot(:,15), list_length);
% figure;plot_crp(E_all_odd_forgot_CRP)
% title('E_all_odd_forgot_CRP')

E_all_odd_rem_CRP=lag_crp(E_all_odd_rem(:,1:14), E_all_odd_rem(:,15), list_length);
% figure;plot_crp(E_all_odd_rem_CRP)
% title('E_all_odd_rem_CRP')

%cd(dir)
%writematrix(E_CRP_all,'E_CRP_all.csv');
%writematrix(E_all_odd_forgot_CRP,'E_CRP_all_forgot.csv');
%writematrix(E_all_odd_rem_CRP,'E_CRP_all_rem.csv');

%Restructure data to R 
E_CRP_all=num2cell(E_CRP_all);
s=num2cell(unique(emotional_subjects));
m5=[s repmat({'E'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) E_CRP_all(:,9)];
m4=[s repmat({'E'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) E_CRP_all(:,10)];
m3=[s repmat({'E'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) E_CRP_all(:,11)];
m2=[s repmat({'E'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) E_CRP_all(:,12)];
m1=[s repmat({'E'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) E_CRP_all(:,13)];

p5=[s repmat({'E'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) E_CRP_all(:,19)];
p4=[s repmat({'E'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) E_CRP_all(:,18)];
p3=[s repmat({'E'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) E_CRP_all(:,17)];
p2=[s repmat({'E'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) E_CRP_all(:,16)];
p1=[s repmat({'E'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) E_CRP_all(:,15)];

all_CRP_E_R=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];
m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

E_all_odd_forgot_CRP=num2cell(E_all_odd_forgot_CRP);
m5=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) E_all_odd_forgot_CRP(:,9)];
m4=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) E_all_odd_forgot_CRP(:,10)];
m3=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) E_all_odd_forgot_CRP(:,11)];
m2=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) E_all_odd_forgot_CRP(:,12)];
m1=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) E_all_odd_forgot_CRP(:,13)];

p5=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) E_all_odd_forgot_CRP(:,19)];
p4=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) E_all_odd_forgot_CRP(:,18)];
p3=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) E_all_odd_forgot_CRP(:,17)];
p2=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) E_all_odd_forgot_CRP(:,16)];
p1=[s repmat({'E'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) E_all_odd_forgot_CRP(:,15)];

forg_E=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];
m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

E_all_odd_rem_CRP=num2cell(E_all_odd_rem_CRP);
m5=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) E_all_odd_rem_CRP(:,9)];
m4=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) E_all_odd_rem_CRP(:,10)];
m3=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) E_all_odd_rem_CRP(:,11)];
m2=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) E_all_odd_rem_CRP(:,12)];
m1=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) E_all_odd_rem_CRP(:,13)];

p5=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) E_all_odd_rem_CRP(:,19)];
p4=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) E_all_odd_rem_CRP(:,18)];
p3=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) E_all_odd_rem_CRP(:,17)];
p2=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) E_all_odd_rem_CRP(:,16)];
p1=[s repmat({'E'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) E_all_odd_rem_CRP(:,15)];

rem_E=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];
m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

rvf_CRP_E_R=[forg_E; rem_E];

%% Run the analysis for transitions to and from emotional oddballs 
clearvars -except all_CRP_E_R rvf_CRP_E_R s
dir= '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Code';
dir_func='/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/September2020/v1'; %Functions are here 
cd(dir)

load emotional_v1_CRP

cd(dir_func)

emotional_v1_CRP(:,1:19)=cellfun(@num2str,emotional_v1_CRP(:,1:19),'UniformOutput',false);

%Delete rows in which the oddball was not Remembered, emotional
for j=1:length(emotional_v1_CRP)
    oddnum=emotional_v1_CRP(j,19);
    if any(strcmp(emotional_v1_CRP(j,1:14),oddnum));
        Remembered_emotional_v1_CRP(j,1:19)=emotional_v1_CRP(j,1:19); %create empty rows when the oddball is not Remembered
    end 
    j=j+1;
end 
 
emotional_v1_CRP=str2double(Remembered_emotional_v1_CRP(~cellfun(@isempty,Remembered_emotional_v1_CRP (:,1)), :));

data=NaN(850,28);

for i=1:length(emotional_v1_CRP);
    oddnum=emotional_v1_CRP(i,19);
position=find(emotional_v1_CRP(i,1:14)==oddnum);
total_row=sum(emotional_v1_CRP(i,1:14)~=0);
data(i,:)=[[NaN(14-position,1)'] [emotional_v1_CRP(i,1:total_row)] [NaN(13-(total_row-position),1)'] emotional_v1_CRP(i,15)];
end 

%new lag
for j=1:length(data)
    odd=data(j,14);
    lag(j,:)=[odd-data(j,(1:13)) data(j,14) odd-data(j,(15:27)) data(j,28)];
end


list_length=14;

all_transitions=[-list_length + 1 : list_length - 1];

%Get averages per subject
lag=sortrows(lag,28);
subj=unique(lag(:,28));
index=0;

for a=1:length(subj); 
    rows=lag(:,28)==subj(a,1);
    lagsubj=lag(rows,1:28); %changed from here down all the lags to lagsubj 
    index=index+1;

actual_transitions=lagsubj(:,13)'; %before
actuals_counts = collect(actual_transitions, all_transitions);

actual_transitions_after=-1*(lagsubj(:,15))'; %changed lag sign 
actual_counts_after=collect(actual_transitions_after, all_transitions);

possible_transitions=lagsubj(:,1:13);
possible_counts=collect(possible_transitions, all_transitions);

possible_transitions_after=-1*(lagsubj(:,15:27)); %changed lag sign 
possible_counts_after=collect(possible_transitions_after,all_transitions);

lag_crp_ap=actuals_counts./possible_counts;
lag_crp_after_ap=actual_counts_after./possible_counts_after;

lag_crp_subj(index,:)=[lag_crp_ap subj(a,1)];
lag_crp_after_subj(index,:)=[lag_crp_after_ap subj(a,1)];

clearvars -except lag_crp_subj lag_crp_after_subj index lag subj all_transitions emotional_v1_CRP trials dir all_CRP_E_R rvf_CRP_E_R s
end

%cd(dir)
%writematrix(lag_crp_subj, 'E_lag_crp_subj_before.csv')
%writematrix(lag_crp_after_subj,'E_lag_crp_subj_after.csv')

m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

lag_crp_subj=num2cell(lag_crp_subj);
m5=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) lag_crp_subj(:,9)];
m4=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) lag_crp_subj(:,10)];
m3=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) lag_crp_subj(:,11)];
m2=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) lag_crp_subj(:,12)];
m1=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) lag_crp_subj(:,13)];

p5=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) lag_crp_subj(:,19)];
p4=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) lag_crp_subj(:,18)];
p3=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) lag_crp_subj(:,17)];
p2=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) lag_crp_subj(:,16)];
p1=[s repmat({'E'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) lag_crp_subj(:,15)];

E_before=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];

m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

lag_crp_after_subj=num2cell(lag_crp_after_subj);
m5=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) lag_crp_after_subj(:,9)];
m4=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) lag_crp_after_subj(:,10)];
m3=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) lag_crp_after_subj(:,11)];
m2=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) lag_crp_after_subj(:,12)];
m1=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) lag_crp_after_subj(:,13)];

p5=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) lag_crp_after_subj(:,19)];
p4=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) lag_crp_after_subj(:,18)];
p3=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) lag_crp_after_subj(:,17)];
p2=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) lag_crp_after_subj(:,16)];
p1=[s repmat({'E'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) lag_crp_after_subj(:,15)];

E_after=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];

E_ToFrom_R=[E_before; E_after];

% figure, plot(mean([lag_crp_subj(:,9:13) NaN(70,1) lag_crp_subj(:,15:19)],'omitnan')); % PLOT SIMMILAR TO THE LAG CRP FUNCTION
% hold
% set(gca,'XTickLabel',{'-5','-4','-3','-2','-1','0','1','2','3','4','5'});
% title('Lag crp before emotional')
% xlabel('lag')
% ylabel('conditional response probability')
% 
% figure, plot(mean([lag_crp_after_subj(:,9:13) NaN(70,1) lag_crp_after_subj(:,15:19)],'omitnan'));
% hold
% set(gca,'XTickLabel',{'-5','-4','-3','-2','-1','0','1','2','3','4','5'});
% title('Lag crp after emotional')
% xlabel('lag')
% ylabel('conditional response probability')


%% Repeat for perceptual oddballs
%Get all trials lags separated by those where the odd was Remembered vs not

clearvars -except E_ToFrom_R s rvf_CRP_E_R all_CRP_E_R

dir= '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Code';
dir_func='/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/September2020/v1'; %functions are here
cd(dir)

load perceptual_v1_CRP

cd(dir_func)

perceptual_v1_CRP(:,1:19)=cellfun(@num2str,perceptual_v1_CRP(:,1:19),'UniformOutput',false);
perceptual_v1_CRP=str2double(perceptual_v1_CRP);

list_length=14;
perceptual_subjects=perceptual_v1_CRP(:,15);
P_all=perceptual_v1_CRP(:,1:14);

P_PFR_all=pfr(P_all, perceptual_subjects, list_length);

P_all=perceptual_v1_CRP(:,1:14);

P_CRP_all=lag_crp(P_all,perceptual_subjects,list_length);
% figure;plot_crp(P_CRP_all)
% title('P_CRP_all')

perceptual_v1_CRP=num2cell(perceptual_v1_CRP);
perceptual_v1_CRP(:,1:19)=cellfun(@num2str,perceptual_v1_CRP(:,1:19),'UniformOutput',false);

%find trials where odd Remembered 
for j=1:length(perceptual_v1_CRP)
    oddnum=perceptual_v1_CRP(j,19);
    if any(strcmp(perceptual_v1_CRP(j,1:14),oddnum));
        Remembered_perceptual_v1_CRP(j,1:19)=perceptual_v1_CRP(j,1:19); %create empty rows when the oddball is not Remembered
    end 
    j=j+1;
end 

%Create matrix with words with Forgotten odd
P_all_odd_forgot=str2double(perceptual_v1_CRP(cellfun(@isempty,Remembered_perceptual_v1_CRP (:,1)), :));
P_all_odd_rem=str2double(perceptual_v1_CRP(~cellfun(@isempty,Remembered_perceptual_v1_CRP (:,1)), :));

P_all_odd_forgot_CRP=lag_crp(P_all_odd_forgot(:,1:14), P_all_odd_forgot(:,15), list_length);
% figure;plot_crp(P_all_odd_forgot_CRP)
% title('P_all_odd_forgot_CRP')

P_all_odd_rem_CRP=lag_crp(P_all_odd_rem(:,1:14), P_all_odd_rem(:,15), list_length);
% figure;plot_crp(P_all_odd_rem_CRP)
% title('P_all_odd_rem_CRP')

% writematrix(P_CRP_all,'P_CRP_all.csv');
% writematrix(P_all_odd_forgot_CRP,'P_CRP_all_forgot.csv');
% writematrix(P_all_odd_rem_CRP,'P_CRP_all_rem.csv');

P_CRP_all=num2cell(P_CRP_all);
m5=[s repmat({'P'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) P_CRP_all(:,9)];
m4=[s repmat({'P'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) P_CRP_all(:,10)];
m3=[s repmat({'P'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) P_CRP_all(:,11)];
m2=[s repmat({'P'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) P_CRP_all(:,12)];
m1=[s repmat({'P'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) P_CRP_all(:,13)];

p5=[s repmat({'P'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) P_CRP_all(:,19)];
p4=[s repmat({'P'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) P_CRP_all(:,18)];
p3=[s repmat({'P'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) P_CRP_all(:,17)];
p2=[s repmat({'P'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) P_CRP_all(:,16)];
p1=[s repmat({'P'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) P_CRP_all(:,15)];

all_CRP_P_R=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];
m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

P_all_odd_forgot_CRP=num2cell(P_all_odd_forgot_CRP);
m5=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) P_all_odd_forgot_CRP(:,9)];
m4=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) P_all_odd_forgot_CRP(:,10)];
m3=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) P_all_odd_forgot_CRP(:,11)];
m2=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) P_all_odd_forgot_CRP(:,12)];
m1=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) P_all_odd_forgot_CRP(:,13)];

p5=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) P_all_odd_forgot_CRP(:,19)];
p4=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) P_all_odd_forgot_CRP(:,18)];
p3=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) P_all_odd_forgot_CRP(:,17)];
p2=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) P_all_odd_forgot_CRP(:,16)];
p1=[s repmat({'P'},70,1) repmat({'Forgotten'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) P_all_odd_forgot_CRP(:,15)];

forg_P=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];
m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

P_all_odd_rem_CRP=num2cell(P_all_odd_rem_CRP);
m5=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) P_all_odd_rem_CRP(:,9)];
m4=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) P_all_odd_rem_CRP(:,10)];
m3=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) P_all_odd_rem_CRP(:,11)];
m2=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) P_all_odd_rem_CRP(:,12)];
m1=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) P_all_odd_rem_CRP(:,13)];

p5=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) P_all_odd_rem_CRP(:,19)];
p4=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) P_all_odd_rem_CRP(:,18)];
p3=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) P_all_odd_rem_CRP(:,17)];
p2=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) P_all_odd_rem_CRP(:,16)];
p1=[s repmat({'P'},70,1) repmat({'Remembered'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) P_all_odd_rem_CRP(:,15)];

rem_P=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];
m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

rvf_CRP_P_R=[forg_P; rem_P];

%% CRP in transitions to and from Perceptual Oddballs 

clearvars -except E_ToFrom_R s rvf_CRP_E_R all_CRP_E_R rvf_CRP_P_R all_CRP_P_R

dir= '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Code';
dir_func='/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/September2020/v1';
cd(dir)

load perceptual_v1_CRP

cd(dir_func)

perceptual_v1_CRP(:,1:19)=cellfun(@num2str,perceptual_v1_CRP(:,1:19),'UniformOutput',false);

%Delete rows in which the oddball was not Remembered, emotional
for j=1:length(perceptual_v1_CRP)
    oddnum=perceptual_v1_CRP(j,19);
    if any(strcmp(perceptual_v1_CRP(j,1:14),oddnum));
        Remembered_perceptual_v1_CRP(j,1:19)=perceptual_v1_CRP(j,1:19); %create empty rows when the oddball is not Remembered
    end 
    j=j+1;
end 

perceptual_v1_CRP=str2double(Remembered_perceptual_v1_CRP(~cellfun(@isempty,Remembered_perceptual_v1_CRP (:,1)), :));

data=NaN(832,28);

for i=1:length(perceptual_v1_CRP);
    oddnum=perceptual_v1_CRP(i,19);
position=find(perceptual_v1_CRP(i,1:14)==oddnum);
total_row=sum(perceptual_v1_CRP(i,1:14)~=0);
data(i,:)=[[NaN(14-position,1)'] [perceptual_v1_CRP(i,1:total_row)] [NaN(13-(total_row-position),1)'] perceptual_v1_CRP(i,15)];
end 

%new lag
for j=1:length(data)
    odd=data(j,14);
    lag(j,:)=[odd-data(j,(1:13)) data(j,14) odd-data(j,(15:27)) data(j,28)];
end


list_length=14;

all_transitions=[-list_length + 1 : list_length - 1];

%Get averages per subject
lag=sortrows(lag,28);
subj=unique(lag(:,28));
index=0;

for a=1:length(subj); 
    rows=lag(:,28)==subj(a,1);
    lagsubj=lag(rows,1:28); %changed from here down all the lags to lagsubj 
    index=index+1;

actual_transitions=lagsubj(:,13)'; %before
actuals_counts = collect(actual_transitions, all_transitions);

actual_transitions_after=-1*(lagsubj(:,15))'; %changed lag sign 
actual_counts_after=collect(actual_transitions_after, all_transitions);

possible_transitions=lagsubj(:,1:13);
possible_counts=collect(possible_transitions, all_transitions);

possible_transitions_after=-1*(lagsubj(:,15:27)); %changed lag sign 
possible_counts_after=collect(possible_transitions_after,all_transitions);

lag_crp_ap=actuals_counts./possible_counts;
lag_crp_after_ap=actual_counts_after./possible_counts_after;

lag_crp_subj(index,:)=[lag_crp_ap subj(a,1)];
lag_crp_after_subj(index,:)=[lag_crp_after_ap subj(a,1)];

clearvars -except lag_crp_subj lag_crp_after_subj index lag subj all_transitions emotional_v1_CRP trials dir E_ToFrom_R s rvf_CRP_E_R all_CRP_E_R rvf_CRP_P_R all_CRP_P_R
end

% cd(dir)
% writematrix(lag_crp_subj, 'P_lag_crp_subj_before.csv')
% writematrix(lag_crp_after_subj,'P_lag_crp_subj_after.csv')

m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

lag_crp_subj=num2cell(lag_crp_subj);
m5=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) lag_crp_subj(:,9)];
m4=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) lag_crp_subj(:,10)];
m3=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) lag_crp_subj(:,11)];
m2=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) lag_crp_subj(:,12)];
m1=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) lag_crp_subj(:,13)];

p5=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) lag_crp_subj(:,19)];
p4=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) lag_crp_subj(:,18)];
p3=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) lag_crp_subj(:,17)];
p2=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) lag_crp_subj(:,16)];
p1=[s repmat({'P'},70,1) repmat({'to'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) lag_crp_subj(:,15)];

P_before=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];

m5=[]; m4=[]; m3=[]; m2=[]; m1=[]; p1=[]; p2=[]; p3=[]; p4=[]; p5=[]; 

lag_crp_after_subj=num2cell(lag_crp_after_subj);
m5=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'5'},70,1) lag_crp_after_subj(:,9)];
m4=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'4'},70,1) lag_crp_after_subj(:,10)];
m3=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'3'},70,1) lag_crp_after_subj(:,11)];
m2=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'2'},70,1) lag_crp_after_subj(:,12)];
m1=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Backwards'},70,1) repmat({'1'},70,1) lag_crp_after_subj(:,13)];

p5=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'5'},70,1) lag_crp_after_subj(:,19)];
p4=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'4'},70,1) lag_crp_after_subj(:,18)];
p3=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'3'},70,1) lag_crp_after_subj(:,17)];
p2=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'2'},70,1) lag_crp_after_subj(:,16)];
p1=[s repmat({'P'},70,1) repmat({'from'},70,1) repmat({'Forwards'},70,1) repmat({'1'},70,1) lag_crp_after_subj(:,15)];

P_after=[m5;m4;m3;m2;m1;p1;p2;p3;p4;p5];

P_ToFrom_R=[P_before; P_after];

%% Concatenate the R outputs
CRP_all_R=array2table([all_CRP_E_R; all_CRP_P_R], 'VariableNames',{'subject', 'oddballtype', 'direction', 'wordposition', 'CRP'});
rvf_CRP_R=array2table([rvf_CRP_E_R; rvf_CRP_P_R], 'VariableNames',{'subject', 'oddballtype', 'recall', 'direction', 'wordposition', 'CRP'});
ToFrom_CRP_R=array2table([E_ToFrom_R; P_ToFrom_R], 'VariableNames',{'subject', 'oddballtype', 'transition', 'direction', 'wordposition', 'CRP'});

cd     '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Raw_Results';
writetable (CRP_all_R, 'CRP_all_R.csv');
writetable(rvf_CRP_R, 'rvf_CRP_R.csv');
writetable(ToFrom_CRP_R, 'ToFrom_CRP_R.csv');

% figure, plot(mean([lag_crp_subj(:,9:13) NaN(87,1) lag_crp_subj(:,15:19)],'omitnan')); % PLOT SIMMILAR TO THE LAG CRP FUNCTION
% hold
% set(gca,'XTickLabel',{'-5','-4','-3','-2','-1','0','1','2','3','4','5'});
% title('Lag crp before emotional')
% xlabel('lag')
% ylabel('conditional response probability')
% 
% figure, plot(mean([lag_crp_after_subj(:,9:13) NaN(87,1) lag_crp_after_subj(:,15:19)],'omitnan'));
% hold
% set(gca,'XTickLabel',{'-5','-4','-3','-2','-1','0','1','2','3','4','5'});
% title('Lag crp after emotional')
% xlabel('lag')
% ylabel('conditional response probability')