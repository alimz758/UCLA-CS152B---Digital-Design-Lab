import sys

import numpy as np
import cv2


def main(file_name: str):
    file = open(file_name, "r")
    pixels = list(map(int, file.read().strip().replace(" ", "").split(",")))
    pixels = np.array(pixels)
    pixels = np.reshape(pixels, (361, 410))
    name = file_name.split(".")[0]
    cv2.imwrite(f"{name}.jpg", pixels)


if __name__ == '__main__':
    if len(sys.argv) == 1:
        print("Must pass text as argument\npython cvt.py <file.text>")
        exit()
    main(sys.argv[1])
