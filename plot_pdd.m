coh_list = unique(coh);
f1 = figure(1);
figWidth = 806.4;
figHeight = 184;
set(gcf,'unit','pixels','position',[10,100,figWidth,figHeight]); % gcf…Ë÷√µ±«∞figure

for k = 1:11
    I = result_logic==1 & rt_logic_raw==1 & coh==coh_list(k) & cond_switch==1;
    rt_coh_repeat = rt_raw(I);
    I = result_logic==1 & rt_logic_raw==1 & coh==coh_list(k) & cond_switch==2;
    rt_coh_switch = rt_raw(I);
    
    nbins = 10;
    bmin = min([rt_coh_repeat;rt_coh_repeat]);
    bmax = max([rt_coh_repeat;rt_coh_repeat]);
    
    subplot(2,6,k)
    hold on
    histogram(rt_coh_switch,nbins,'BinLimits',[bmin,bmax],'Normalization','probability',...
        'EdgeAlpha',0,'FaceColor','r','FaceAlpha',1);
    histogram(rt_coh_repeat,nbins,'BinLimits',[bmin,bmax],'Normalization','probability',...
        'EdgeColor','k','FaceAlpha',0);
    title(['coh = ',num2str(coh_list(k))]);
    set(gca,'tickdir','out');
    if k==7
        ylabel('Probability');
        xlabel('RT (sec)')
    end
end

%% Save figure
figurename = ['pdd_subject_'];
print(f1,[figurename,keyword(1:3)],'-r300','-dtiff');


