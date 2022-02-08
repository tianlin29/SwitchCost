function [] = individual_psych_fun_2cond(cond, coh, resp, opt)

def.legend = {'cond 1', 'cond 2'};
if exist('opt', 'var')
    opt = safeStructAssign(def, opt);
else
    opt = def;
end
% resp = 1 or 2
% cond = 1 or 2

%% logistic regression
fcoh = linspace(min(coh), max(coh), 100);

[beta, ~, stat] = glmfit([coh, cond==2], resp==2, 'binomial', 'link', 'logit');

fprintf('beta0 (bias) = %1.3f (p = %s)\n', beta(1), p2str(stat.p(1)));
fprintf('beta1 (slope) = %1.3f (p = %s)\n', beta(2), p2str(stat.p(2)));
fprintf('beta2 (condition dependent) = %1.3f (p = %s)\n', beta(3), p2str(stat.p(3)));

fresp1 = glmval(beta, [fcoh(:), zeros(length(fcoh),1)], 'logit');
fresp2 = glmval(beta, [fcoh(:), ones(length(fcoh),1)], 'logit');

%% averaging
ucoh = unique(coh);
[p1, pse1] = calcGroupMean(resp(cond==1)==2, coh(cond==1), ucoh, 'binary');
[p2, pse2] = calcGroupMean(resp(cond==2)==2, coh(cond==2), ucoh, 'binary');

%% plot
hold on;
h1 = plot(fcoh, fresp1, 'k');
plot(ucoh, p1, '.k', 'markers' ,10);
cerrorbar(ucoh, p1, pse1, 'k');
h2 = plot(fcoh, fresp2, 'r');
plot(ucoh, p2, '.r', 'markers' ,10);
cerrorbar(ucoh, p2, pse2, 'r');
axis square;
xlabel('Coherence');
ylabel('P (resp=2)');

% legend([h1, h2], opt.legend, 'position', [.75 .4 .05 .05]);
% legend([h1, h2], opt.legend,'Location','Best');
% legend boxoff;
format_panel(gca, 'ylim', [0 1], 'ytick', 0:.25:1);
% xticklabels([])
% fontsize_label = 9;
% set(gca,'fontsize',fontsize_label);


end
