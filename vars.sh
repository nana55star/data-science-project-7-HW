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

# I  used wc to know the number of lines which is 50001 including the headers of the csv file, then I used tail to not include the headers 
#then remove punctation starting with making capital letters tosmall leters using tr and then remove the other punctation #?" 
# and replace them with space and then remove numbers
# also make the double spaces to be one space
# and we can use -s to squeeze the repetition of characters.
#and break sentence to words tr "  '\n 
#sort the words  and then use uniqu to obtain a unique count of the sorted words and then we can sort them a gain according the most repeated word or 
# directly use wc -w to find the number of the unique words

Total_unique_words=$(tail -n 5000 'IMDB Dataset.csv' | tr 'A-Z' 'a-z' | sed 's/--/ /g' | tr [:punct:] " " |  tr -d [:digit:] | tr '\n' " " |  tr -s " " | tr " " '\n' |  sort | uniq | sort -r -n | wc -w)
echo 'Total unique words' = $Total_unique_words >> analysis.txt
