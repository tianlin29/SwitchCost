clc;clear
%% Search for data path based on keyword
ParentFolder = 'C:\Users\tianlin\Desktop\rotation in Oka lab\code repository\Psychpyscal_analysis_demo\data\formatted_data';
keyword = '002*eye.mat';
[DataNames_formatted] = get_data_from_folder(ParentFolder, keyword);

ParentFolder = 'C:\Users\tianlin\Desktop\rotation in Oka lab\code repository\Psychpyscal_analysis_demo\data\rawdata';
keyword = '002*.mat';
[DataNames_raw] = get_data_from_folder(ParentFolder, keyword);

%% Load data
data_formatted = combine_session_data(DataNames_formatted);
data_raw = combine_session_data(DataNames_raw);

%% Extract resp, cond, coh, result and rt
resp = cellfun(@(x)x.response,data_raw);
cond = cellfun(@(x)x.curr_task_set,data_raw);
coh = extract_coh(data_raw);
result = cellfun(@(x)x.result{1,1}, data_raw, 'UniformOutput', false);
rt = cellfun(@(x)x.rt,data_formatted);
fp_on = cellfun(@(x)x.event_time(1),data_raw);
stim_on = cellfun(@(x)x.event_time(3),data_raw);

%% ³õ²½´¦Àí
% prep_time
prep_time = stim_on-fp_on;
% cond_switch
cond_switch = [NaN; abs(diff(cond))+1]; % 1: non-switch, 2: switch
% remove fixation break
result_logic = result2logic(result); % 1: responded trials, 0: Fixation freak, No choice...
% remove RT=NaN
rt_logic = ones(size(rt,1),1);
I = isnan(rt);
rt_logic(I) = NaN;
% remove first trial of block
I = 1:100:length(rt);
rt_logic(I) = NaN; % 1: valid RT, NaN: removed RT

%% rt-->full size rt
rt_raw = zeros(length(cond),1);
I = ~isnan(resp);
rt_raw(I) = rt;
I = rt_raw==0;
rt_raw(I) = NaN;

rt_logic_raw = zeros(length(cond),1);
I = ~isnan(resp);
rt_logic_raw(I) = rt_logic;
I = rt_logic_raw==0;
rt_logic_raw(I) = NaN;

%% check
for k = 1:length(cond)
   data_post(k).cond = cond(k);
   data_post(k).cond_switch = cond_switch(k);
   data_post(k).coh = coh(k);
   data_post(k).resp = resp(k);
   data_post(k).result = result(k);
   data_post(k).result_logic = result_logic(k);
   data_post(k).rt_raw = rt_raw(k);
   data_post(k).rt_logic_raw = rt_logic_raw(k);
   data_post(k).prep_time = prep_time(k);
end

%% Functions
function data = combine_session_data(DataNames)
data = {};
for k = 1:length(DataNames)
    load(DataNames{k});
    data = [data; trial_data];
end
end

function coh = extract_coh(data)
coh = [];
for k = 1:size(data,1)
    d = data{k};
    if d.curr_task_set==1
        coh = [coh; d.morph_level(1)];
    else
        coh = [coh; d.morph_level(2)];
    end
end
end

% result2logic
function result_logic = result2logic(result)
result_sort = [];
for k = 1:size(result,1)
    result_sort = [result_sort; result{k,1}(1)];
end
result_logic = zeros(size(result,1),1);
I = result_sort=='W';
result_logic(I) = 1;
I = result_sort=='C';
result_logic(I) = 1;  % 0: responded trials, NaN: Fixation freak, No choice...
end

