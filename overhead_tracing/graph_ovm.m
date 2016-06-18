%% sch events cnt if you have both rtds and credit data
clear 
close all

% total util rates used
xaxis=[1 2 3 4 5 6 7 8]; % make sure this matches with the total util rates you are using
lw=[5,4,3,3];
ms=[10,8,6,6];
ls=cellstr(['-sb';'-sc';'-og';'-or';'-or';'-^c';'-oy';'-xb';'-^r']);



                   
sch_cnt = [...
%credit data goes here
[151508, 142353, 133461, 123891, 115735, 105257, 99544, 94364];...  % put bimo long period data
[151680, 143065, 136859, 127058, 121941, 112262, 101202, 89197];... % put bimo moderate period data
[151766, 142209, 133384, 124303, 114675, 105869, 99083, 86305];...  % put heavy long period data
[151897, 142835, 133644, 126841, 116761, 106468, 99563, 90765];...	% put heavy moderate period data
[151343, 142436, 133330, 123883, 119389, 108894, 104340, 96828];...	% put medium long period data
[151808, 147420, 134659, 130324, 125469, 111435, 99882, 94475];...	% put medium moderate period data
[160776, 152505, 134401, 126600, 120640, 113563, 107426, 104170];...% put light long period data
[167177, 159550, 143808, 133698, 128064, 116258, 108921, 103564];...% put light moderate period data
%rtds data goes here
[151508, 142353, 133461, 123891, 115735, 105257, 99544, 94364];...  % put bimo long period data
[151680, 143065, 136859, 127058, 121941, 112262, 101202, 89197];... % put bimo moderate period data
[151766, 142209, 133384, 124303, 114675, 105869, 99083, 86305];...  % put heavy long period data
[151897, 142835, 133644, 126841, 116761, 106468, 99563, 90765];...	% put heavy moderate period data
[151343, 142436, 133330, 123883, 119389, 108894, 104340, 96828];...	% put medium long period data
[151808, 147420, 134659, 130324, 125469, 111435, 99882, 94475];...	% put medium moderate period data
[160776, 152505, 134401, 126600, 120640, 113563, 107426, 104170];...% put light long period data
[167177, 159550, 143808, 133698, 128064, 116258, 108921, 103564];...% put light moderate period data

];

% title for the plots
dists_title = cellstr(['Bimodal Task Utilization [0.66%:(0.001,0.1), 0.33%:(0.5, 0.9)]';
                       'Heavy Task Utilization (0.5, 0.9)                             ';
                       'Medium Task Utilization (0.1, 0.4)                            ';
                       'Light Task Utilization (0.001, 0.1)                           ']);

% pdf file name for the plots
file_title = cellstr([ 'bimo-sched-total-count  ';
                       'heavy-sched-total-count ';
                       'medium-sched-total-count';
                       'light-sched-total-count ']);
for i=1:length(dists_title)
	h=figure


	plot(xaxis,sch_cnt(2*i-1,:),ls{1},'LineWidth',lw(1),'MarkerSize',ms(1));
	hold on
    plot(xaxis,sch_cnt(2*i,:),ls{2},'LineWidth',lw(2),'MarkerSize',ms(2));
    hold on
    plot(xaxis,sch_cnt(2*i-1+2*length(dists_title),:),ls{3},'LineWidth',lw(3),'MarkerSize',ms(3));
    hold on
    plot(xaxis,sch_cnt(2*i+2*length(dists_title),:),ls{4},'LineWidth',lw(4),'MarkerSize',ms(4));

	h_title=title(strtrim(dists_title{i}),'Interpreter', 'none');
	set(h_title,'FontSize',12);
    % update the line below accordingly
	h_legend=legend('long-period-credit','moderate-period-credit','long-period-rtds','moderate-period-rtds','Location',[0.7, 0.01, 0.1, 01]);

	set(h_legend,'FontSize',15);
	set(gca,'fontsize',15)
	xlabel('Task Set Utilization','FontSize',15)
	ylabel('Scheduling total count','FontSize',15)
	grid on

	%save to pdf
	set(h,'Units','Inches');
	pos = get(h,'Position');
	set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(h,strcat(strtrim(file_title{i}),'-credit-vc-rtds'),'-dpdf','-r0')
end


%% sch total time if you have both rtds and credit data
clear 
close all
% total util rates used
xaxis=[1 2 3 4 5 6 7 8]; % make sure this matches with the total util rates you are using
lw=[5,4,3,3];
ms=[10,8,6,6];
ls=cellstr(['-sb';'-sc';'-og';'-or';'-or';'-^c';'-oy';'-xb';'-^r']);



                   
sch_time = [...
%credit goes here
[151508, 142353, 133461, 123891, 115735, 105257, 99544, 94364];...  % put bimo long period data
[151680, 143065, 136859, 127058, 121941, 112262, 101202, 89197];... % put bimo moderate period data
[151766, 142209, 133384, 124303, 114675, 105869, 99083, 86305];...  % put heavy long period data
[151897, 142835, 133644, 126841, 116761, 106468, 99563, 90765];...	% put heavy moderate period data
[151343, 142436, 133330, 123883, 119389, 108894, 104340, 96828];...	% put medium long period data
[151808, 147420, 134659, 130324, 125469, 111435, 99882, 94475];...	% put medium moderate period data
[160776, 152505, 134401, 126600, 120640, 113563, 107426, 104170];...% put light long period data
[167177, 159550, 143808, 133698, 128064, 116258, 108921, 103564];...% put light moderate period data
%rtds goes here
[151508, 142353, 133461, 123891, 115735, 105257, 99544, 94364];...  % put bimo long period data
[151680, 143065, 136859, 127058, 121941, 112262, 101202, 89197];... % put bimo moderate period data
[151766, 142209, 133384, 124303, 114675, 105869, 99083, 86305];...  % put heavy long period data
[151897, 142835, 133644, 126841, 116761, 106468, 99563, 90765];...	% put heavy moderate period data
[151343, 142436, 133330, 123883, 119389, 108894, 104340, 96828];...	% put medium long period data
[151808, 147420, 134659, 130324, 125469, 111435, 99882, 94475];...	% put medium moderate period data
[160776, 152505, 134401, 126600, 120640, 113563, 107426, 104170];...% put light long period data
[167177, 159550, 143808, 133698, 128064, 116258, 108921, 103564];...% put light moderate period data
];

