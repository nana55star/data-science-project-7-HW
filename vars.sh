
# In order to remove the commas inside the quotes, we can either use sed (sed 's/,*\([^"]\)/\1/g;s/\([^"]\),*/\1/g') to remove the commas between the text inside quotes 
#and leave the comma that seperates the first and second column
# also the for loop is doing the same thing for each row by removing the commas inside the quotes using gsub for each raw 
# to be able to get the second column in the csv file using cut
# cut is used to get the second column (-f 5) of the csv file using the comma as field delimiter (-d ,)
#search using grep for the number word positive and negative word appeard

Positive_count=$(awk -F\" '{for (i=2; i<=NF; i+=2) gsub(/,/,"",$i)} 1' OFS="" 'IMDB Dataset.csv'  | cut -d , -f 2 |  grep positive | wc -l)
echo 'Positive count'=$Positive_count > analysis.txt

negative_count=$(awk -F\" '{for (i=2; i<=NF; i+=2) gsub(/,/,"",$i)} 1' OFS="" 'IMDB Dataset.csv'  | cut -d , -f 2 |  grep negative | wc -l)
echo 'Negative count'=$negative_count >> analysis.txt

# I  used wc -l to know the number of lines which is 50001 including the headers of the csv file, then I used cat to get all the text in the file (note: tail -n 5000 can be used to not include the headers
#then remove punctation starting with making capital letters to small leters using tr and then remove the other punctation #?"
# and replace them with space and then remove numbers
# also make the double spaces to be one space
# and we can use -s to squeeze the repetition of characters.
# and break sentence to words tr "  '\n
# sort the words  and then use uniqu to obtain a unique count of the sorted words and then we can sort them a gain according the most repeated word or
# directly use wc -w to find the number of the unique words

Total_unique_words=$(cat 'IMDB Dataset.csv' | tr 'A-Z' 'a-z' | sed 's/--/ /g' | tr [:punct:] " " |  tr -d [:digit:] | tr '\n' " " |  tr -s " " | tr " " '\n' |  sort | uniq | sort -r -n | wc -w)
echo 'Total unique words' = $Total_unique_words >> analysis.txt

# To find the number of lines where 'negative is mentioned in all the csv file 
negative_count_all_words_in_file=$(cat 'IMDB Dataset.csv' |  grep 'negative' | wc -l) #25363
echo 'negative count in all lines in the file'=$negative_count_all_words_in_file >> analysis.txt

# To find the number of lines where 'positive is mentioned in all the csv file
Positive_count_all_words_in_file=$(cat 'IMDB Dataset.csv' |  grep 'positive' | wc -l) #25665
echo 'Positive count in all lines in the file'=$Positive_count_all_words_in_file >> analysis.txt

#to get better results for unique words I used cat to get all text in the csv columns divided by ,
# sed 's/<[^>]*>//g' is used to remove the html tage <br />
# then remove punctation starting with making capital letters tosmall leters using tr and then remove the other punctation
# also make the double spaces to be one space
# and we can use -s to squeeze the repetition of characters.
# and break sentence to words tr "  '\n
# sort the words  and then use uniqu to obtain a unique count of the sorted words and then we can sort them a gain according the most repeated word or
# directly use wc -w to find the number of the unique words

Total_unique_words2=$(cat 'IMDB Dataset.csv' | tr 'A-Z' 'a-z'  | sed 's/<[^>]*>//g' | sed 's/--/ /g' | tr [:punct:] " " |  tr -d [:digit:] | tr '\n' " " |  tr -s " " | tr " " '\n' |  sort | uniq | sort -r -n | wc -w)
echo 'Total unique words2' = $Total_unique_words2 >> analysis.txt

# kepping digits
Total_unique_words3=$(cat 'IMDB Dataset.csv' | tr 'A-Z' 'a-z'  | sed 's/<[^>]*>//g' | sed 's/--/ /g' | tr [:punct:] " " | tr -s " " | tr " " '\n' |  sort | uniq | sort -r -n | wc -w) #106166
echo 'Total unique words3' = $Total_unique_words3 >> analysis.txt

# use tr [:punct:] and tr [:digits:] to only remove the punctuation and digits
Total_unique_words4=$(cat 'IMDB Dataset.csv' | sed 's/<[^>]*>//g' | tr [:punct:] " " | tr -d [:digit:] | tr -s " " | tr " " '\n' |  sort | uniq | sort -r -n | wc -w)
echo 'Total unique words4' = $Total_unique_words4 >> analysis.txt

#use tr [:punct:] only to only remove the punctuation
Total_unique_words5=$(cat 'IMDB Dataset.csv' | sed 's/<[^>]*>//g' | tr [:punct:] " " | tr -s " " | tr " " '\n' |  sort | uniq | sort -r -n | wc -w) #134330
echo 'Total unique words5' = $Total_unique_words5 >> analysis.txt

