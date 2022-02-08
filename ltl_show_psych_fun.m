function ltl_show_psych_fun(coh, resp)

% resp = 1 or 2

%% logistic regression
fcoh = linspace(min(coh), max(coh), 100);

[beta, ~, stat] = glmfit(coh, resp==2, 'binomial', 'link', 'logit');

fprintf('beta0 (bias) = %1.3f (p = %s)\n', beta(1), p2str(stat.p(1)));
fprintf('beta1 (slope) = %1.3f (p = %s)\n', beta(2), p2str(stat.p(2)));

fresp = glmval(beta, fcoh(:), 'logit');


%% averaging
ucoh = unique(coh);
[p, pse] = calcGroupMean(resp==2, coh, ucoh, 'binary');

%% plot
% fh = figure('color', 'w', 'position', [100 100 150 150]);
hold on;
plot(fcoh, fresp, 'k');
plot(ucoh, p, '.k', 'markers' ,12);
cerrorbar(ucoh, p, pse, 'k');
axis square;
xlabel('Coherence');
ylabel('P (resp=2)');
format_panel(gca, 'ylim', [0 1], 'ytick', 0:.25:1);

end
