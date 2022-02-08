% 横纵轴字体有问题


%%
session_id = [ones(500,1); 2*ones(500,1); 3*ones(500,1); 4*ones(500,1); 5*ones(500,1); 6*ones(500,1)];
session_id_raw = zeros(length(resp),1);
session_id_raw(:) = NaN;
I = ~isnan(resp);
session_id_raw(I) = session_id;

%% which to plot
def.legend = {'non-switch', 'switch'};
f1 = figure(1);
set(gcf,'unit','centimeters','position',[0,0,8,21]);

I = result_logic==1 & rt_logic_raw==1 & session_id_raw==1;
subplot(6,2,1)
individual_psych_fun_2cond(cond_switch(I), coh(I), resp(I), def)
ylabel({'Session 1';''})
subplot(6,2,2)
individual_chrono_fun_2cond(cond_switch(I), coh(I), rt_raw(I), def)

I = result_logic==1 & rt_logic_raw==1 & session_id_raw==2;
subplot(6,2,3)
individual_psych_fun_2cond(cond_switch(I), coh(I), resp(I), def)
ylabel({'Session 2';''})
subplot(6,2,4)
individual_chrono_fun_2cond(cond_switch(I), coh(I), rt_raw(I), def)

I = result_logic==1 & rt_logic_raw==1 & session_id_raw==3;
subplot(6,2,5)
individual_psych_fun_2cond(cond_switch(I), coh(I), resp(I), def)
ylabel({'Session 3';''})
subplot(6,2,6)
individual_chrono_fun_2cond(cond_switch(I), coh(I), rt_raw(I), def)

I = result_logic==1 & rt_logic_raw==1 & session_id_raw==4;
subplot(6,2,7)
individual_psych_fun_2cond(cond_switch(I), coh(I), resp(I), def)
ylabel({'Session 4';''})
subplot(6,2,8)
individual_chrono_fun_2cond(cond_switch(I), coh(I), rt_raw(I), def)

I = result_logic==1 & rt_logic_raw==1 & session_id_raw==5;
subplot(6,2,9)
individual_psych_fun_2cond(cond_switch(I), coh(I), resp(I), def)
ylabel({'Session 5';''})
subplot(6,2,10)
individual_chrono_fun_2cond(cond_switch(I), coh(I), rt_raw(I), def)

I = result_logic==1 & rt_logic_raw==1 & session_id_raw==6;
subplot(6,2,11)
individual_psych_fun_2cond(cond_switch(I), coh(I), resp(I), def)
xlabel('Coherence')
ylabel({'Session 6';'P (resp=2)'})
xticklabels({-0.8,[],0,[],0.8})
subplot(6,2,12)
individual_chrono_fun_2cond(cond_switch(I), coh(I), rt_raw(I), def)
xlabel('Coherence');
ylabel('RT (sec)');
xticklabels({-0.8,[],0,[],0.8})

%%
hfig = f1;
figWidth = 8;
figHeight = 21;
set(hfig,'PaperUnits','centimeters');
set(hfig,'PaperPosition',[0 0 figWidth figHeight]);
figurename = ['subject_'];
print(hfig,[figurename,keyword(1:3)],'-r300','-dtiff');



