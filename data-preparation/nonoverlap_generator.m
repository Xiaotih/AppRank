% generate nonrolling windows

load('../clean-data/dataset-3.mat');

test_downloads_raw = cell(1,5);
test_pred_raw = cell(1,5);
train_downloads_raw = cell(1,5);
train_pred_raw = cell(1,5);

test_downloads_nonoverlap = cell(1,5);
train_downloads_nonoverlap = cell(1,5);

tmp_down = [all_downloads_shuffled{1}(:,1)'];
for i = 1:8
    range = 2+7*(i-1):1+7*i;
    tmp = all_downloads_shuffled{1}(:,range);
    tmp(tmp < 0) = 0;
    week_sum = sum(tmp,2);
    tmp_down = [tmp_down;week_sum'];
end

downloads_nonoverlap = tmp_down';

tmp = all_downloads_shuffled{1};
num = size(tmp,1);
partition_len = ceil(size(tmp,1)/5);

for i = 1:5
    test_range = 1+partition_len*(i-1):min(partition_len*i, size(tmp,1));
    test_downloads_raw{i} = tmp(test_range);
    test_downloads_nonoverlap{i} = downloads_nonoverlap(test_range,:);
    test_pred_raw{i} = all_pred_shuffled(test_range,:);
    
    train_downloads_raw{i} = tmp;
    train_downloads_raw{i}(test_range,:) = [];
    train_downloads_nonoverlap{i} = downloads_nonoverlap;
    train_downloads_nonoverlap{i}(test_range,:) = [];
    
    train_pred_raw{i} = all_pred_shuffled;
    train_pred_raw{i}(test_range,:) = [];
end

save('../clean-data/dataset-3.mat', 'test_downloads_raw', 'test_pred_raw', ...
                                    'train_downloads_raw', 'train_pred_raw', ...
                                    'train_downloads_nonoverlap', 'test_downloads_nonoverlap',...
                                    '-append');


