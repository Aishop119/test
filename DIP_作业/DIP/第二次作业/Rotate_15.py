import cv2
import numpy as np

from PIL import Image
from matplotlib import pyplot as plt
def plt_hist(img):
    plt.hist(img.ravel(), 256, [0, 256])
    plt.show()

def rotate_bound(image, angle):
    (h, w) = image.shape[:2]
    # print(h,w)
    (cX, cY) = (w // 2, h // 2)#=求旋转中心
    #通过给定的度数来求相应的旋转矩阵
    M = cv2.getRotationMatrix2D((cX, cY), -angle, 1.0)  #三个参数 旋转中心 旋转角度 以及旋转比例    求解最终的旋转矩阵
    cos = np.abs(M[0, 0])
    sin = np.abs(M[0, 1])
    nW = int((h * sin) + (w * cos))
    nH = int((h * cos) + (w * sin))

    #创建映射矩阵
    M[0, 2] += (nW / 2) - cX
    M[1, 2] += (nH / 2) - cY

    #flags = cv2.INTER_NEAREST（最近邻插值）
    #flags = cv2.INTER_LINEAR,(双线性差值)
    #flags = cv2.INTER_CUBIC,(多项式差值)

    return cv2.warpAffine(image, M, (nW, nH),flags = cv2.INTER_NEAREST)#  参数：输入图像 变换矩阵 输出图像大小 插值的方式


image = cv2.imread('./Chapter2_1.pgm')
print(image.shape[:2])
angle = 15
imag = rotate_bound(image, angle)
angle = 345
imag = rotate_bound(imag, angle)
print(imag.shape[:2])
# cv2.imwrite('imag.png',imag)
imag=imag[33:165 , 33:168]
print(imag.shape[:2])
cv2.imwrite('imag-N.png',imag)
# cv2.imwrite("CUBIC.png",image)
# plt_hist(image)
# sub_result = np.zeros(image.shape, image.dtype)
# cv2.subtract(image, imag, sub_result)
# print("CUBIC,(多项式差值)")
# print("max:",sub_result.max())
# print("average:",sub_result.mean())
# sub_result.sort()
# print("median:",sub_result[66][44][0])

cv2.waitKey()