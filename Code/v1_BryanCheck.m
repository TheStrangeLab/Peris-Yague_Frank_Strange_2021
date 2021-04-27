clearvars
cd '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Raw_data'

subjects = [4:7 9:12 14:75];

numberofsubjects=size(subjects,2);
recall=zeros(length(subjects),10);

index=0;

pep_all=[];
ppp_all=[];
Eminus1 = zeros(70,14);
Erecall = zeros(70,14);


for sub=subjects
    index=index+1;
    sdir=sprintf('sub%d',sub);

    cd(sdir)


    load pop
    load cpp
    load listtype
   
    emotion_index = find(listtype<20);

    percept_index = find(listtype>20);
   
    eop=pop(emotion_index);
    cep=cpp(emotion_index);
    pop=pop(percept_index);  
    cpp=cpp(percept_index);
   
    pep_all=[pep_all eop]; %what is this for? it's not used later on?
    ppp_all=[ppp_all pop];
   
    [r,words]=xlsread('recout.xls');
    r=r(:,2);

    rec=[];
    for i=1:40
        rec=[rec; r((i-1)*16+2:(i-1)*16+15)];
    end

    e=[];
    for i=1:20
        e=[e 14*(emotion_index(i)-1)+eop(i)];
    end

%     bbe=[];
%     for i=1:20
%         if eop(i)>7
%             bbe=[bbe 14*(emotion_index(i)-1)+eop(i)-2];
%         else
%         end
%     end

be=e+1;

%%
%Eminus1 = zeros(70,14); %why 14? and not 20?

% for i=1:20 %20 emotional lists
%  Erecallpos = rec(e(i)); %finds the recalled E word 
%    if Erecallpos > 0 % if E>0 i.e if E is recalled 
%      if  rec(bbe(i)) > 0 % AND if E-1 is >0 i.e if E is recalled
%         Eminus1(Erecallpos)+1; % put  a 1 // if that's not the case, put a 0?
%       else
%       end
%     else
%    end  
% end

%count how many e-1 recalled when e recalled in each sp
 for i=1:20
     Erecallpos = rec(e(i));
     if Erecallpos > 0 &&  rec(be(i)) > 0
             Eminus1(index,Erecallpos)=Eminus1(Erecallpos)+1;
         else 
     end 
         
 end 
 
 %count how many e recalled at each sp (needed for later normalization)
 for i=1:20
     Erecallpos = rec(e(i));
     if Erecallpos > 0 
             Erecall(index,Erecallpos)=Erecall(Erecallpos)+1;
         else 
     end 
         
 end 
     cd .. 
 end 
   
total_em1=sum(Eminus1);
total_e=sum(Erecall);


div=total_em1./total_e; %normalize the amount of e-1 recalled when e was recalled by the total 
%amount of e recalled per sp 

figure,bar(div)