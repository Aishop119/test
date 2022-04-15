import numpy as np
import pandas as pd
from pandas import DataFrame

crime = pd.read_csv('crime_boston.csv',low_memory=False)
# print(crime.isnull())
# crime.info()
# rows=crime.isnull().any(axis=1)
# # print(crime[rows])
# print(crime.isnull().any(axis=1))#输出哪一列都是空的
print(crime.isnull().any(axis=0))#输出哪一行都是空的
# rows_with_missing_values = crime.isnull().any(axis=1)
# print(crime[rows_with_missing_values])
cleaned_crime = crime.drop(columns=['YEAR','MONTH','HOUR','Location'])
# print(cleaned_crime)
size_cleaned_crime=cleaned_crime['OFFENSE_CODE_GROUP'].unique()
# print(size_cleaned_crime)
# print(size_cleaned_crime.size)
# cleaned_crime['OFFENSE_CODE_GROUP'] = cleaned_crime['OFFENSE_CODE_GROUP'].replace({'HUMAN TRAFFICKING - INVOLUNTARY SERVITUDE':'Human Trafficking - Involuntary Servitude'})
# cleaned_crime['OFFENSE_CODE_GROUP'] = cleaned_crime['OFFENSE_CODE_GROUP'].replace({'HOME INVASION':'Home Invasion'})
# cleaned_crime['OFFENSE_CODE_GROUP'] = cleaned_crime['OFFENSE_CODE_GROUP'].replace({'HUMAN TRAFFICKING':'Human Trafficking'})
# cleaned_crime['OFFENSE_CODE_GROUP'] = cleaned_crime['OFFENSE_CODE_GROUP'].replace({'INVESTIGATE PERSON':'Investigate Person'})
# size_cleaned_crime=cleaned_crime['OFFENSE_CODE_GROUP'].unique()
# print(size_cleaned_crime)
# print(size_cleaned_crime.size)
# print(cleaned_crime['OFFENSE_DESCRIPTION'].unique())
# print(cleaned_crime['DAY_OF_WEEK'].unique())
