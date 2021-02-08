function word_indices = processEmail(email_contents)
% Load Vocabulary
vocabList = getVocabList();
% Init return value
word_indices = [];
% Lower case
email_contents = lower(email_contents);
% Strip all HTML
email_contents = regexprep(email_contents, '<[^<>]+>', ' ');
% Look for one or more characters between 0-9
email_contents = regexprep(email_contents, '[0-9]+', 'number');
% Look for strings starting with http:// or https://
email_contents = regexprep(email_contents, ...
                           '(http|https)://[^\s]*', 'httpaddr');
% Handle Email Addresses
email_contents = regexprep(email_contents, '[^\s]+@[^\s]+', 'emailaddr');
% Handle $ sign
email_contents = regexprep(email_contents, '[$]+', 'dollar');

fprintf('\n==== Processed Email ====\n\n');
l = 0;
while ~isempty(email_contents)
    % get rid of any punctuation
    [str, email_contents] = ...
       strtok(email_contents, ...
              [' @$/#.-:&*+=[]?!(){},''">_<;%' char(10) char(13)]);
    % Remove any non alphanumeric characters
    str = regexprep(str, '[^a-zA-Z0-9]', '');
    % Stem the word 
    try str = porterStemmer(strtrim(str)); 
    catch str = ''; continue;
    end;
    % Skip the word if it is too short
    if length(str) < 1
       continue;
    end
  for i=1:length(vocabList), 
    if strcmp(vocabList{i} , str),
      word_indices = [word_indices; i];
    endif
  endfor 
    if (l + length(str) + 1) > 78
        fprintf('\n');
        l = 0;
    end
    fprintf('%s ', str);
    l = l + length(str) + 1;
end
fprintf('\n\n=========================\n');

end
