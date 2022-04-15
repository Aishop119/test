import cv2
import numpy as np


def canny(img):
    blur_img = cv2.GaussianBlur(img,(3,3),0)
    canny_img = cv2.Canny(blur_img,60,110)
    # cv2.imshow('canny img', canny_img)
    # cv2.waitKey(2000)
    contours, hierarchy = cv2.findContours(canny_img, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
    len_contour = len(contours)
    # print(len_contour)

    contour_list = []

    # 绘制轮廓并填充
    for i in range(len_contour):
        drawing = np.zeros_like(canny_img, np.uint8)  # create a black image
        img_contour = cv2.drawContours(drawing, contours, i, (255, 255, 255), -1)
        contour_list.append(img_contour)

    img_canny= sum(contour_list)

    return img_canny


img_mar=cv2.imread(r'MRA.pgm')
img_mar_canny = canny(img_mar)
cv2.imwrite('img_mar_canny.jpg',img_mar_canny)