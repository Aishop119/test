import cv2
import matplotlib.pyplot as plt
def plt_hist(img):
    plt.hist(img.ravel(), 256, [0, 256])
    plt.show()
img1=cv2.imread('MRA_1.jpg')
img2=cv2.imread('MRA_2.jpg')
# plt_hist(img1)
# cv2.waitKey(0)
plt_hist(img2)
# cv2.waitKey(0)