import cv2
import numpy as np

def cal_psnr(im1, im2):
    mse = (np.abs(im1 - im2) ** 2).mean()
    psnr = 10 * np.log10(255 * 255 / mse)
    return psnr

def main():
    original = cv2.imread("Chapter2_1.pgm")
    compressed = cv2.imread("3_new.pgm")
    value = cal_psnr(original, compressed)
    print(f"PSNR value is {value} dB")


if __name__ == "__main__":
    main()