import time
import numpy as np
import matplotlib.pyplot as plt
from  matplotlib.animation import FuncAnimation

data = np.load("mnist_gens_mean.npy")

fig = plt.figure(figsize=(10, 10))
plots = []
for i in range(1, 101):
    plt.subplot(10, 10, i)
    plots.append(plt.imshow(data[i-1,0], cmap='gray', vmin=0, vmax=1))
    plt.axis('off')

def init():
    for i in range(1, 101):
        plots[i-1].set_data(data[i-1,0])
    return plots

def update(j):
    for i in range(1, 101):
        plots[i-1].set_data(data[i-1,j])
    time.sleep(0.1)
    return plots

anim = FuncAnimation(
    fig, 
    update, 
    init_func = init, 
    frames=data.shape[1], 
    interval = 30, 
    blit=True
)

anim.save('./mnist_evolve_animate_subplots.gif', writer='imagemagick', fps=60)