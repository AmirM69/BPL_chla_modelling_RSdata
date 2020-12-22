addpath('..\Accessory_codes_MATLAB')

y = load('y.mat');  y = y.y;
y_pred = load('y_pred.mat');  y_pred = y_pred.y_pred;


X = 10 .^ y;
%Y = chlPFC
Y = 10 .^ y_pred;

figure;
scatter(X, Y,  'filled' , 'b');
 line([1 max(X)+50],[1 max(X)+50], 'color', 'r', 'LineStyle','--') ;
set(gca, 'XTick', [1 10 100], 'xticklabel', {'1', '10', '100'});
set(gca, 'YTick', [1 10 100], 'yticklabel', {'1', '10', '100'});
%  set(gca, 'YTick', [1 2 3 4 5 6], 'yticklabel', {'1' '2' '3' '4' '5' '6'});
set(gca, 'YScale', 'log');
set(gca, 'XScale', 'log');

axis tight
axis square
grid on
box on

xlabel('In-vitro chla (mg/m^3)', 'fontsize', 14);
%ylabel('Factory-calibrated chla (mg/m^3)', 'fontsize', 12);
ylabel('RS Predicted chla (mg/m^3)', 'fontsize', 14);

%legend('chl_P_{chl} vs. chl_M', '1:1 line', 'fontsize', 12, 'location' , 'southeast');
%legend('chl_P_{pc} vs. chl_M', '1:1 line', 'fontsize', 12, 'location' , 'southeast');
legend('chl_P^{RS} vs. chl_M', '1:1 line', 'fontsize', 14, 'location' , 'southeast');

MAE = 10^errperf(log10(X), log10(Y),'mae');
Bias = 10^errperf(log10(X), log10(Y),'bias');      %% be careful about the order of inputs for this metric to be consistent with the equation in the paper, for paper 2 swap X and Y in this equation to have comparable results with Pahlevan
RMSLE = errperf(log10(X), log10(Y),'rmse');
MAPE = errperf(X, Y,'mape');
RMSE = errperf(X, Y,'rmse');
metrics = {'MAE', MAE; 'Bias' , Bias; 'RMSLE', RMSLE; 'MAPE', MAPE; 'RMSE' , RMSE};
correlation = corrcoef(log10(X),log10(Y));
rho = correlation(2);

% text(0.05, 0.85, ['f = ' eq],'Units','normalized','Interpreter', 'none', 'FontSize', 11)
text(0.05, 0.95, ['N = ' num2str(length(X))],'Units','normalized', 'Interpreter', 'tex', 'FontSize', 13)
%text(0.05, 0.90, ['\rho = ' num2str(round(rho,2))],'Units','normalized', 'FontSize', 11)
% text(0.05, 0.90, ['r^2 = ' num2str(round(n.rsquare,2))],'Units','normalized', 'FontSize', 11)
for i = 1:length(metrics)
%     if i ==2 
%             text(0.05, 0.95 - (0.05)*i   , [char(metrics(i,1)) ' = ' char(string((cell2mat(metrics(i,2)))))],'Units','normalized', 'Interpreter', 'none', 'FontSize', 11)
%     else
    text(0.05, 0.95 - (0.06)*i   , [char(metrics(i,1)) ' = ' char(string((round(cell2mat(metrics(i,2)),2))))],'Units','normalized', 'Interpreter', 'none', 'FontSize', 13)
end
%text(0.05, 0.65, ['\rho = ' num2str(round(rho,2))],'Units','normalized', 'FontSize', 11)

xlim([1 max(X)+50])
ylim([1 max(X)+50])


%         ax1_pos = ax1.Position; % position of first axes
%         ax2 = axes('Position',ax1_pos,...

%             'XAxisLocation','top',...
%             'Color','none');
%         set(gca, 'XScale', 'log');
%         set(gca, 'XTick', [70], 'xticklabel', {'70'});

fig = gca
saveas(fig, 'fig13-1', 'png')
