
close all
clc
clear

% make sure they have same length in char counts
% gives vm folder names
vms = cellstr(['rtxen_2vm   ';...
               'xen_2vm_t_30';...
               'xen_2vm_t_1 ']);
dists = cellstr([
                 'uni-medium_uni-moderate_ratio';...
                 'uni-light_uni-moderate_ratio ';...
                 ]);
file_dists = cellstr([
                     'medium-2vm_null_yes ';...
                     'light-2vm_null_yes  ';...

                 ]);
dists_title = cellstr([                          
                      'Medium Task Utilization (0.1, 0.4) ';...
                      'Light Task Utilization (0.001, 0.1)'
                  ]);
%change xaxis accordingly
%xaxis=[0.2 0.4 0.6 0.8 1 1.2 1.4 1.6 1.8 2 2.2 2.4 2.6 2.8 3 3.2 3.4 3.6 3.8 4 4.2];
xaxis=[0.4 1 1.4 2 2.4 3 3.4 4];
%xaxis=[4 4.2 4.4 4.6 4.8 5];
% lw=[8,8,8,8,8,8,3,3,3];
% ms=[8,8,8,8,8,8,6,6,6];
lw=[4,5,3,3,3];
ms=[10,8,6,6,6];
ls=cellstr(['-sb';'-og';'-^m';'-sk';'-or';'-^c';'-oy';'-xb';'-^r']);
   
for j=1:length(dists)
h=figure
    schdublilty=[];
 
 %   h=figure('Position', [100, 100, 1049, 895]);
    for i=1:length(vms)

       fid = fopen(strcat(strtrim(vms{i}),'/',dists{j}));

        tline = fgets(fid);
        suc = zeros(1,length(xaxis));
        sum = zeros(1,length(xaxis));
        util = 1;

        while ischar(tline)

            if(1==(isspace(tline)))
                util=util+1;

            elseif(ischar(tline))

                oline = strsplit(strtrim(tline));
                if (size(oline,2)>2)
                    sum(util)=sum(util)+1;
                    if(str2double(oline(3))>0)
                        suc(util)=suc(util)+1;
                    end
                end
            end
            tline = fgets(fid);
        end
        fclose(fid);
        if(i<length(vms))
            schdublilty(i,:) = (suc./sum)';
        else
            schdublilty(i,:) = (suc./sum)';
            for kk = 1:length(schdublilty(i,:))
                if((schdublilty(i,kk)<0))
                    schdublilty(i,kk)=0;
                end
            end
        end

        %subplot(2,2,j);
        plot(xaxis,schdublilty(i,:),ls{i},'LineWidth',lw(i),'MarkerSize',ms(i))

        hold on

    end
    ylim([0 1.1])
    h_title=title(strtrim(dists_title{j}),'Interpreter', 'none');
    set(h_title,'FontSize',18);
    % update the line below correspond to the vms list above
    h_legend=legend('Xen-RTDS','Xen-credit-t30','Xen-credit-t1','Location','sw');%[0.8, 0.3, 0.1, 01]);

    set(h_legend,'FontSize',15);
    set(gca,'fontsize',15)
    xlabel('Task Set Utilization','FontSize',15)
    ylabel('Fraction of Schedulable Task Sets','FontSize',15)
    grid on
   % hold off
   
   
    %save to pdf
    set(h,'Units','Inches');
    pos = get(h,'Position');
    set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    print(h,strcat(strtrim(file_dists{j}),''),'-dpdf','-r0')

end

