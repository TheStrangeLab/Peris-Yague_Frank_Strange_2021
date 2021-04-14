% Alba Peris-Yague script to calculate the probability of first recall 

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

s=num2cell(unique(emotional_subjects));

cd(dir_func)
E_PFR_all=pfr(E_all,emotional_subjects,list_length); %calculate the PFR in all 
E_PFR_all=num2cell(E_PFR_all);

c1=[s repmat({'Emotional'},70,1) repmat({'all'},70,1) repmat({'1'},70,1) E_PFR_all(:,1)];
c2=[s repmat({'Emotional'},70,1) repmat({'all'},70,1) repmat({'2'},70,1) E_PFR_all(:,2)];
c3=[s repmat({'Emotional'},70,1) repmat({'all'},70,1) repmat({'3'},70,1) E_PFR_all(:,3)];
c4=[s repmat({'Emotional'},70,1) repmat({'all'},70,1) repmat({'4'},70,1) E_PFR_all(:,4)];
c5=[s repmat({'Emotional'},70,1) repmat({'all'},70,1) repmat({'5'},70,1) E_PFR_all(:,5)];
c6=[s repmat({'Emotional'},70,1) repmat({'all'},70,1) repmat({'6'},70,1) E_PFR_all(:,6)];
c7=[s repmat({'Emotional'},70,1) repmat({'all'},70,1) repmat({'7'},70,1) E_PFR_all(:,7)];
c8=[s repmat({'Emotional'},70,1) repmat({'all'},70,1) repmat({'8'},70,1) E_PFR_all(:,8)];
c9=[s repmat({'Emotional'},70,1) repmat({'all'},70,1) repmat({'9'},70,1) E_PFR_all(:,9)];
c10=[s repmat({'Emotional'},70,1) repmat({'all'},70,1) repmat({'10'},70,1) E_PFR_all(:,10)];
c11=[s repmat({'Emotional'},70,1) repmat({'all'},70,1) repmat({'11'},70,1) E_PFR_all(:,11)];
c12=[s repmat({'Emotional'},70,1) repmat({'all'},70,1) repmat({'12'},70,1) E_PFR_all(:,12)];
c13=[s repmat({'Emotional'},70,1) repmat({'all'},70,1) repmat({'13'},70,1) E_PFR_all(:,13)];
c14=[s repmat({'Emotional'},70,1) repmat({'all'},70,1) repmat({'14'},70,1) E_PFR_all(:,14)];

PFR_E_ALL_R=[c1; c2; c3; c4; c5; c6; c7; c8; c9; c10; c11; c12; c13; c14];
c1=[]; c2=[]; c3=[]; c4=[]; c5=[]; c6=[]; c7=[]; c8=[]; c9=[]; c10=[]; c11=[]; c12=[]; c13=[]; c14=[];

emotional_v1_CRP=num2cell(emotional_v1_CRP);
emotional_v1_CRP(:,1:19)=cellfun(@num2str,emotional_v1_CRP(:,1:19),'UniformOutput',false);

%find trials where odd remembered 
for j=1:length(emotional_v1_CRP)
    oddnum=emotional_v1_CRP(j,19);
    if any(strcmp(emotional_v1_CRP(j,1:14),oddnum));
        remembered_emotional_v1_CRP(j,1:19)=emotional_v1_CRP(j,1:19); %create empty rows when the oddball is not remembered
    end 
    j=j+1;
end 

%PFR recalled oddballs
E_all_odd_rem=str2double(remembered_emotional_v1_CRP(~cellfun(@isempty,remembered_emotional_v1_CRP (:,1)), :));

E_PFR_REM=pfr(E_all_odd_rem(:,1:14), E_all_odd_rem(:,15), list_length);
E_PFR_REM=num2cell(E_PFR_REM);

