import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
WorldCups=pd.read_csv(r'WorldCups.csv')
sns.set_theme(style='darkgrid')
# print(WorldCups.tail(10))
# print(WorldCups.info())
WorldCups.isnull().values.any()

# print(WorldCups.describe())

# sns.distplot(WorldCups['MatchesPlayed'])
# plt.show()
# print(WorldCups['Winner'].value_counts())

n1 = WorldCups['QualifiedTeams'].mean()
n2 = WorldCups['QualifiedTeams'].median()
n3 = WorldCups['QualifiedTeams'].mode()[0]
# print(n1   ,n2    ,n3)

plt.figure(figsize=(8,6))
sns.countplot(x=WorldCups['Winner'])
plt.title('Country played matches between 1990 to 2014')
plt.xlabel('Country')
plt.ylabel('Frequency')
plt.show()



