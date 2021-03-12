%Bryan Strange and Alba Peris-Yague

clearvars
cd '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP'

subjects = [4:7 9:12 14:75];

numberofsubjects=size(subjects,2);

t=zeros(numberofsubjects,4,8);

targetSOA=[1 2 3 4 6];
cd 'Variable_SOA_70'

for tsoa =6; %targetSOA; %This can be changed to 1 2 3 4 or 6 if you want to look at a specific SOA

    index=0;
    for sub=subjects
        index=index+1;
        sdir=sprintf('sub%d',sub);

        cd(sdir)

        load pop
        load cpp
        load listtype

        emotion_index = find(listtype==(tsoa+10));
        percept_index = find(listtype==(tsoa+20));

        eop=pop(emotion_index);
        cep=cpp(emotion_index);
        pop=pop(percept_index);
        cpp=cpp(percept_index);
     
        [r,words]=xlsread('recout.xls');
        r=r(:,2);

        rec=[];
        for i=1:40
            rec=[rec; r((i-1)*16+2:(i-1)*16+15)];
        end

        rec(find(rec))=1;

        e=[];
        for i=1:4
            e=[e 14*(emotion_index(i)-1)+eop(i)];
        end
% Delete the subject lists that have mistakes in the raw data in emotional lists. 
   if sub==7 && tsoa==3%SOA3 
         e(:,[4])=NaN; 
   end 
   if sub==46 && tsoa==3%SOA3
       e(:,[4])=NaN; 
   end 
    if sub==51 && tsoa==4%SOA4
        e(:,[4])=NaN; %column 15 (list 29)
    end 
    if sub==52 && tsoa==3%SOA 3
        e(:,[4])=NaN; %column 20 (list 40)
    end 
    if sub==63 && tsoa==2%SOA 2
        e(:,[1])=NaN; %column 2(list 2)
    end 
    if sub==60 && tsoa==2 %SOA2
        e(:,[3])=NaN; %column 3 (list 14)
    end 
    if sub==65 && tsoa==3
        e(:,[3])=NaN; %column 3 (list 24)
    end 
    if sub==43 && tsoa==6
        e(:,[3])=NaN; %column 3 (list 26)
    end 

        bbe=[];
        bbe=e-2;
        be=e-1;
        ae=e+1;

        p=[];
        for i=1:4
            p=[p 14*(percept_index(i)-1)+pop(i)];
        end

    if sub==9 && tsoa==3 %SOA 3
         p(:,[3])=NaN; %column 17 (list 32)
     end 
     if sub==16 && tsoa==4 %SOA 4
          p(:,[4])=NaN; %column 2 (list 7)
     end 
      if sub==25 && tsoa==3%SOA 3
          p(:,[4])=NaN; %column 13 (list 27)
      end 
      if sub==71 && tsoa==6%SOA 6
          p(:,[2])=NaN; %column 13 (list 22)
      end 
      if sub==33 && tsoa==2;%SOA 2
          p(:,[1])=NaN; %column 2 (list 3)
      end 
      if sub==44 && tsoa==2;%SOA 2
          p(:,[1])=NaN; %column 1 (list 3)
      end 
     
        bbp=[];
        bbp=p-2;
        bp=p-1;
        ap=p+1;

        ce=[];
        for i=1:4
            ce=[ce 14*(emotion_index(i)-1)+cep(i)];
        end
    if sub==7 && tsoa==3%SOA 3
         ce(:,[4])=NaN; 
   end 
    if sub==46 && tsoa==3%SOA3
        ce(:,[4])=NaN; %column 18(list 35)
    end 
   if sub==51 && tsoa==4%SOA 4
        ce(:,[4])=NaN; %column 15 (list 29)
    end 
    if sub==52 && tsoa==3%SOA 3
        ce(:,[4])=NaN; %column 20 (list 40)
    end 
     if sub==63 && tsoa==2 %SOA 2
         ce(:,[1])=NaN; %column 2(list 2)
     end
    if sub==60 && tsoa==2 %SOA2
        ce(:,[3])=NaN; %column 3 (list 14)
    end 
    if sub==65 && tsoa==3
        ce(:,[3])=NaN; %column 3 (list 24)
    end 
    if sub==43 && tsoa==6
        ce(:,[3])=NaN; %column 3 (list 26)
    end 

        cp=[];
        for i=1:4
            cp=[cp 14*(percept_index(i)-1)+cpp(i)];
        end
        
        %Delete the lists that had a problem in the raw data
      if sub==9 && tsoa==3%SOA3
         cp(:,[3])=NaN; 
      end 
     if sub==16 && tsoa==4%SOA 4
          cp(:,[3])=NaN; %column 2 (list 7)
     end 
      if sub==25 && tsoa==3%SOA 3
          cp(:,[3])=NaN; %column 13 (list 27)
      end 
      if sub==71 && tsoa==6%SOA 6
          cp(:,[2])=NaN; %column 13 (list 22)
      end 
      if sub==33 && tsoa==2%SOA 2
          cp(:,[1])=NaN; %column 2 (list 3)
      end  
      if sub==44 && tsoa==2;%SOA 2
          cp(:,[1])=NaN; %column 1 (list 3)
      end 
     
      for i=1:length(e)
        if ~isnan(e(1,i))
            rece(i,1)=rec(e(1,i));
        else 
            rece(i,1)=NaN;
        end 
    end 
    i=[];
    for i=1:length(p)
        if ~isnan(p(1,i))
            recp(i,1)=rec(p(1,i));
        else 
            recp(i,1)=NaN;
        end 
    end 
    i=[];
    for i=1:length(be)
        if ~isnan(be(1,i))
            recbe(i,1)=rec(be(1,i));
        else 
            recbe(i,1)=NaN;
        end 
    end 
    i=[];
    for i=1:length(bp)
        if ~isnan(bp(1,i))
            recbp(i,1)=rec(bp(1,i));
        else 
            recbp(i,1)=NaN;
        end 
    end 
    i=[];
    for i=1:length(ae)
        if ~isnan(ae(1,i))
            recae(i,1)=rec(ae(1,i));
        else 
            recae(i,1)=NaN;
        end 
    end 
    i=[];
    for i=1:length(ap)
        if ~isnan(ap(1,i))
            recap(i,1)=rec(ap(1,i));
        else 
            recap(i,1)=NaN;
        end 
    end 
    i=[];
    for i=1:length(ce)
        if ~isnan(ce(1,i))
            recce(i,1)=rec(ce(1,i));
        else 
            recce(i,1)=NaN;
        end 
    end 
    i=[];
    for i=1:length(cp)
        if ~isnan(cp(1,i))
            reccp(i,1)=rec(cp(1,i));
        else 
            reccp(i,1)=NaN;
        end 
    end 
       
            t(index,:,:)=[rece recp recbe recbp recae recap recce reccp];

        %t(index,:,:)=[rec(e) rec(p) rec(be) rec(bp) rec(ae) rec(ap) rec(ce) rec(cp)];
        % t has 3 dimensions: 70 (subject), 4 (lists per SOA), 8 (conditions of interest) 
        cd ..
    end


    %%%ANALYSIS FOR E-1 AND E EFFECTS%%%

  
    %for P lists, effects are 2 and 4 because t(index,:,:)=[rec(e) rec(p) rec(be) rec(bp) rec(ae) rec(ap) rec(ce) rec(cp)];

    t_e_be=zeros(numberofsubjects,4);

    for tsub=1:numberofsubjects
        for j=1:4

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

        %t_e_be(tsub,:)=t_e_be(tsub,:)*100/4; %need to scale by 4, as there are 4 lists per SOA 

    end