c1=[s repmat({'Emotional'},70,1) repmat({'remembered'},70,1) repmat({'1'},70,1) E_PFR_REM(:,1)];
c2=[s repmat({'Emotional'},70,1) repmat({'remembered'},70,1) repmat({'2'},70,1) E_PFR_REM(:,2)];
c3=[s repmat({'Emotional'},70,1) repmat({'remembered'},70,1) repmat({'3'},70,1) E_PFR_REM(:,3)];
c4=[s repmat({'Emotional'},70,1) repmat({'remembered'},70,1) repmat({'4'},70,1) E_PFR_REM(:,4)];
c5=[s repmat({'Emotional'},70,1) repmat({'remembered'},70,1) repmat({'5'},70,1) E_PFR_REM(:,5)];
c6=[s repmat({'Emotional'},70,1) repmat({'remembered'},70,1) repmat({'6'},70,1) E_PFR_REM(:,6)];
c7=[s repmat({'Emotional'},70,1) repmat({'remembered'},70,1) repmat({'7'},70,1) E_PFR_REM(:,7)];
c8=[s repmat({'Emotional'},70,1) repmat({'remembered'},70,1) repmat({'8'},70,1) E_PFR_REM(:,8)];
c9=[s repmat({'Emotional'},70,1) repmat({'remembered'},70,1) repmat({'9'},70,1) E_PFR_REM(:,9)];
c10=[s repmat({'Emotional'},70,1) repmat({'remembered'},70,1) repmat({'10'},70,1) E_PFR_REM(:,10)];
c11=[s repmat({'Emotional'},70,1) repmat({'remembered'},70,1) repmat({'11'},70,1) E_PFR_REM(:,11)];
c12=[s repmat({'Emotional'},70,1) repmat({'remembered'},70,1) repmat({'12'},70,1) E_PFR_REM(:,12)];
c13=[s repmat({'Emotional'},70,1) repmat({'remembered'},70,1) repmat({'13'},70,1) E_PFR_REM(:,13)];
c14=[s repmat({'Emotional'},70,1) repmat({'remembered'},70,1) repmat({'14'},70,1) E_PFR_REM(:,14)];

PFR_E_REM_R=[c1; c2; c3; c4; c5; c6; c7; c8; c9; c10; c11; c12; c13; c14];
c1=[]; c2=[]; c3=[]; c4=[]; c5=[]; c6=[]; c7=[]; c8=[]; c9=[]; c10=[]; c11=[]; c12=[]; c13=[]; c14=[];

% Forgotten oddballs
j=[]; oddnum=[]; 
for j=1:length(emotional_v1_CRP)
    oddnum=emotional_v1_CRP(j,19);
    if ~any(strcmp(emotional_v1_CRP(j,1:14),oddnum));
        forgotten_emotional_v1_CRP(j,1:19)=emotional_v1_CRP(j,1:19); %create empty rows when the oddball is not remembered
    end 
    j=j+1;
end 

E_all_odd_forg=str2double(forgotten_emotional_v1_CRP(~cellfun(@isempty,forgotten_emotional_v1_CRP (:,1)), :));

E_PFR_FORG=pfr(E_all_odd_forg(:,1:14), E_all_odd_forg(:,15), list_length);
E_PFR_FORG=num2cell(E_PFR_FORG);

