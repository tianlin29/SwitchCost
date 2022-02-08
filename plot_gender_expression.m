% Plot psych and chrono function for (1) E-->G, (2) G-->G, (3) G-->E, (4)
% E--G.

%% 图像预设
f1 = figure(1);
figWidth = 526.4;
figHeight = 426.4;
set(gcf,'unit','pixels','position',[0,100,figWidth,figHeight]); % gcf设置当前figure

%% 数据处理
cond_g = zeros(length(cond),1);
I = cond==1 & cond_switch==1;
cond_g(I) = 1;
I = cond==1 & cond_switch==2;
cond_g(I) = 2;

cond_e = zeros(length(cond),1);
I = cond==2 & cond_switch==1;
cond_e(I) = 1;
I = cond==2 & cond_switch==2;
cond_e(I) = 2;

I = result_logic==1 & rt_logic_raw==1 & cond_g~=0;
def.legend = {'G-G', 'E-G'};
subplot(2,2,1)
individual_psych_fun_2cond(cond_g(I), coh(I), resp(I), def);
subplot(2,2,3)
individual_chrono_fun_2cond(cond_g(I), coh(I), rt_raw(I), def);
format_panel

I = result_logic==1 & rt_logic_raw==1 & cond_e~=0;
def.legend = {'E-E', 'G-E'};
subplot(2,2,2)
individual_psych_fun_2cond(cond_e(I), coh(I), resp(I), def);
subplot(2,2,4)
individual_chrono_fun_2cond(cond_e(I), coh(I), rt_raw(I), def);
format_panel

%% Save
figurename = ['EG_subject_'];
print(f1,[figurename,keyword(1:3)],'-r300','-dtiff');
