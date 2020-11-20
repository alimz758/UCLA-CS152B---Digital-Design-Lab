import sys

import numpy as np
import cv2


def main(file_name: str, height: int, width: int):
    file = open(file_name, "r")
    pixels = list(map(int, file.read().strip().replace(" ", "").split(",")))
    pixels = np.array(pixels)
    pixels = np.reshape(pixels, (height, width))
    name = file_name.split(".")[0]
    cv2.imwrite(f"{name}.jpg", pixels)


if __name__ == '__main__':
    if len(sys.argv) == 1:
        print("Must pass text as argument\npython cvt.py <file.text>")
        exit()
    file_name = sys.argv[1]
    if len(sys.argv) == 4:
        height = int(sys.argv[2])
        width = int(sys.argv[3])
    else:
        height = 361
        width = 410
    main(file_name, height, width)
