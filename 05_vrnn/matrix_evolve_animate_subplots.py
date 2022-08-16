import time
import numpy as np
import matplotlib.pyplot as plt
from  matplotlib.animation import FuncAnimation

n_frames = 28 #Numero de ficheros que hemos generado
data = np.empty(n_frames, dtype=object) #Almacena los datos

#Leer todos los datos
for k in range(n_frames):
    data[k] = np.ones((28, 28)) * (k / n_frames)

fig = plt.figure(figsize=(10, 10))
plots = []
for i in range(1, 26):
    plt.subplot(5, 5, i)
    plots.append(plt.imshow(data[0].reshape(28, 28), cmap='gray', vmin=0, vmax=1))
    plt.axis('off')

def init():
    for plot in plots:
        plot.set_data(data[0])
    return plots

def update(j):
    for plot in plots:
        plot.set_data(data[j])
    time.sleep(0.2)
    return plots

anim = FuncAnimation(fig, update, init_func = init, frames=n_frames, interval = 30, blit=True)

anim.save('./matrix_subplots.gif', writer='imagemagick', fps=60)

# plt.show()