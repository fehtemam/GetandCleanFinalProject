Getting and Cleaning Data :: Course project
===========================================

### Step1 : Merging the training and the test sets to create one data set
First we download the .zip file of the data into the R working directory and extract it. Then we use *read.table* to read
the subjects, the activities and the measurements files for both training and test data sets. This will give us 6 data frames (3 for training and 3 for test). We also extract the activity names (Laying, Sitting, ...) from the *activity_labels.txt* file. Then before we concatenate training and test datasets we change the column names for the subject and activity datasets so instead of V1 or V2 we have different column names for them. We do this so we can easily distinguish them from the column names of the measurements data frame in case we later want to look for them. Finally we use *cbind* to merge the measurements, subjects and activities data frames for each of the training and test data and we use *rbind* to merge these two new datasets into a single dataset that includes the data of measurements, subjects and activities for both training and test data. 

### Step2 : Extracting the measurements on the mean and standard deviation
Using *read.table* we read the names for all measurements from *features.txt* file. We use the command *grep* to extract the names that include *mean()* or *std()*. Notice that in the dataset there are some measures with the name *mean* but they are not calculated as part of a statistical measure. For instance, average of a variable in frequency domain might be calculated to be used in a specific analysis. We are not interested in these measurements. So we only extract the ones with *mean()* and *std()* (the parentheses is part of the pattern and not a regex). We extract both the indices and the names for those measurements. We then use the indices to subset the original dataset and create a new data frame (i.e. *subData*) that also includes the subject and the activity columns. This gives us 68 columns (66 for measurements + subject + activity).    

### Step3 : Using descriptive activity names to name activities in data set
We use the activity labels that we extracted before to replace the numbers in the activity column with their corresponding labels. Then we shuffle the column orders in a way that the subject column be the first column and after that the activity column and then the 66 columns for measurements. We also change the name of the activity column to *Activity*.

### Step4 : Appropriately labeling data set with descriptive variable names
We took care of this step in step 2. This was easier and more logical with the flow of the code. We used the descriptive names from *features.txt* file. How much descriptive these names are would be up to debate and is something subjective. We chose not to change the original names for two reasons. First, these names are subject specific and are common terminology in the field of movement science. The second reason was that changing std to standarddeviation or GravityAcc to gravityacceleration does not make the names more human readable. Different people might have different opinions on this but this doesn't change the efficiency of our code to generate tidy dataset. 

### Step5 : Creating tidy data with average of each variable for each activity and subject
We use *dplyr* package for this last step. We group the dataset by subject and activity using group_by. Then we use summarize_each command to calculate the average of each measurement per subject per activity. Finally we use write.table to export our tidy dataset to a *.txt* file. Our tidy datset has 180 rows (30 subjects * 6 activities). 



