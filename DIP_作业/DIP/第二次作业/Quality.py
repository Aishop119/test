import SimpleITK as sitk
import cv2
import numpy as np
def computeQualityMeasures(lP, lT):
    quality = []
    labelPred = sitk.GetImageFromArray(lP, isVector=False)
    labelTrue = sitk.GetImageFromArray(lT, isVector=False)
    hausdorffcomputer = sitk.HausdorffDistanceImageFilter()
    hausdorffcomputer.Execute(labelTrue > 0.5, labelPred > 0.5)
    quality.append(hausdorffcomputer.GetAverageHausdorffDistance())
    quality.append(hausdorffcomputer.GetHausdorffDistance())

    dicecomputer = sitk.LabelOverlapMeasuresImageFilter()
    dicecomputer.Execute(labelTrue > 0.5, labelPred > 0.5)
    quality.append(dicecomputer.GetDiceCoefficient())

    return quality

img_ref=cv2.imread('MRA_Reference.jpg')
img_otsu=cv2.imread('img_mar_RCOtsu.jpg')
img_kmeans=cv2.imread('img_mar_k_means.jpg')
img_canny=cv2.imread('img_mar_canny.jpg')
print(computeQualityMeasures(img_ref,img_otsu))
print(computeQualityMeasures(img_ref,img_kmeans))
print(computeQualityMeasures(img_ref,img_canny))

