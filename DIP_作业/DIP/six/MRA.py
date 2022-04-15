import cv2
import matplotlib.pyplot as plt
import numpy as np

np.seterr(divide='ignore', invalid='ignore')
import SimpleITK as sitk


def plt_hist(img):
    plt.hist(img.ravel(), 256, [0, 256])

    # plt.show()


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


def Otsu(img):
    img_vector = img.flatten()
    pixel_counter = np.zeros(256)
    for pixel_value in img_vector:
        pixel_counter[pixel_value] += 1

    min_variance = np.inf
    best_threshold = 0
    pixel_value = np.arange(256)
    for threshold in range(256):

        pixel_value_A = pixel_value[0:threshold]
        pixel_value_B = pixel_value[threshold:]

        totalPixelNum_A = np.sum(pixel_counter[pixel_value_A])
        totalPixelNum_B = np.sum(pixel_counter[pixel_value_B])

        Probability_pixelvalue_A = pixel_counter[pixel_value_A] / totalPixelNum_A
        Probability_pixelvalue_B = pixel_counter[pixel_value_B] / totalPixelNum_B

        meanPixelValue_A = np.sum(pixel_value_A * Probability_pixelvalue_A)
        meanPixelValue_B = np.sum(pixel_value_B * Probability_pixelvalue_B)

        varianceA = np.sum(Probability_pixelvalue_A * (pixel_value_A - meanPixelValue_A) ** 2)
        varianceB = np.sum(Probability_pixelvalue_B * (pixel_value_B - meanPixelValue_B) ** 2)

        current_total_variance = totalPixelNum_A * varianceA + totalPixelNum_B * varianceB
        if current_total_variance < min_variance:
            min_variance = current_total_variance
            best_threshold = threshold

    return best_threshold
    # print(best_threshold)


def RCOtsu(img, min, max):
    temp = max - min + 1
    img_vector = img.flatten()
    pixel_counter = np.zeros(256)
    for pixel_value in img_vector:
        if (pixel_value >= min):
            if (pixel_value <= max):
                pixel_counter[pixel_value] += 1

    min_variance = np.inf
    best_threshold = 0
    pixel_value = np.arange(temp)
    for threshold in range(temp):

        pixel_value_A = pixel_value[min:threshold]
        pixel_value_B = pixel_value[threshold:max]

        totalPixelNum_A = np.sum(pixel_counter[pixel_value_A])
        totalPixelNum_B = np.sum(pixel_counter[pixel_value_B])

        Probability_pixelvalue_A = pixel_counter[pixel_value_A] / totalPixelNum_A
        Probability_pixelvalue_B = pixel_counter[pixel_value_B] / totalPixelNum_B

        meanPixelValue_A = np.sum(pixel_value_A * Probability_pixelvalue_A)
        meanPixelValue_B = np.sum(pixel_value_B * Probability_pixelvalue_B)

        varianceA = np.sum(Probability_pixelvalue_A * (pixel_value_A - meanPixelValue_A) ** 2)
        varianceB = np.sum(Probability_pixelvalue_B * (pixel_value_B - meanPixelValue_B) ** 2)

        current_total_variance = totalPixelNum_A * varianceA + totalPixelNum_B * varianceB
        if current_total_variance < min_variance:
            min_variance = current_total_variance
            best_threshold = threshold

    # print(best_threshold)
    ret, binary = cv2.threshold(img, best_threshold, 255, cv2.THRESH_BINARY)
    cv2.imwrite('grayImg.jpg', binary)
    cv2.imshow('srcImg', binary)


if __name__ == "__main__":
    imgfile = 'MRA.pgm'
    imgrefile='MRA_Reference.pgm'
    grayImg = cv2.imread(imgfile)
    img_ref = cv2.imread(imgrefile)
    # cv2.imshow('srcImg', img)
    # cv2.imwrite('grayImg.jpg', grayImg)
    # cv2.imshow('grayimg', grayImg)
    # plt_hist(grayImg)

    k_opt = Otsu(grayImg)
    RCOtsu(grayImg,40,120)
    # thr, imgBin = cv2.threshold(grayImg, k_opt, 255, type=cv2.THRESH_BINARY)  # 设阈值二值化
    # computeQualityMeasures(img_ref,grayImg)
    # cv2.imwrite('imgBin.jpg', imgBin)
    # cv2.imshow('Ostu ' , imgBin)

    cv2.waitKey(0)
    img_ref = cv2.imread('MRA_Reference.jpg')
    img_otsu = cv2.imread('imgBin.jpg')
    img_bin = cv2.imread('grayImg.jpg')
    print(computeQualityMeasures(img_ref, img_otsu))
    print(computeQualityMeasures(img_ref, img_bin))