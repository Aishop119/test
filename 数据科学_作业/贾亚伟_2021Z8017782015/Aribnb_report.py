import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sn
listings=pd.read_csv('Airbnb_NYC_2019.csv',low_memory=False)
# print(listings)
#方法一
# sn.set_theme(style='darkgrid')
# sn.countplot(x='neighbourhood_group',data=listings)
# plt.show()
#方法二
# sn.barplot(x='neighbourhood_group',y='price',data=listings)
# plt.show()
#方法三
# sn.barplot(x='neighbourhood_group',y='price',data=listings,ci=False)
# plt.show()
#方法四
# sn.stripplot(x='neighbourhood_group',y='price',data=listings)
# plt.show()
#方法五
# sn.violinplot(x='neighbourhood_group',y='price',data=listings,ci=False)
# plt.show()
#方法六
# plt.hist(listings['price'],bins=np.arange(0,1100,40))
# plt.xlabel('price(in us dollars)')
# plt.show()
#方法七
plt.scatter(x=listings['price'],y=listings['number_of_reviews'],s=5)
plt.xlabel('price')
plt.ylabel('number of reviews')
plt.xlim(0,1100)
plt.show()