% title for the plots
dists_title = cellstr(['Bimodal Task Utilization [0.66%:(0.001,0.1), 0.33%:(0.5, 0.9)]';
                       'Heavy Task Utilization (0.5, 0.9)                             ';
                       'Medium Task Utilization (0.1, 0.4)                            ';
                       'Light Task Utilization (0.001, 0.1)                           ']);

% pdf file name for the plots
file_title = cellstr([ 'bimo-sched-total-time  ';
                       'heavy-sched-total-time ';
                       'medium-sched-total-time';
                       'light-sched-total-time ']);
for i=1:length(dists_title)
	h=figure


	plot(xaxis,sch_time(2*i-1,:),ls{1},'LineWidth',lw(1),'MarkerSize',ms(1));
	hold on
    plot(xaxis,sch_time(2*i,:),ls{2},'LineWidth',lw(2),'MarkerSize',ms(2));
    hold on
    plot(xaxis,sch_time(2*i-1+2*length(dists_title),:),ls{3},'LineWidth',lw(3),'MarkerSize',ms(3));
    hold on
    plot(xaxis,sch_time(2*i+2*length(dists_title),:),ls{4},'LineWidth',lw(4),'MarkerSize',ms(4));

	h_title=title(strtrim(dists_title{i}),'Interpreter', 'none');
	set(h_title,'FontSize',12);
    % update the line below accordingly
	h_legend=legend('long-period-credit','moderate-period-credit','long-period-rtds','moderate-period-rtds','Location',[0.3, 0.01, 0.1, 01]);

	set(h_legend,'FontSize',15);
	set(gca,'fontsize',15)
	xlabel('Task Set Utilization','FontSize',15)
	ylabel('Scheduling total time','FontSize',15)
	grid on

	%save to pdf
	set(h,'Units','Inches');
	pos = get(h,'Position');
	set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(h,strcat(strtrim(file_title{i}),'-credit-vc-rtds'),'-dpdf','-r0')
end

%% sch events cnt if you have only credit or rtds data

% total util rates used
xaxis=[1 2 3 4 5 6 7 8]; % make sure this matches with the total util rates you are using
lw=[4,5,4,3,3];
ms=[6,10,8,6,6];
ls=cellstr(['-s ';'-og';'-^m';'-sk';'-or';'-^c';'-oy';'-xb';'-^r']);



                   
sch_cnt = [...
[151508, 142353, 133461, 123891, 115735, 105257, 99544, 94364];...  % put bimo long period data
[151680, 143065, 136859, 127058, 121941, 112262, 101202, 89197];... % put bimo moderate period data
[151766, 142209, 133384, 124303, 114675, 105869, 99083, 86305];...  % put heavy long period data
[151897, 142835, 133644, 126841, 116761, 106468, 99563, 90765];...	% put heavy moderate period data
[151343, 142436, 133330, 123883, 119389, 108894, 104340, 96828];...	% put medium long period data
[151808, 147420, 134659, 130324, 125469, 111435, 99882, 94475];...	% put medium moderate period data
[160776, 152505, 134401, 126600, 120640, 113563, 107426, 104170];...% put light long period data
[167177, 159550, 143808, 133698, 128064, 116258, 108921, 103564];...% put light moderate period data

];

% title for the plots
dists_title = cellstr(['Bimodal Task Utilization [0.66%:(0.001,0.1), 0.33%:(0.5, 0.9)]';
                       'Heavy Task Utilization (0.5, 0.9)                             ';
                       'Medium Task Utilization (0.1, 0.4)                            ';
                       'Light Task Utilization (0.001, 0.1)                           ']);

% pdf file name for the plots
file_title = cellstr([ 'bimo-sched-total-count  ';
                       'heavy-sched-total-count ';
                       'medium-sched-total-count';
                       'light-sched-total-count ']);

for i=1:length(dists_title)

	h=figure

	plot(xaxis,sch_cnt(2*i-1,:),ls{1},'LineWidth',lw(1),'MarkerSize',ms(1));
	hold on
    plot(xaxis,sch_cnt(2*i,:),ls{2},'LineWidth',lw(2),'MarkerSize',ms(2));
	h_title=title(strtrim(dists_title{i}),'Interpreter', 'none');
	set(h_title,'FontSize',12);
    % update the line below accordingly
	h_legend=legend('long-period','moderate-period','Location','sw');%[0.8, 0.3, 0.1, 01]);

	set(h_legend,'FontSize',15);
	set(gca,'fontsize',15)
	xlabel('Task Set Utilization','FontSize',15)
	ylabel('Scheduling total count or total time','FontSize',15)
	grid on

	%save to pdf
	set(h,'Units','Inches');
	pos = get(h,'Position');
	set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(h,strcat(strtrim(file_title{i}),'-new-credit'),'-dpdf','-r0')

end