function [] = individual_chrono_fun_2cond(cond, coh, rt, opt)

def.legend = {'cond 1', 'cond 2'};
if exist('opt', 'var')
    opt = safeStructAssign(def, opt);
else
    opt = def;
end
% resp = 1 or 2
% cond = 1 or 2

%% fit to hyperbolic tangent

fcoh = linspace(min(coh), max(coh), 100);

[beta1,resid1,~,Sigma1] = nlinfit(abs(coh(cond==1)), rt(cond==1), @hyperbolic_fun, [1 .02 .3]);
frt1 = hyperbolic_fun(beta1, abs(fcoh));
ci_beta1 = nlparci(beta1, resid1, 'covar', Sigma1);

fprintf('cond1: beta1 = %1.3f (CI: %1.3f-%1.3f)\n', beta1(1), ci_beta1(1,1), ci_beta1(1,2));
fprintf('cond1: beta2 = %1.3f (CI: %1.3f-%1.3f)\n', beta1(2), ci_beta1(2,1), ci_beta1(2,2));
fprintf('cond1: beta3 (non-DT) = %1.3f (CI: %1.3f-%1.3f)\n', beta1(3), ci_beta1(3,1), ci_beta1(3,2));

[beta2,resid2,~,Sigma2] = nlinfit(abs(coh(cond==2)), rt(cond==2), @hyperbolic_fun, [1 .02 .3]);
frt2 = hyperbolic_fun(beta2, abs(fcoh));
ci_beta2 = nlparci(beta2, resid2, 'covar', Sigma2);

fprintf('cond2: beta1 = %1.3f (CI: %1.3f-%1.3f)\n', beta2(1), ci_beta2(1,1), ci_beta2(1,2));
fprintf('cond2: beta2 = %1.3f (CI: %1.3f-%1.3f)\n', beta2(2), ci_beta2(2,1), ci_beta2(2,2));
fprintf('cond2: beta3 (non-DT) = %1.3f (CI: %1.3f-%1.3f)\n', beta2(3), ci_beta2(3,1), ci_beta2(3,2));


%% averaging
ucoh = unique(coh);
[p1, pse1] = calcGroupMean(rt(cond==1), coh(cond==1), ucoh);  % error
[p2, pse2] = calcGroupMean(rt(cond==2), coh(cond==2), ucoh);

%% plot
hold on;
h1 = plot(fcoh, frt1, 'k');
plot(ucoh, p1, '.k', 'markers' ,10);
cerrorbar(ucoh, p1, pse1, 'k');
h2 = plot(fcoh, frt2, 'r');
plot(ucoh, p2, '.r', 'markers' ,10);
cerrorbar(ucoh, p2, pse2, 'r');
axis square;
xlabel('Coherence');
ylabel('RT (sec)');

% legend([h1, h2], opt.legend, 'position', [.75 .75 .05 .05]);
% legend boxoff;
% format_panel(gca, 'ylim', [0.6 1.6]); % subject 001
format_panel(gca, 'ylim', [0.5 2.5]); % subject 002
% xticklabels([])
% fontsize_label = 9;
% set(gca,'fontsize',fontsize_label);
end