c1=[s repmat({'Emotional'},70,1) repmat({'forgotten'},70,1) repmat({'1'},70,1) E_PFR_FORG(:,1)];
c2=[s repmat({'Emotional'},70,1) repmat({'forgotten'},70,1) repmat({'2'},70,1) E_PFR_FORG(:,2)];
c3=[s repmat({'Emotional'},70,1) repmat({'forgotten'},70,1) repmat({'3'},70,1) E_PFR_FORG(:,3)];
c4=[s repmat({'Emotional'},70,1) repmat({'forgotten'},70,1) repmat({'4'},70,1) E_PFR_FORG(:,4)];
c5=[s repmat({'Emotional'},70,1) repmat({'forgotten'},70,1) repmat({'5'},70,1) E_PFR_FORG(:,5)];
c6=[s repmat({'Emotional'},70,1) repmat({'forgotten'},70,1) repmat({'6'},70,1) E_PFR_FORG(:,6)];
c7=[s repmat({'Emotional'},70,1) repmat({'forgotten'},70,1) repmat({'7'},70,1) E_PFR_FORG(:,7)];
c8=[s repmat({'Emotional'},70,1) repmat({'forgotten'},70,1) repmat({'8'},70,1) E_PFR_FORG(:,8)];
c9=[s repmat({'Emotional'},70,1) repmat({'forgotten'},70,1) repmat({'9'},70,1) E_PFR_FORG(:,9)];
c10=[s repmat({'Emotional'},70,1) repmat({'forgotten'},70,1) repmat({'10'},70,1) E_PFR_FORG(:,10)];
c11=[s repmat({'Emotional'},70,1) repmat({'forgotten'},70,1) repmat({'11'},70,1) E_PFR_FORG(:,11)];
c12=[s repmat({'Emotional'},70,1) repmat({'forgotten'},70,1) repmat({'12'},70,1) E_PFR_FORG(:,12)];
c13=[s repmat({'Emotional'},70,1) repmat({'forgotten'},70,1) repmat({'13'},70,1) E_PFR_FORG(:,13)];
c14=[s repmat({'Emotional'},70,1) repmat({'forgotten'},70,1) repmat({'14'},70,1) E_PFR_FORG(:,14)];

PFR_E_FORG_R=[c1; c2; c3; c4; c5; c6; c7; c8; c9; c10; c11; c12; c13; c14];
c1=[]; c2=[]; c3=[]; c4=[]; c5=[]; c6=[]; c7=[]; c8=[]; c9=[]; c10=[]; c11=[]; c12=[]; c13=[]; c14=[];

%% PERCEPTUAL LISTS
clearvars -except PFR_E_REM_R PFR_E_ALL_R s PFR_E_FORG_R
dir= '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Code';
cd(dir)
dir_func='/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/September2020/v1'; %directory where the functions from
%the computational memory lab are.

load perceptual_v1_CRP

perceptual_v1_CRP(:,1:19)=cellfun(@num2str,perceptual_v1_CRP(:,1:19),'UniformOutput',false);
perceptual_v1_CRP=str2double(perceptual_v1_CRP);
list_length=14;
perceptual_subjects=perceptual_v1_CRP(:,15);
P_all=perceptual_v1_CRP(:,1:14);

cd(dir_func)
P_PFR_all=pfr(P_all,perceptual_subjects,list_length); %calculate the PFR in all 
P_PFR_all=num2cell(P_PFR_all);

c1=[s repmat({'Perceptual'},70,1) repmat({'all'},70,1) repmat({'1'},70,1) P_PFR_all(:,1)];
c2=[s repmat({'Perceptual'},70,1) repmat({'all'},70,1) repmat({'2'},70,1) P_PFR_all(:,2)];
c3=[s repmat({'Perceptual'},70,1) repmat({'all'},70,1) repmat({'3'},70,1) P_PFR_all(:,3)];
c4=[s repmat({'Perceptual'},70,1) repmat({'all'},70,1) repmat({'4'},70,1) P_PFR_all(:,4)];
c5=[s repmat({'Perceptual'},70,1) repmat({'all'},70,1) repmat({'5'},70,1) P_PFR_all(:,5)];
c6=[s repmat({'Perceptual'},70,1) repmat({'all'},70,1) repmat({'6'},70,1) P_PFR_all(:,6)];
c7=[s repmat({'Perceptual'},70,1) repmat({'all'},70,1) repmat({'7'},70,1) P_PFR_all(:,7)];
c8=[s repmat({'Perceptual'},70,1) repmat({'all'},70,1) repmat({'8'},70,1) P_PFR_all(:,8)];
c9=[s repmat({'Perceptual'},70,1) repmat({'all'},70,1) repmat({'9'},70,1) P_PFR_all(:,9)];
c10=[s repmat({'Perceptual'},70,1) repmat({'all'},70,1) repmat({'10'},70,1) P_PFR_all(:,10)];
c11=[s repmat({'Perceptual'},70,1) repmat({'all'},70,1) repmat({'11'},70,1) P_PFR_all(:,11)];
c12=[s repmat({'Perceptual'},70,1) repmat({'all'},70,1) repmat({'12'},70,1) P_PFR_all(:,12)];
c13=[s repmat({'Perceptual'},70,1) repmat({'all'},70,1) repmat({'13'},70,1) P_PFR_all(:,13)];
c14=[s repmat({'Perceptual'},70,1) repmat({'all'},70,1) repmat({'14'},70,1) P_PFR_all(:,14)];

