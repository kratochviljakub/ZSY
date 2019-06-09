%% read and prepare data
clear
data = readtable('tic-tac-toe.csv');
strs = {'x', 'o', 'b', 'positive', 'negative'};
replaces = {'1', '-1', '0', '1', '-1'};
for i = 1:length(strs)
    str = strs(i);
    replace = replaces(i);
    for j = 1:height(data)
        for k = 1:width(data)
            if strcmp(cell2mat(table2array(data(j,k))), str{1})
                data(j,k) = replace;
            end
        end
    end
end
data.Properties.VariableNames = {'x_1' 'x_2' 'x_3' 'x_4' 'x_5' 'x_6' 'x_7' 'x_8' 'x_9' 'winner'};
shuffled_data = data(randperm(size(data,1)),:);
train_data = shuffled_data(1:floor(end/2),:);
test_data = shuffled_data(floor(end/2)+1:end,:);

%% decision tree
tree = fitctree(train_data,train_data(:,10))
view(tree,'Mode','graph')

%% evaluation
label = predict(tree, test_data);
counter = 0;
for i = 1:length(label)
   if strcmp(label{i}, test_data(i,10))
       counter = counter + 1;
   end
end
disp(['Number of poorly classified vectors = ', num2str(counter), '.'])

                