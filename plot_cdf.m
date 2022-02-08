%% ͼ��Ԥ��
f1 = figure(1);
figWidth = 233.6;
figHeight = 168;
set(gcf,'unit','pixels','position',[0,100,figWidth,figHeight]); % gcf���õ�ǰfigure
% ͼ
linewidth_line = 1;

%% ��������
I = result_logic==1 & rt_logic_raw==1 & cond_switch==1;
rt_repeat = rt_raw(I);
I = result_logic==1 & rt_logic_raw==1 & cond_switch==2;
rt_switch = rt_raw(I);

hold on
h1 = cdfplot(rt_repeat);
h2 = cdfplot(rt_switch);

%% ͼ�����
grid off
set(h1,'Color','k','LineWidth',1);
set(h2,'Color','r','LineWidth',1);
xlabel('Response time (sec)');
ylabel({'Cumulative','distribution'});
set(gca,'tickdir','out');
xticks([1 2 3 4 5]);
delete(title(''));

%% ����ͼ��
figurename = ['cdf_subject_'];
print(f1,[figurename,keyword(1:3)],'-r300','-dtiff');









