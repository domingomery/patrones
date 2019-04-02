from pybalu.io import imread
from imageio import imsave
import matplotlib.pyplot as plt
import numpy as np

im = imread("feature_extraction/rice2.png")
im[np.where(im < 140)] = 80
imsave("feature_extraction/rice2.png", im)