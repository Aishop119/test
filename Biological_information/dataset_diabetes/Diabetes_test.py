import pandas as pd
import pandas_profiling
import matplotlib
matplotlib.use('TkAgg')
import matplotlib.pyplot as plt

import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from matplotlib.pyplot import figure
data = pd.read_csv("diabetic_data.csv")
# print(len(data))
# print(data.head(10))
pandas_profiling.ProfileReport(data)
data = data.set_index('encounter_id')#以encounter_id最为每一位患者的唯一标识符
repeated_patients = (data["patient_nbr"].value_counts()[data["patient_nbr"].value_counts() > 1]).index
# print(len(repeated_patients))#发现同一患者会有一个遭遇ID但会有多个患者id
countcol = data['patient_nbr'].value_counts().to_dict() #converts to dictionary
data['Visits'] = data['patient_nbr'].map(countcol)

def dropEntireColumn(column):
    data.drop([column], axis = 1, inplace=True)

dropEntireColumn('patient_nbr')

def plotHistOfCol(column, title):
    plt.figure(figsize=(20,10))
    plt.xticks(rotation=45, fontsize=12.5)
    plt.hist(data[column].sort_values().astype(str), bins=range(len(data[column].unique())+1), align='left')
    plt.title(title, fontsize=20)
    plt.show()


# plotHistOfCol('Visits', 'Histogram of visits to hospital')

def dropRowsbyColValue(colname,value):
    # Get index of rows with question marks in race column
    indexOfRows = data[data[colname] == value].index
    # Deleting rows by index
    data.drop(indexOfRows, inplace=True)

dropRowsbyColValue('race','?')
# plotHistOfCol('race', 'Histogram by race')
dummy = pd.get_dummies(data['race'])
data = pd.concat([data, dummy], axis=1)
data.drop(['race'], inplace=True, axis=1)

dropRowsbyColValue('gender','Unknown/Invalid')
# plotHistOfCol('gender','Histogram by gender')
data['gender'] = data['gender'].replace('Female' , 1)
data['gender'] = data['gender'].replace('Male' , 0)#将男性改为0  女性为1

# plotHistOfCol('age', 'Histogram by age')
ageranks = data['age'].unique()
ageranks = list(ageranks)
for i in ageranks:
    value = i
    newvalue = int(i[1])*10+5
    data.loc[(data.age == value),'age'] = newvalue
print(data['age'].unique())#将年龄的范围值改为[5 15 25 35 45 55 65 75 85 95]





