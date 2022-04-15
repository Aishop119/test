import cv2
import numpy as np

def k_means(img):
    # 3个通道展平
    img_flat  = img.reshape((img.shape[0] * img.shape[1], 3))
    img_flat = np.float32(img_flat)

    # 迭代参数  (停止条件、迭代数、误差)
    criteria = (cv2.TERM_CRITERIA_EPS + cv2.TermCriteria_MAX_ITER, 20, 0.5)
    flags = cv2.KMEANS_RANDOM_CENTERS

    # 进行聚类
    compactness, labels, centers = cv2.kmeans(img_flat, 3, None, criteria, 10, flags)

    # 图像转换回uint8二维类型
    centers = np.uint8(centers)
    print(centers)
    res = centers[labels.flatten()]
    dst = res.reshape((img.shape))
    # dst= np.array(dst,dtype=np.uint8)

    #二值化
    for i in range(dst.shape[0]):
        for j in range(dst.shape[1]):
            for k in range(dst.shape[2]):
                if all(dst[i][j][k] == centers[0]):
                    dst[i][j][k] = 255
                else:
                    dst[i][j][k] = 0

    cv2.imshow('kmeans img', dst)
    cv2.waitKey(0)
    cv2.destroyAllWindows()

    return  dst

img_mar=cv2.imread(r'MRA.pgm')
img_mar_k_means = k_means(img_mar)
cv2.imwrite('img_mar_k_means.jpg',img_mar_k_means)