from pybalu.io import imread
from pybalu.feature_extraction import basic_geo
from skimage.measure import label
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Ellipse

from multiprocessing import Pool

im = imread("rice.png")
im_bin = (im > 140).astype(int)
labeled, n = label(im_bin, return_num=True)
plt.figure(figsize=(12, 4.8))
plt.subplot(1, 3, 1)
plt.title("Original Image")
plt.imshow(im, cmap="gray")

def calc_ellipse(idx):
    region = (labeled == idx).astype(int)
    feats = basic_geo(region)
    # feats[0]:  center of grav i [px]
    # feats[1]:  center of grav j [px]
    # feats[10]: MajorAxisLength  [px]
    # feats[11]: MinorAxisLength  [px]
    # feats[12]: Orientation      [deg]
    return np.array([feats[1], feats[0], feats[11], feats[10], -feats[12]])

with Pool() as pool:
    ellipses = np.vstack(pool.map(calc_ellipse, range(1, n)))


ax = plt.subplot(1, 3, 2)
plt.title("Segmented Image")
plt.imshow(im, cmap="gray")


def draw_ellipse(x, y, height, width, angle, axes):
    ell = Ellipse(xy=(x, y), height=height, width=width,
                  angle=angle, edgecolor="red", facecolor="none")
    axes.add_artist(ell)
    ell.set_clip_box(axes.bbox)
    return ell

for ell in ellipses:
    draw_ellipse(*ell, axes=ax)

ax = plt.subplot(1, 3, 3)
plt.title("Mean sized rice grains (major axis)")

major_25 = np.percentile(ellipses[:,3], 25)
major_75 = np.percentile(ellipses[:,3], 75)

valid_labels = 1 + np.where((ellipses[:,3] > major_25) & (ellipses[:,3] < major_75))[0]
im_mean = np.array(im)
im_mean[np.where(~np.isin(labeled, valid_labels))] = 0
plt.imshow(im_mean, cmap="gray")

plt.show()


try:
    theta = int(input('orientation (example = 45)? '))
except ValueError:
    theta = 45

rotated = ellipses[np.where((ellipses[:,4] > theta - 10) & (ellipses[:,4] < theta + 10))]

plt.title(f"Orientation at {theta} deg")
plt.imshow(im, cmap="gray")

for ell in rotated:
    draw_ellipse(*ell, axes=plt.axes())

plt.show()
