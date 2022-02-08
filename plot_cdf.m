%% 图像预设
f1 = figure(1);
figWidth = 233.6;
figHeight = 168;
set(gcf,'unit','pixels','position',[0,100,figWidth,figHeight]); % gcf设置当前figure
% 图
linewidth_line = 1;

%% 处理数据
I = result_logic==1 & rt_logic_raw==1 & cond_switch==1;
rt_repeat = rt_raw(I);
I = result_logic==1 & rt_logic_raw==1 & cond_switch==2;
rt_switch = rt_raw(I);

hold on
h1 = cdfplot(rt_repeat);
h2 = cdfplot(rt_switch);

%% 图像后处理
grid off
set(h1,'Color','k','LineWidth',1);
set(h2,'Color','r','LineWidth',1);
xlabel('Response time (sec)');
ylabel({'Cumulative','distribution'});
set(gca,'tickdir','out');
xticks([1 2 3 4 5]);
delete(title(''));

%% 保存图像
figurename = ['cdf_subject_'];
print(f1,[figurename,keyword(1:3)],'-r300','-dtiff');









