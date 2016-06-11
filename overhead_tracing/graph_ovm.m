%% sch cnt
clear 
close all
xaxis=[1 2 3 4 5 6 7 8];
lw=[5,4,3,3];
ms=[10,8,6,6];
ls=cellstr(['-sb';'-sc';'-og';'-or';'-or';'-^c';'-oy';'-xb';'-^r']);



                   
sch_cnt = [...
   %credit
[151508, 142353, 133461, 123891, 115735, 105257, 99544, 94364];...
[151680, 143065, 136859, 127058, 121941, 112262, 101202, 89197];...
[151766, 142209, 133384, 124303, 114675, 105869, 99083, 86305];...
[151897, 142835, 133644, 126841, 116761, 106468, 99563, 90765];...
[151343, 142436, 133330, 123883, 119389, 108894, 104340, 96828];...
[151808, 147420, 134659, 130324, 125469, 111435, 99882, 94475];...
[160776, 152505, 134401, 126600, 120640, 113563, 107426, 104170];...
[167177, 159550, 143808, 133698, 128064, 116258, 108921, 103564];...


%rtds
[6002560, 6391661, 6911584, 7583995, 8327326, 9211595, 10074998, 11210519];...
[6018254, 6395775, 6900374, 7592440, 8351798, 9153929, 10101106, 11008285];...
[5989693, 6354827, 6732481, 7492287, 8313473, 9120103, 9974183, 11043504];...
[5981730, 6345268, 6737039, 7469143, 8292508, 9068389, 9922571, 10956101];...
[6006336, 6441675, 6964254, 7630209, 8442024, 9307189, 10268469, 11392482];...
[6002797, 6438100, 7009725, 7606909, 8491249, 9197217, 10249180, 11359918];...
[6037080, 6513049, 7079279, 7695924, 8256126, 8814283, 9457244, 10076104];...
[6042920, 6619181, 7221260, 7898455, 8448470, 9058254, 9646701, 10248966];...
];


dists_title = cellstr(['Bimodal Task Utilization [0.66%:(0.001,0.1), 0.33%:(0.5, 0.9)]';
                       'Heavy Task Utilization (0.5, 0.9)                             ';
                       'Medium Task Utilization (0.1, 0.4)                            ';
                       'Light Task Utilization (0.001, 0.1)                           ']);


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
    plot(xaxis,sch_cnt(2*i-1+8,:),ls{3},'LineWidth',lw(3),'MarkerSize',ms(3));
    hold on
    plot(xaxis,sch_cnt(2*i+8,:),ls{4},'LineWidth',lw(4),'MarkerSize',ms(4));

	h_title=title(strtrim(dists_title{i}),'Interpreter', 'none');
	set(h_title,'FontSize',12);

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


%% sch total time
clear 
close all
xaxis=[1 2 3 4 5 6 7 8];
lw=[5,4,3,3];
ms=[10,8,6,6];
ls=cellstr(['-sb';'-sc';'-og';'-or';'-or';'-^c';'-oy';'-xb';'-^r']);



                   
sch_time = [...
   %credit
[253054851, 199070888, 155505132, 131915327, 110014302, 81284484, 56524454, 80017399];...
[253353667, 194011249, 157964629, 131665144, 112181437, 94272457, 65721528, 55268928];...
[242318673, 192751751, 167378381, 138218491, 110565990, 90846342, 70106913, 90460811];...
[242545251, 192815880, 173098892, 136974096, 112773818, 88263956, 68854979, 82776778];...
[259936345, 202854992, 159226823, 130239444, 107718532, 80164716, 58049266, 68568087];...
[246939110, 199454339, 167585278, 134507019, 112487876, 87314218, 58256576, 46656290];...
[259451883, 193189931, 161183101, 135992989, 130009384, 116573197, 115348816, 138016132];...
[291061382, 219588606, 186758546, 157151214, 153159682, 125047007, 116257147, 133315439];...
%rtds
[4889152792, 4744667106, 4523828474, 4163634534, 3730370468, 3104892881, 2433122581, 1653466409];...
[4887980027, 4740188076, 4510715665, 4149269177, 3707939026, 3091686843, 2420817029, 1661229093];...
[4911823713, 4751191938, 4622522070, 4271878906, 3779980216, 3185786230, 2507761327, 1767844560];...
[4906243923, 4755877276, 4632697971, 4269305430, 3733750294, 3208256120, 2529314517, 1809198080];...
[4886074237, 4721198470, 4491580380, 4124560881, 3624058635, 3026611405, 2289035259, 1540087210];...
[4886126235, 4707553225, 4425965469, 4125894301, 3543315716, 3000118475, 2294825855, 1524132259];...
[4862448847, 4672758241, 4385711058, 4039048257, 3635422932, 3197737131, 2746414073, 2302061676];...
[4840803361, 4564144878, 4220086595, 3802019680, 3378159318, 2975221546, 2594924467, 2190916115]];


dists_title = cellstr(['Bimodal Task Utilization [0.66%:(0.001,0.1), 0.33%:(0.5, 0.9)]';
                       'Heavy Task Utilization (0.5, 0.9)                             ';
                       'Medium Task Utilization (0.1, 0.4)                            ';
                       'Light Task Utilization (0.001, 0.1)                           ']);


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
    plot(xaxis,sch_time(2*i-1+8,:),ls{3},'LineWidth',lw(3),'MarkerSize',ms(3));
    hold on
    plot(xaxis,sch_time(2*i+8,:),ls{4},'LineWidth',lw(4),'MarkerSize',ms(4));

	h_title=title(strtrim(dists_title{i}),'Interpreter', 'none');
	set(h_title,'FontSize',12);

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

%% sch events cnt
xaxis=[1 2 3 4 5 6 7 8];
lw=[4,5,4,3,3];
ms=[6,10,8,6,6];
ls=cellstr(['-s ';'-og';'-^m';'-sk';'-or';'-^c';'-oy';'-xb';'-^r']);



                   
sch_cnt = [[151508, 142353, 133461, 123891, 115735, 105257, 99544, 94364];...
[151680, 143065, 136859, 127058, 121941, 112262, 101202, 89197];...
[151766, 142209, 133384, 124303, 114675, 105869, 99083, 86305];...
[151897, 142835, 133644, 126841, 116761, 106468, 99563, 90765];...
[151343, 142436, 133330, 123883, 119389, 108894, 104340, 96828];...
[151808, 147420, 134659, 130324, 125469, 111435, 99882, 94475];...
[160776, 152505, 134401, 126600, 120640, 113563, 107426, 104170];...
[167177, 159550, 143808, 133698, 128064, 116258, 108921, 103564]]
dists_title = cellstr(['Bimodal Task Utilization [0.66%:(0.001,0.1), 0.33%:(0.5, 0.9)]';
                       'Heavy Task Utilization (0.5, 0.9)                             ';
                       'Medium Task Utilization (0.1, 0.4)                            ';
                       'Light Task Utilization (0.001, 0.1)                           ']);


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

	h_legend=legend('long-period','moderate-period','Location','sw');%[0.8, 0.3, 0.1, 01]);

	set(h_legend,'FontSize',15);
	set(gca,'fontsize',15)
	xlabel('Task Set Utilization','FontSize',15)
	ylabel('Scheduling total count','FontSize',15)
	grid on

	%save to pdf
	set(h,'Units','Inches');
	pos = get(h,'Position');
	set(h,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(h,strcat(strtrim(file_title{i}),'-new-credit'),'-dpdf','-r0')

end