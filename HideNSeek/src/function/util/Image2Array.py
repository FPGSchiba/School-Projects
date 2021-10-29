import sys
from PIL import Image
import numpy as np
from tqdm import tqdm

np.set_printoptions(threshold=sys.maxsize)

converter = {
    0: [255, 255, 255, 255],
    1: [0, 0, 0, 255],
    2: [2, 58, 218, 255],
    3: [218, 2, 5, 255],
    4: [55, 77, 33, 255],
    5: [33, 77, 60, 255],

    10: [111, 218, 2, 255],
    11: [130, 200, 200, 255],
    12: [87, 47, 23, 255],
    13: [55, 109, 1, 255]
}


class EnvironmentGenerator:
    def __init__(self, image: str):
        self.image_path = image
        self.image = Image.open(self.image_path)
        self.image_sequence = self.image.getdata()
        self.raw_image = [[]]
        self.height = self.image.size[1]
        self.width = self.image.size[0]
        self.get_2d_matrix()
        self.matrix = np.zeros(self.image.size)

    def get_2d_matrix(self):
        split_count = self.image.size[0]
        item_count = 0
        array_count = 0
        array_split = self.image.size[1]
        for i in self.image_sequence:
            self.raw_image[array_count].append(i)
            item_count += 1
            if item_count >= split_count:
                item_count = 0
                array_count += 1
                if array_split != array_count:
                    self.raw_image.append([])
        self.raw_image = np.array(self.raw_image)

    def transform_matrix(self):
        for key in converter:
            index_iteration = tqdm(range(len(self.raw_image)))
            for y in index_iteration:
                index_iteration.set_description(f"Finding Items ({key}/{len(converter)})")
                for x in range(len(self.raw_image[y])):
                    if np.array_equal(self.raw_image[y][x], converter[key]):
                        self.matrix[y, x] = key
        return self.matrix
