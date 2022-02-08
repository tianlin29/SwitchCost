%% 图像预设
f1 = figure(1);
figWidth = 298.6;
figHeight = 420;
set(gcf,'unit','pixels','position',[0,100,figWidth,figHeight]); % gcf设置当前figure

%% 数据处理
I = result_logic==1 & rt_logic_raw==1;
def.legend = {'non-switch', 'switch'};
subplot(2,1,1)
individual_psych_fun_2cond(cond_switch(I), coh(I), resp(I), def);
subplot(2,1,2)
individual_chrono_fun_2cond(cond_switch(I), coh(I), rt_raw(I), def);

%% 保存图像
figurename = ['switch_nonswitch_subject_'];
print(f1,[figurename,keyword(1:3)],'-r300','-dtiff');