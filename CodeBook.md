
Data subject_train, X_train, y_train, X_test, y_test, subject_test, features, activity_labels are all read 
from the given directory.

Variables X, subject, y are the results of merging the training and the test sets separately.

X2 is the extracted data set of X, only containing measurements on the mean and standard deviation.

activity is used to relate the activity_code with its name.

logi is a logical vector for finding the locations for corresponding activity_labels.

Dtdt is the required descriptive data set.

s is a list containing 180 required groups. Each corresponds to a subject and an activity.

sub is another list containing the mean of each element of s.

tidy_data is the final data containing the average of each variable of every subject and every activity.