PFR_P_ALL_R=[c1; c2; c3; c4; c5; c6; c7; c8; c9; c10; c11; c12; c13; c14];
c1=[]; c2=[]; c3=[]; c4=[]; c5=[]; c6=[]; c7=[]; c8=[]; c9=[]; c10=[]; c11=[]; c12=[]; c13=[]; c14=[];

perceptual_v1_CRP=num2cell(perceptual_v1_CRP);
perceptual_v1_CRP(:,1:19)=cellfun(@num2str,perceptual_v1_CRP(:,1:19),'UniformOutput',false);

%find trials where odd remembered 
for j=1:length(perceptual_v1_CRP)
    oddnum=perceptual_v1_CRP(j,19);
    if any(strcmp(perceptual_v1_CRP(j,1:14),oddnum));
        remembered_perceptual_v1_CRP(j,1:19)=perceptual_v1_CRP(j,1:19); %create empty rows when the oddball is not remembered
    end 
    j=j+1;
end 

P_all_odd_rem=str2double(remembered_perceptual_v1_CRP(~cellfun(@isempty,remembered_perceptual_v1_CRP (:,1)), :));

P_PFR_REM=pfr(P_all_odd_rem(:,1:14), P_all_odd_rem(:,15), list_length);
P_PFR_REM=num2cell(P_PFR_REM);

c1=[s repmat({'Perceptual'},70,1) repmat({'remembered'},70,1) repmat({'1'},70,1) P_PFR_REM(:,1)];
c2=[s repmat({'Perceptual'},70,1) repmat({'remembered'},70,1) repmat({'2'},70,1) P_PFR_REM(:,2)];
c3=[s repmat({'Perceptual'},70,1) repmat({'remembered'},70,1) repmat({'3'},70,1) P_PFR_REM(:,3)];
c4=[s repmat({'Perceptual'},70,1) repmat({'remembered'},70,1) repmat({'4'},70,1) P_PFR_REM(:,4)];
c5=[s repmat({'Perceptual'},70,1) repmat({'remembered'},70,1) repmat({'5'},70,1) P_PFR_REM(:,5)];
c6=[s repmat({'Perceptual'},70,1) repmat({'remembered'},70,1) repmat({'6'},70,1) P_PFR_REM(:,6)];
c7=[s repmat({'Perceptual'},70,1) repmat({'remembered'},70,1) repmat({'7'},70,1) P_PFR_REM(:,7)];
c8=[s repmat({'Perceptual'},70,1) repmat({'remembered'},70,1) repmat({'8'},70,1) P_PFR_REM(:,8)];
c9=[s repmat({'Perceptual'},70,1) repmat({'remembered'},70,1) repmat({'9'},70,1) P_PFR_REM(:,9)];
c10=[s repmat({'Perceptual'},70,1) repmat({'remembered'},70,1) repmat({'10'},70,1) P_PFR_REM(:,10)];
c11=[s repmat({'Perceptual'},70,1) repmat({'remembered'},70,1) repmat({'11'},70,1) P_PFR_REM(:,11)];
c12=[s repmat({'Perceptual'},70,1) repmat({'remembered'},70,1) repmat({'12'},70,1) P_PFR_REM(:,12)];
c13=[s repmat({'Perceptual'},70,1) repmat({'remembered'},70,1) repmat({'13'},70,1) P_PFR_REM(:,13)];
c14=[s repmat({'Perceptual'},70,1) repmat({'remembered'},70,1) repmat({'14'},70,1) P_PFR_REM(:,14)];

