import time
import numpy as np
import matplotlib.pyplot as plt
from  matplotlib.animation import FuncAnimation

n_frames = 3 #Numero de ficheros que hemos generado
data = np.empty(n_frames, dtype=object) #Almacena los datos

#Leer todos los datos
for k in range(n_frames):
    data[k] = np.random.normal(size=(28, 28))

fig = plt.figure()
plot = plt.imshow(data[0])

def init():
    plot.set_data(data[0])
    return [plot]

def update(j):
    plot.set_data(data[j])
    time.sleep(0.5)
    return [plot]

anim = FuncAnimation(fig, update, init_func = init, frames=n_frames, interval = 30, blit=True)

plt.show()