%     figure, bar(mean(t_e_be))
%     hold
%     errorbar(mean(t_e_be),std(t_e_be)/sqrt(numberofsubjects), 'Linestyle','none','Color','k');
%     title('Memory contingency emotional lists')
%     set(gca,'XTick',[1:4])
%     set(gca,'XTickLabel',{'RE RE-1','RE FE-1','FE RE-1','FE FE-1'})
%     ylabel('% Recall')

% Contingency Analyses for perceptual items %
    t_p_bp=zeros(numberofsubjects,4);

for tsub=1:numberofsubjects
    for j=1:4

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
 %t_p_bp(tsub,:)=t_p_bp(tsub,:)*100/4;
end
%     figure, bar(mean(t_p_bp))
%     hold
%     errorbar(mean(t_p_bp),std(t_p_bp)/sqrt(numberofsubjects), 'Linestyle','none','Color','k');
%     title('Memory contingency perceptual lists')
%     set(gca,'XTick',[1:4])
%     set(gca,'XTickLabel',{'RE RE-1','RE FE-1','FE RE-1','FE FE-1'})
%     ylabel('% Recall')
end


cd '/Users/albaperis/Desktop/Alba/PhD UPM /Von Restroff WP3/Paper_github/Odd_SOA_CRP/Raw_Results'

%Change manually the SOAs numbers here too. 
eem1_sum=sum(t_e_be);
eem1_contingency=array2table([eem1_sum(1,1:2)' eem1_sum(1,3:4)']);
writetable(eem1_contingency,'SOA6_eem1_contingency.csv')

ppm1_sum=sum(t_p_bp);
ppm1_contingency=array2table([ppm1_sum(1,1:2)' ppm1_sum(1,3:4)']);
writetable(ppm1_contingency,'SOA6_ppm1_contingency.csv')

