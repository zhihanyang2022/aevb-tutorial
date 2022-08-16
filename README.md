# AEVB Tutorial

## Intro

PyTorch codebase for paper Training Latent Variable Models with Auto-encoding Variational Bayes: A Tutorial.

TODO: link to paper

TODO: bibtex of paper

In the tutorial, we motivate the Auto-encoding Variational Bayes (AEVB) algorithm from the classic Expectation Maximization (EM) algorithm, and then derive from scratch the AEVB training procedure for the following models:

- Factor Analysis
- [Variational Auto-Encoder (VAE)](https://arxiv.org/pdf/1312.6114.pdf)
- [Conditional VAE](https://papers.nips.cc/paper/2015/file/8d55a249e6baa5c06772297520da2051-Paper.pdf)
- [Gaussian Mixture VAE by Rui Shu](http://ruishu.io/2016/12/25/gmvae/)
- [Variational RNN](https://papers.nips.cc/paper/2015/file/b618c3210e934362ac261db280128c22-Paper.pdf)

This repo contains minimal PyTorch implementation of these models. Pre-trained models are included for all models except Factor Analysis (which takes less than 10 seconds to train) so it's easy to play around. All other models also take less than 30 minutes to train from scratch. To run the notebooks, create a conda environment, install the required packages, and you should be ready.

## Visualizations

(All plots below are created using the notebooks in this repo.)

Factor analysis

<img src="01_factor_analysis/fa_learning_curve.png">

Variational Auto-Encoder

<img src="02_vae/vae_mnist_gens_param.png">

Conditional VAE



Gaussian Mixture VAE by Rui Shu (clusters ordered manually in the plot)

<img src="04_gmvae/mnist_gens_conditional_param.png">

Variational RNN

<img src="05_vrnn/mnist_evolve_animate_subplots.gif">
