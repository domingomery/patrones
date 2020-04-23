# %% [markdown]
# # SFS feature selection

# %%
import matplotlib.pyplot as plt
from sklearn.neighbors import KNeighborsClassifier
from pybalu.performance_eval import performance
from pybalu.classification import structure
from pybalu.feature_selection import sfs
from pybalu.feature_transformation import normalize
from pybalu.data_selection import stratify
from scipy.io import loadmat

# %% [markdown]
# ## Matplotlib setup
# The following code is used to set up the default parameters for all the 
# plots shown by matplotlib

# %%
import matplotlib
matplotlib.rcParams["figure.figsize"] = (7, 7)
matplotlib.rcParams["axes.titlesize"] = 20
matplotlib.rcParams["axes.titlepad"] = 15
matplotlib.rcParams["figure.figsize"] = (7, 7)
del matplotlib

# %% [markdown]
# ## Loading classification data
# A dataset with features already extracted is loaded.
#
# This dataset consists of 810 samples and 294 features.
# Two types of class are defined (0 and 1) with 405 samples
# each.

# %%
data = loadmat("realdata")
features = data["features"]
classes = data["classes"].squeeze()


# %% [markdown]
# ## Dataset separation for training and testing
# The dataset is separated into two diferent categories: 
# 90% for training and 10% for testing.

# %%
idx_train, idx_test = stratify(classes, .90)
f_train = features[idx_train]
c_train = classes[idx_train]
f_test = features[idx_test]
c_test = classes[idx_test]

# %% [markdown]
# ## Feature normalization
# Features are normalized for better (?) sfs performance

# %%
f_train_norm, a, b = normalize(f_train)
f_test_norm = f_test * a + b


# %% [markdown]
# ## Feature selection

# %%
N_FEATURES = 15
print(f_train_norm.shape)
print(c_train.shape)
selected_feats = sfs(f_train_norm, c_train, n_features=N_FEATURES,
                     method="fisher", show=True)



# %% [markdown]
# ## Performance evaluation
# Feature selection is evaluated iteratively for each subset of
# 1, 2, ..., 15 best features
#
# Data is classified using a K Nearest Neighbors classifier
# using 3 neighbors

# %%
def performance_for_features(feat_idxs):
    # train classifier
    knn = KNeighborsClassifier(n_neighbors=3)
    knn.fit(f_train_norm[:, feat_idxs], c_train)

    # predict and evaluate performance
    prediction = knn.predict(f_test_norm[:, feat_idxs])
    return performance(prediction, c_test)


values = [performance_for_features(selected_feats[:i]) * 100
          for i in range(1, N_FEATURES + 1)]

plt.bar(*zip(*enumerate(values)), tick_label=range(1, N_FEATURES+1))
plt.title("Performance vs. number of features")
plt.xlabel('selected features')
plt.ylabel('accuracy [%]')
plt.show()