PFR_P_REM_R=[c1; c2; c3; c4; c5; c6; c7; c8; c9; c10; c11; c12; c13; c14];
c1=[]; c2=[]; c3=[]; c4=[]; c5=[]; c6=[]; c7=[]; c8=[]; c9=[]; c10=[]; c11=[]; c12=[]; c13=[]; c14=[];

%Forgotten oddballs 
j=[]; oddnum=[];
for j=1:length(perceptual_v1_CRP)
    oddnum=perceptual_v1_CRP(j,19);
    if ~any(strcmp(perceptual_v1_CRP(j,1:14),oddnum));
        forgotten_perceptual_v1_CRP(j,1:19)=perceptual_v1_CRP(j,1:19); %create empty rows when the oddball is not remembered
    end 
    j=j+1;
end 

P_all_odd_forg=str2double(forgotten_perceptual_v1_CRP(~cellfun(@isempty,forgotten_perceptual_v1_CRP (:,1)), :));

P_PFR_FORG=pfr(P_all_odd_forg(:,1:14), P_all_odd_forg(:,15), list_length);
P_PFR_FORG=num2cell(P_PFR_FORG);

c1=[s repmat({'Perceptual'},70,1) repmat({'forgotten'},70,1) repmat({'1'},70,1) P_PFR_FORG(:,1)];
c2=[s repmat({'Perceptual'},70,1) repmat({'forgotten'},70,1) repmat({'2'},70,1) P_PFR_FORG(:,2)];
c3=[s repmat({'Perceptual'},70,1) repmat({'forgotten'},70,1) repmat({'3'},70,1) P_PFR_FORG(:,3)];
c4=[s repmat({'Perceptual'},70,1) repmat({'forgotten'},70,1) repmat({'4'},70,1) P_PFR_FORG(:,4)];
c5=[s repmat({'Perceptual'},70,1) repmat({'forgotten'},70,1) repmat({'5'},70,1) P_PFR_FORG(:,5)];
c6=[s repmat({'Perceptual'},70,1) repmat({'forgotten'},70,1) repmat({'6'},70,1) P_PFR_FORG(:,6)];
c7=[s repmat({'Perceptual'},70,1) repmat({'forgotten'},70,1) repmat({'7'},70,1) P_PFR_FORG(:,7)];
c8=[s repmat({'Perceptual'},70,1) repmat({'forgotten'},70,1) repmat({'8'},70,1) P_PFR_FORG(:,8)];
c9=[s repmat({'Perceptual'},70,1) repmat({'forgotten'},70,1) repmat({'9'},70,1) P_PFR_FORG(:,9)];
c10=[s repmat({'Perceptual'},70,1) repmat({'forgotten'},70,1) repmat({'10'},70,1) P_PFR_FORG(:,10)];
c11=[s repmat({'Perceptual'},70,1) repmat({'forgotten'},70,1) repmat({'11'},70,1) P_PFR_FORG(:,11)];
c12=[s repmat({'Perceptual'},70,1) repmat({'forgotten'},70,1) repmat({'12'},70,1) P_PFR_FORG(:,12)];
c13=[s repmat({'Perceptual'},70,1) repmat({'forgotten'},70,1) repmat({'13'},70,1) P_PFR_FORG(:,13)];
c14=[s repmat({'Perceptual'},70,1) repmat({'forgotten'},70,1) repmat({'14'},70,1) P_PFR_FORG(:,14)];

PFR_P_FORG_R=[c1; c2; c3; c4; c5; c6; c7; c8; c9; c10; c11; c12; c13; c14];
c1=[]; c2=[]; c3=[]; c4=[]; c5=[]; c6=[]; c7=[]; c8=[]; c9=[]; c10=[]; c11=[]; c12=[]; c13=[]; c14=[];


%Prepare final matrix for R
PFR_R=[PFR_E_REM_R; PFR_E_FORG_R; PFR_P_REM_R; PFR_P_FORG_R];

PFR_R=array2table(PFR_R, 'VariableNames',{'subject', 'oddballtype', 'recall', 'sp', 'pfr'});
cd '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Raw_Results';
writetable(PFR_R, 'PFR.csv');
