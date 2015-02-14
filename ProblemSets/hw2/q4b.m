function q4b()
% This script requires the following functions to be implemented:
% q4_nb_train
% q4_nb_predict
% q4_top_words

assert(checking('q4b')==0);

S = load('spamdata.mat');
X = S.trainsetX;
Y = S.trainsetY;

clear S;

k = 6;

feature_names = textread('spambase_names.txt', '%s');

[phi_y0, phi_y1, phi_prior] = q4_nb_train(X, Y);

word_idx = q4_top_words(phi_y0, phi_y1, phi_prior, k);

for i=1:size(word_idx,1)
    str = feature_names{word_idx(i,1)};
    for j=2:size(word_idx,2)
        str = [str ', ' feature_names{word_idx(i,j)}];
    end
    fprintf('Top %d words for class %d: %s.\n', k, i-1, str);
end