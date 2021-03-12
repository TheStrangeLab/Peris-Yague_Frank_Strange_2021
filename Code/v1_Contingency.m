%Bryan Strange and Alba Peris-Yague

clearvars
cd '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP'

subjects=[4:7 9:12 14:75];
numberofsubjects=size(subjects,2);
recall=zeros(length(subjects),10);

t=zeros(numberofsubjects,20,8);

% targetSOA=[1 2 3 4 6];
% 
% tsoa = targetSOA(1);

cd 'Variable_SOA_70'

index=0;
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

%     if ismember(sub,[39 40 47 59])
%         Rsh=ones(1,560);
%     else
%         load(['/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Variable_SOA/Variable_SOA_70/sub',num2str(sub),'/','Rsh.mat'])
%         %load(['C:\Spain\Variable_SOA\Variable_SOA_70\sub',num2str(sub),'\','Rsh.mat'])
%     end

    [r,words]=xlsread('recout.xls');
    r=r(:,2);

    rec=[];
    for i=1:40
        rec=[rec; r((i-1)*16+2:(i-1)*16+15)];
    end
   %Delete the 1st and 2nd recalled words:
        rec(rec(:,1)==1)=NaN;
        rec(rec(:,1)==2)=NaN;
        
        rec(find(rec))=1;
   
    e=[];
    for i=1:20
        e=[e 14*(emotion_index(i)-1)+eop(i)];
    end
 % Delete the subject lists that have mistakes in the raw data in emotional lists. 
   if sub==7
         e(:,[19])=NaN; %column 19(list 36) 
   end 
   if sub==46
       e(:,[18])=NaN; %column 18(list 35)
   end 
   if sub==51
       e(:,[15])=NaN; %column 15 (list 29)
   end 
   if sub==52
       e(:,[20])=NaN; %column 20 (list 40)
   end 
   if sub==63
       e(:,[2])=NaN; %column 2(list 2)
   end 
   if sub==60
       e(:,[7])=NaN; %column 7 (list 14)
   end
   if sub==64
       e(:,[16])=NaN; %column 16 (list 35)
   end 
   if sub==68
       e(:,[16])=NaN; %column 16 (list 32)
   end  
    if sub==65
        e(:,[13])=NaN; %column 13 (list 24)
    end 
    if sub==43
        e(:,[12])=NaN; %column 12 (list 36)
    end 
    bbe=[];
    bbe=e-2;
    be=e-1;
    ae=e+1;

    p=[];
    for i=1:20
        p=[p 14*(percept_index(i)-1)+pop(i)];
    end
    if sub==9
        p(:,[17])=NaN; %column 17 (list 32)
    end 
    if sub==16
         p(:,[2])=NaN; %column 2 (list 7)
    end 
     if sub==25
         p(:,[13])=NaN; %column 13 (list 27)
     end 
     if sub==71
         p(:,[13])=NaN; %column 13 (list 22)
     end 
     if sub==33
         p(:,[2])=NaN; %column 2 (list 3)
     end 
     if sub==44
         p(:,[1])=NaN; %column 1 (list 3)
     end 
     
    bbp=[];
    bbp=p-2;
    bp=p-1;
    ap=p+1;

    ce=[];
    for i=1:20
        ce=[ce 14*(emotion_index(i)-1)+cep(i)];
    end
% Delete the lists that had a problem in the raw data
   if sub==7
         ce(:,[19])=NaN; %column 19(list 36) 
   end 
   if sub==46
       ce(:,[18])=NaN; %column 18(list 35)
   end 
   if sub==51
       ce(:,[15])=NaN; %column 15 (list 29)
   end 
   if sub==52
       ce(:,[20])=NaN; %column 20 (list 40)
   end 
   if sub==63
       ce(:,[2])=NaN; %column 2(list 2)
   end
    if sub==60
       ce(:,[7])=NaN; %column 7 (list 14)
   end
   if sub==64
       ce(:,[16])=NaN; %column 16 (list 35)
   end 
   if sub==68
       ce(:,[16])=NaN; %column 16 (list 32)
   end 
    if sub==65
        ce(:,[13])=NaN; %column 13 (list 24)
    end 
    if sub==43
        ce(:,[12])=NaN; %column 12 (list 36)
    end 
%     
    cp=[];
    for i=1:20
        cp=[cp 14*(percept_index(i)-1)+cpp(i)];
    end
    
    %Delete the lists that had a problem in the raw data
     if sub==9
        cp(:,[17])=NaN; %column 17 (list 32)
     end 
    if sub==16
         cp(:,[2])=NaN; %column 2 (list 7)
    end 
     if sub==25
         cp(:,[13])=NaN; %column 13 (list 27)
     end 
     if sub==71
         cp(:,[13])=NaN; %column 13 (list 22)
     end 
     if sub==33
         cp(:,[2])=NaN; %column 2 (list 3)
     end  
     if sub==44
         cp(:,[1])=NaN; %column 1 (list 3)
     end

    %     bbe=bbe(find(Rsh(bbe))); be=be(find(Rsh(be))); e=e(find(Rsh(e))); ae=ae(find(Rsh(ae)));
    %     bbp=bbp(find(Rsh(bbp))); bp=bp(find(Rsh(bp))); p=p(find(Rsh(p))); ap=ap(find(Rsh(ap)));
    %     ce=ce(find(Rsh(ce))); cp=cp(find(Rsh(cp)));
    for i=1:20
        if ~isnan(e(1,i))
            rece(i,1)=rec(e(1,i));
        else 
            rece(i,1)=NaN;
        end 
    end 
    i=[];
    for i=1:20
        if ~isnan(p(1,i))
            recp(i,1)=rec(p(1,i));
        else 
            recp(i,1)=NaN;
        end 
    end 
    i=[];
    for i=1:20
        if ~isnan(be(1,i))
            recbe(i,1)=rec(be(1,i));
        else 
            recbe(i,1)=NaN;
        end 
    end 
    i=[];
    for i=1:20
        if ~isnan(bp(1,i))
            recbp(i,1)=rec(bp(1,i));
        else 
            recbp(i,1)=NaN;
        end 
    end 
    i=[];
    for i=1:20
        if ~isnan(ae(1,i))
            recae(i,1)=rec(ae(1,i));
        else 
            recae(i,1)=NaN;
        end 
    end 
    i=[];
    for i=1:20
        if ~isnan(ap(1,i))
            recap(i,1)=rec(ap(1,i));
        else 
            recap(i,1)=NaN;
        end 
    end 
    i=[];
    for i=1:20
        if ~isnan(ce(1,i))
            recce(i,1)=rec(ce(1,i));
        else 
            recce(i,1)=NaN;
        end 
    end 
    i=[];
    for i=1:20
        if ~isnan(cp(1,i))
            reccp(i,1)=rec(cp(1,i));
        else 
            reccp(i,1)=NaN;
        end 
    end 
    %For the purpose of the contingency analysis we don't need this thus we
    %can coment it all.
    
%     eo=length(find(rec(e)));
%     po=length(find(rec(p)));
% 
%     bbeo=length(find(rec(bbe)));
%     bbpo=length(find(rec(bbp)));
%     beo=length(find(rec(be)));
%     bpo=length(find(rec(bp)));
%     aeo=length(find(rec(ae)));
%     apo=length(find(rec(ap)));
% 
%     ceo=length(find(rec(ce)));
%     cpo=length(find(rec(cp)));

    %recall(index,:) = [bbeo/length(bbe) beo/length(be) eo/length(e) aeo/length(ae) bbpo/length(bbp) bpo/length(bp) po/length(p) apo/length(ap) ceo/length(ce) cpo/length(cp)];
  
   % t(index,:,:)=[rec(e) rec(p) rec(be) rec(bp) rec(ae) rec(ap) rec(ce) rec(cp)];
   t(index,:,:)=[rece recp recbe recbp recae recap recce reccp];
    cd ..
end

recall=recall*100;


%%%ANALYSIS FOR E-1 AND E EFFECTS%%% 


t_e_be=zeros(numberofsubjects,4);

for tsub=1:numberofsubjects
    for j=1:20

        if t(tsub,j,1)==1 & t(tsub,j,3)==1
            t_e_be(tsub,1)=t_e_be(tsub,1)+1;

        elseif t(tsub,j,1)==1 & t(tsub,j,3)==0
            t_e_be(tsub,2)=t_e_be(tsub,2)+1;

        elseif t(tsub,j,1)==0 & t(tsub,j,3)==1
            t_e_be(tsub,3)=t_e_be(tsub,3)+1;

        elseif t(tsub,j,1)==0 & t(tsub,j,3)==0
            t_e_be(tsub,4)=t_e_be(tsub,4)+1;

        end
    end

    %t_e_be(tsub,:)=t_e_be(tsub,:)*100/38;

    %t_e_be(tsub,5)=mean([recall(tsub,7) recall(tsub,8)]);
    rere_m_refe=(t_e_be(:,1)-t_e_be(:,2));


end
cd '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Raw_Results'

eem1_sum=sum(t_e_be);
eem1_contingency=array2table([eem1_sum(1,1:2)' eem1_sum(1,3:4)']);
writetable(eem1_contingency,'eem1_contingency.csv')

% figure, bar(mean(t_e_be))
% hold
% errorbar(mean(t_e_be),std(t_e_be)/sqrt(numberofsubjects), 'Linestyle','none','Color','k');
% title('Memory contingency')
% set(gca,'XTick',[1:4])
% set(gca,'XTickLabel',{'RE RE-1','RE FE-1','FE RE-1','FE FE-1'})
% ylabel('% Recall')

%%%ANALYSIS FOR P-1 AND P EFFECTS%%%


t_p_bp=zeros(numberofsubjects,4);

for tsub=1:numberofsubjects
    for j=1:20

        if t(tsub,j,2)==1 & t(tsub,j,4)==1
            t_p_bp(tsub,1)=t_p_bp(tsub,1)+1;

        elseif t(tsub,j,2)==1 & t(tsub,j,4)==0
            t_p_bp(tsub,2)=t_p_bp(tsub,2)+1;

        elseif t(tsub,j,2)==0 & t(tsub,j,4)==1
            t_p_bp(tsub,3)=t_p_bp(tsub,3)+1;

        elseif t(tsub,j,2)==0 & t(tsub,j,4)==0
            t_p_bp(tsub,4)=t_p_bp(tsub,4)+1;

        end
    end

    %t_e_be(tsub,:)=t_e_be(tsub,:)*100/38;

    %t_e_be(tsub,5)=mean([recall(tsub,7) recall(tsub,8)]);
    %rere_m_refe=(t_e_be(:,1)-t_e_be(:,2));


end

ppm1_sum=sum(t_p_bp);
ppm1_contingency=array2table([ppm1_sum(1,1:2)' ppm1_sum(1,3:4)']);
writetable(ppm1_contingency,'ppm1_contingency.csv')

% figure, bar(mean(t_p_bp))
% hold
% errorbar(mean(t_p_bp),std(t_p_bp)/sqrt(numberofsubjects), 'Linestyle','none','Color','k');
% title('Memory contingency')
% set(gca,'XTick',[1:4])
% set(gca,'XTickLabel',{'RE RE-1','RE FE-1','FE RE-1','FE FE-1'})
% ylabel('% Recall')

%%%% ANALYSIS FOR E+1 AND E-1 EFFECTS %%%%%%% 3 (be), 5 (ae) %added the
%%%% condition that E has to be recalled
t_ab_e=zeros(numberofsubjects,4);

for tsub=1:numberofsubjects
    for j=1:20

        if t(tsub,j,1)==1 & t(tsub,j,3)==1 & t(tsub,j,5)==1 %rem rem
            t_ab_e(tsub,1)=t_ab_e(tsub,1)+1;

        elseif t(tsub,j,1)==1 & t(tsub,j,3)==1 & t(tsub,j,5)==0 %rem e-1 forg e+1
            t_ab_e(tsub,2)=t_ab_e(tsub,2)+1;

        elseif t(tsub,j,1)==1 & t(tsub,j,3)==0 & t(tsub,j,5)==1 % forg e-1 rem e+1
            t_ab_e(tsub,3)=t_ab_e(tsub,3)+1;

        elseif t(tsub,j,1)==1 & t(tsub,j,3)==0 & t(tsub,j,5)==0 % forg e-1 forg e+1
            t_ab_e(tsub,4)=t_ab_e(tsub,4)+1;

        end
    end

    %t_e_be(tsub,:)=t_e_be(tsub,:)*100/38;

    %t_e_be(tsub,5)=mean([recall(tsub,7) recall(tsub,8)]);
    %rere_m_refe=(t_e_be(:,1)-t_e_be(:,2));


end

em1ep1_sum=sum(t_ab_e);
em1ep1_contingency=array2table([em1ep1_sum(1,1:2)' em1ep1_sum(1,3:4)']);
writetable(em1ep1_contingency,'em1ep1_contingency.csv')

% figure, bar(mean(t_ab_e))
% hold
% errorbar(mean(t_ab_e),std(t_ab_e)/sqrt(numberofsubjects), 'Linestyle','none','Color','k');
% title('Memory contingency')
% set(gca,'XTick',[1:4])
% set(gca,'XTickLabel',{'RE RE-1','RE FE-1','FE RE-1','FE FE-1'})
% ylabel('% Recall')


% figure, bar(mean(recall))
% hold
% errorbar(mean(recall),std(recall)/sqrt(numberofsubjects), 'Linestyle','none','Color','k');
% title('Memory scores for word position')
% xlabel('word position')
% set(gca,'XTick',[1:10])
% set(gca,'XTickLabel',{'E-2','E-1','E','E+1','P-2','P-1','P','P+1','ConE','ConP'})
% ylabel('% Recall')
% 
% diff=zeros(length(subjects),8);
% 
% 
% for i=1:length(subjects)
%     for j=1:4
%         diff(i,j)=(recall(i,j)-recall(i,9)) ;
%     end
%     for j=5:8
%         diff(i,j)=(recall(i,j)-recall(i,10)) ;
%     end
% end
% 
% 
% 
% diff = [diff(:,[1:4]) zeros(length(subjects),1) diff(:,[5:8])];
% 
% 
% 
% figure
% hold on
% bar(mean(diff))
% errorbar(mean(diff),std(diff)/sqrt(numberofsubjects), 'Linestyle','none','Color','k');
% title('Memory scores for word position')
% xlabel('word position')
% set(gca,'XTick',[1:9])
% set(gca,'XTickLabel',{'E-2','E-1','E','E+1','','P-2','P-1','P','P+1'})
% ylabel('% Recall relative to controls')


