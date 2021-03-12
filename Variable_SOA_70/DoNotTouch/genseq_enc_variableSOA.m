%Total 40 lists; 20 P, 20 E
%SOA 1, 2, 3, 4, 6s (i.e. 4 lists of each)

clear all
for sub=1:80
    cd C:\Spain\Paola\Variable_SOA
    sdir=sprintf('sub%d',sub);
    mkdir(sdir)
    cd(sdir)
    rand('state',sub*100);

    num_pos=9;
    num_set=5;
    num_seq=40;

    tim_stp=0.1;
    isi=1; %%%%%%
    cor_cri=0.23;

    isi_stp=isi/tim_stp;
    num_wor=num_pos+num_set+1;
    num_stp=num_seq*num_wor*isi_stp;
    hrf=spm_hrf(tim_stp);

    %% ONLY ONE ODDBALL PER LIST. CODE POSITIONS OF ODDBALL AND CONTROL AS
    %% POP, CPP

    po=zeros(1,num_stp);
    cp=zeros(1,num_stp);
    pop=zeros(1,num_seq);
    cpp=zeros(1,num_seq);

    k=1;
    for j=0:num_stp
        if(mod(j,num_wor*isi_stp)==num_set*isi_stp)

            % check to ensure oddball and controls >3 positions apart

            flag=0;
            while(flag==0)
                r=randperm(num_pos);
                flag=1;

                if(find(r==1)<2 | find(r==1)>7)
                    flag=0;
                end

                if(find(r==2)<2 | find(r==2)>8)
                    flag=0;
                end

                if(abs(find(r==1)-find(r==2))<4)
                    flag=0;
                end
            end

            for i=1:num_pos
                if(r(i)==1) 	po(j+(i*isi_stp))=1; pop(k)=i+num_set;
                elseif(r(i)==2) cp(j+(i*isi_stp))=1; cpp(k)=i+num_set;
                end
            end
            k=k+1;
        end
    end


    corrcoef(po,cp)
    poc=conv(po,hrf);
    cpc=conv(cp,hrf);
    pcor=corrcoef(poc,cpc)

    while(abs(pcor(1,2))>cor_cri)
        po=zeros(1,num_stp);
        pop=zeros(1,num_seq);

        k=1;
        for j=0:num_stp
            if(mod(j,num_wor*isi_stp)==num_set*isi_stp)

                % check to ensure oddballs >3 positions apart

                flag=0;
                while(flag==0)
                    r=randperm(num_pos);
                    flag=1;

                    if(find(r==1)<2 | find(r==1)>7)
                        flag=0;
                    end

                    if(find(r==2)<2 | find(r==2)>8)
                        flag=0;
                    end


                    if(abs(find(r==1)-find(r==2))<4)
                        flag=0;
                    end

                end

                for i=1:num_pos
                    if(r(i)==1) 	po(j+(i*isi_stp))=1; pop(k)=i+num_set;
                    elseif(r(i)==2) cp(j+(i*isi_stp))=1; cpp(k)=i+num_set;
                    end
                end

                k=k+1;
            end
        end

        poc=conv(po,hrf);
        cpc=conv(cp,hrf);
        pcor=corrcoef(poc,cpc)
    end


    save pop pop
    save cpp cpp

    % specify list type and SOA

    type = [repmat([11 12 13 14 16],1,4) repmat([21 22 23 24 26],1,4)];
    % 1 codes E, 2 P and the second number is SOA
    tmp=randperm(40); listtype = zeros(1,40);
    for i=1:40; listtype(i)=type(tmp(i)); end

    save listtype listtype

    fid=fopen('C:\Spain\Paola\Variable_SOA\encode_list.txt');

    words=[];
    numw=0;

    [word_in,wlen]=fscanf(fid,'%s ',1);
    while(wlen>0)
        numw=numw+1;
        words=str2mat(words,word_in);
        [word_in,wlen]=fscanf(fid,'%s ',1);
    end

    fclose(fid);

    numw;
    words=words(2:length(words),:);

    out=cell(600,1); %set up 600 long vector for out.txt

    ss=randperm(num_seq/2); % This will randomise the word list order without changing the eop/pop etc

    the_Es=0;
    the_Ps=0;

    for s=1:num_seq

        r=randperm(num_wor-2);
        rp=randperm(num_wor-1);
        
        out{(s-1)*15+1} = str2mat('Neuva_Lista');

        if listtype(s)<20 %indicates E list
            the_Es = the_Es + 1;
            current_list = words((ss(the_Es)-1)*(num_wor-1)+1:(ss(the_Es)-1)*(num_wor-1)+14,:);
            j=1;
            for i=1:(num_wor-1)
                if(i==pop(s))
                    out{(s-1)*15 + i + 1} = str2mat(current_list(1,:));
                else
                    out{(s-1)*15 + i + 1} = str2mat(current_list(r(j)+1,:));
                    j=j+1;
                end
            end

        elseif listtype(s)>20 %indicates P list
            the_Ps = the_Ps + 1;
            current_list = words(280+(ss(the_Ps)-1)*(num_wor-1)+1:280+(ss(the_Ps)-1)*(num_wor-1)+14,:); %the 280 is because encode list is 1st 20 emotional/then 20 for P
            for i=1:(num_wor-1)
                out{(s-1)*15 + i + 1} = str2mat(current_list(rp(i),:));
            end
        end
    end

    sr = randperm(num_seq); %random number for counting
    fid=fopen('out.txt','w');
    k=0;
    for s=1:num_seq
        if listtype(s)<20 %indicates E list
            for i=1:num_wor
                fprintf(fid,'%s 0\n',out{i+(s-1)*num_wor,:});
            end
        elseif listtype(s)>20 %indicates P list
            for i=1:num_wor
                if(i==pop(s))
                    k=k+1;
                    fprintf(fid,'%s %d\n',out{i+(s-1)*num_wor,:},k);
                else
                    fprintf(fid,'%s 0\n',out{i+(s-1)*num_wor,:});
                end
            end
        end
        fprintf(fid,'%s 0\n',num2str(99+sr(s)));  %random number between 100 and 133
    end

    fclose(fid);
    clear all

end
