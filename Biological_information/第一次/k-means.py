# 教育机构：哔哩哔哩
# 学   生：何晓曦
# 时   间：2021年10月

import numpy as np
import matplotlib.pyplot as plt
import xlrd

color_list = ['yellow','red','greec','purple','black']


def classify(data, centers):

    length = centers.shape[0]

    classes = [[] for i in range(length)]

    sumDis = 0
    for i in range(data.shape[0]):
        per_data = data[i]
        diffMat = np.tile(per_data,(length,1)) - centers

        sqDiffMat = diffMat**2
        sqDisMat = sqDiffMat.sum(axis=1)

        sortedIndex = sqDisMat.argsort()

        classes[sortedIndex[0]].append(list(per_data))

        sumDis += sqDisMat[sortedIndex[0]]
    return classes,sumDis


def upCenters(classes):
    centers = []
    for i in range(len(classes)):
        per_class = classes[i]
        per_class = np.array(per_class)
        center = per_class.sum(axis=0)/len(per_class)
        centers.append(center)
    return np.array(centers)


def kmeans(data,centers,sumDis):

    #聚类
    classes,new_sumDis = classify(data,centers)

    #修改中心点
    if sumDis == new_sumDis:
        return

    new_centers = upCenters(classes)

    for i in range(len(new_centers)):
        center = centers[i]
        plt.scatter(center[0],center[1],s = 16*np.pi**2,marker='x',c=color_list[i])

    for i in range(len(classes)):
        per_class = classes[i]
        for c in per_class:
            plt.scatter(c[0],c[1],c = color_list[i])

    plt.title('sumDis%f'%new_sumDis)
    plt.show()

    kmeans(data,new_centers,new_sumDis)
    #再聚类
    #再修改中心点
    #判断是否停止

def getData(xlsx):
    workbook = xlrd.open_workbook(xlsx)
    worksheet = workbook.sheet_by_index(0)
    nrows,ncols = worksheet.rows,worksheet.ncols

    data = []

    for i in range(nrows):
        temp = []
        for j in range(ncols):
            temp.append(worksheet.cell_value(i,j))
        data.append(temp)
    return np.array(data)

if __name__ == '__main__':
    data = getData(r'data.xlsx')
    centers = data[:3]
    kmeans((data,centers,0))