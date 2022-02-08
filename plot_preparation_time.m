%% 图像预设
f1 = figure('color', 'w');
figWidth = 1.0392e+03;
figHeight = 407.2;
set(gcf,'unit','pixels','position',[0,100,figWidth,figHeight]); % gcf设置当前figure
    
%% 数据处理
I = ~isnan(prep_time);
a = mean(prep_time(I));
c = std(prep_time(I));
I = prep_time>(a+3*c) | prep_time<(a-3*c);
prep_time_3c = prep_time;
prep_time_3c(I) = NaN;

pt_num = 3; % 把准备时间PT分成几份（再加1） 
pt_list = linspace(min(prep_time_3c),max(prep_time_3c),pt_num+1);
for k = 1:pt_num
    def.legend = {'non-switch', 'switch'};
    
    I1 = result_logic==1 & rt_logic_raw==1 & ~isnan(prep_time_3c) & cond_switch==1;
    I2 = result_logic==1 & rt_logic_raw==1 & ~isnan(prep_time_3c) & cond_switch==2 & ...
        prep_time_3c>=pt_list(k) & prep_time_3c<pt_list(k+1);
    I = I1 | I2;
    
    subplot(2,pt_num,k)
    title({['PT \in [',num2str(pt_list(k),2),',',num2str(pt_list(k+1),2),')'];...
        [num2str(sum(I2)),' switch trials'];...
        ''});
    individual_psych_fun_2cond(cond_switch(I), coh(I), resp(I), def);
    
    subplot(2,pt_num,k+pt_num)
    individual_chrono_fun_2cond(cond_switch(I), coh(I), rt_raw(I), def);
    
end


%% Save
figurename = ['prep_time_subject_'];
print(f1,[figurename,keyword(1:3)],'-r300','-dtiff');
