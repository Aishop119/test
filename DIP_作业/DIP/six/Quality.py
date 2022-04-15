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
img_otsu=cv2.imread('imgBin.jpg')
img_bin=cv2.imread('grayImg.jpg')
print(computeQualityMeasures(img_ref,img_otsu))
print(computeQualityMeasures(img_ref,img_bin))

