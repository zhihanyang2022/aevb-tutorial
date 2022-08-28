<TeXmacs|2.1.1>

<style|<tuple|generic|padded-paragraphs>>

<\body>
  <\hide-preamble>
    \;

    <assign|author-name|<macro|author|Yang Zhi-Han>>
  </hide-preamble>

  <doc-data|<doc-title|Training Latent Variable Models with Auto-encoding
  Variational Bayes: A Tutorial>|<doc-author|<author-data|<\author-affiliation>
    <with|font-series|bold|Yang Zhi-Han>

    \;

    Department of Mathematics and Statistics

    Carleton College

    Northfield, MN 55057

    <verbatim|yangz2@carleton.edu>
  </author-affiliation>>>>

  <with|font-base-size|12|<abstract-data|<abstract|<with|font-base-size|12|<with|font-series|bold|Auto-encoding
  Variational Bayes> (AEVB) <cite|kingma2013auto> is a powerful and general
  algorithm for fitting latent variable models (a promising direction for
  unsupervised learning), and is well-known for training the Variational
  Auto-Encoder (VAE). In this tutorial, we focus on motivating AEVB from the
  classic <with|font-series|bold|Expectation Maximization> (EM) algorithm, as
  opposed to from deterministic auto-encoders. Though natural and somewhat
  self-evident, the connection between EM and AEVB is not emphasized in the
  recent deep learning literature, and we believe that emphasizing this
  connection can improve the community's understanding of AEVB. In
  particular, we find it especially helpful to view (1) optimizing the
  evidence lower bound<\footnote>
    It is also called the variational lower bound, or the variational bound.\ 
  </footnote> (ELBO) with respect to inference parameters as
  <with|font-series|bold|approximate E-step> and (2) optimizing ELBO with
  respect to generative parameters as <with|font-series|bold|approximate
  M-step>; doing both simultaneously as in AEVB is then simply tightening and
  pushing up ELBO at the same time. We discuss how approximate E-step can be
  interpreted as performing <with|font-series|bold|variational inference>.
  Important concepts such as amortization and the reparametrization trick are
  discussed in great detail. Finally, we derive from scratch the AEVB
  training procedures of a non-deep and several deep latent variable models,
  including VAE <cite|kingma2013auto>, Conditional VAE
  <cite|sohn2015learning>, Gaussian Mixture VAE <cite|gmvae> and Variational
  RNN <cite|chung2015recurrent>. It is our hope that readers would recognize
  AEVB as a general algorithm that can be used to fit a wide range of latent
  variable models (not just VAE), and apply AEVB to such models that arise in
  their own fields of research. PyTorch <cite|paszke2019pytorch> code for all
  included models are publicly available><\footnote>
    Code: <slink|https://github.com/zhihanyang2022/aevb-tutorial>
  </footnote>.>>>

  \;

  \;

  \;

  <\table-of-contents|toc>
    <vspace*|1fn><with|font-series|bold|math-font-series|bold|font-shape|small-caps|1.<space|2spc>Latent
    variable models> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <pageref|auto-1><vspace|0.5fn>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|font-shape|small-caps|2.<space|2spc>Expectation
    maximization> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <pageref|auto-2><vspace|0.5fn>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|font-shape|small-caps|3.<space|2spc>Approximate
    E-step as variational inference> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <pageref|auto-3><vspace|0.5fn>

    <with|par-left|1tab|3.1.<space|2spc>Variational inference
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-4>>

    <with|par-left|1tab|3.2.<space|2spc>Amortized variational inference
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-5>>

    <with|par-left|1tab|3.3.<space|2spc>Stochastic optimization of ELBO
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-6>>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|font-shape|small-caps|4.<space|2spc>Approximate
    M-step> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <pageref|auto-7><vspace|0.5fn>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|font-shape|small-caps|5.<space|2spc>Derivation
    of AEVB for a few latent variable models>
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <pageref|auto-8><vspace|0.5fn>

    <with|par-left|1tab|5.1.<space|2spc>What exactly is the AEVB algorithm?
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-10>>

    <with|par-left|1tab|5.2.<space|2spc>Factor analysis model
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-11>>

    <with|par-left|2tab|5.2.1.<space|2spc>Generative model
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-12>>

    <with|par-left|2tab|5.2.2.<space|2spc>Approximate posterior
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-14>>

    <with|par-left|2tab|5.2.3.<space|2spc>Estimator of per-example ELBO
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-15>>

    <with|par-left|2tab|5.2.4.<space|2spc>Results
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-16>>

    <with|par-left|1tab|5.3.<space|2spc>Variational autoencoder
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-19>>

    <with|par-left|2tab|5.3.1.<space|2spc>Generative model
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-20>>

    <with|par-left|2tab|5.3.2.<space|2spc>Approximate posterior
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-22>>

    <with|par-left|2tab|5.3.3.<space|2spc>Results
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-23>>

    <with|par-left|1tab|5.4.<space|2spc>Conditional VAE
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-28>>

    <with|par-left|2tab|5.4.1.<space|2spc>Generative model
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-29>>

    <with|par-left|2tab|5.4.2.<space|2spc>Approximate posterior
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-30>>

    <with|par-left|2tab|5.4.3.<space|2spc>Estimator for per-example ELBO
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-31>>

    <with|par-left|2tab|5.4.4.<space|2spc>Results
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-32>>

    <with|par-left|1tab|5.5.<space|2spc>Gaussian Mixture VAE
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-34>>

    <with|par-left|2tab|5.5.1.<space|2spc>Generative model
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-35>>

    <with|par-left|2tab|5.5.2.<space|2spc>Approximate posterior
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-36>>

    <with|par-left|2tab|5.5.3.<space|2spc>Estimator for per-example ELBO
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-37>>

    <with|par-left|4tab|Estimator 1: Marginalization of
    <with|mode|math|y<rsub|i>> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-38><vspace|0.15fn>>

    <with|par-left|4tab|Estimator 2: Gumbel-Softmax trick
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-39><vspace|0.15fn>>

    <with|par-left|2tab|5.5.4.<space|2spc>Results
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-40>>

    <with|par-left|1tab|5.6.<space|2spc>Variational RNN
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-43>>

    <with|par-left|2tab|5.6.1.<space|2spc>Generative model
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-44>>

    <with|par-left|2tab|5.6.2.<space|2spc>Approximate posterior
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-45>>

    <with|par-left|2tab|5.6.3.<space|2spc>Estimator for per-example ELBO
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-46>>

    <with|par-left|2tab|5.6.4.<space|2spc>Results
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <no-break><pageref|auto-47>>

    <vspace*|1fn><with|font-series|bold|math-font-series|bold|font-shape|small-caps|Bibliography>
    <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
    <pageref|auto-49><vspace|0.5fn>
  </table-of-contents>

  \;

  <section|Latent variable models><label|sec:latent-var-models>

  In probabilitic machine learning, a <with|font-shape|italic|model> means a
  (parametrized) probability distribution defined over variables of interest.
  This includes classifiers and regressors, which can be viewed simply as
  conditional distributions. A latent variable model is just a model that
  contains some variables whose values are not observed. Therefore, for such
  a model, we can divide the variables of interest into two vectors:
  <math|<with|font-series|bold|x>>, which denotes the vector of observed
  variables, and <math|<with|font-series|bold|z>>, which denotes the vector
  of <with|font-shape|italic|latent> or unobserved variables.\ 

  A strong motivation for using latent variable models is that some variables
  in the generative process are naturally hidden from us so we cannot observe
  their values. In particular, latent variables can have the interpretation
  of low-dimensional \Phidden causes\Q of high-dimensional observed
  variables, and models that utilize latent variables \Poften have fewer
  parameters than models that directly represent correlation in the
  [observed] space\Q <cite|murphy2012machine>. The low dimensionality of
  latent variables also means that they can serve as a compressed
  representation of data. Additionally, latent variable models can be highly
  expressive from summing over or integrating over hidden variables, which
  makes them useful for purposes like black-box density estimation.

  <section|Expectation maximization>

  In the classic statistical inference framework, fitting a model means
  finding the maximum likelihood estimator (MLE) of the model parameters,
  which is obtained by maximizing the log likelhood function (also known as
  the evidence<\footnote>
    The name \Pevidence\Q is also commonly used for
    <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|D|)>>; in this
    tutorial, \Pevidence\Q strictly means <math|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|D|)>>.
  </footnote>):

  <\eqnarray*>
    <tformat|<table|<row|<cell|<with|font-series|bold|\<theta\>><rsup|\<ast\>>>|<cell|=>|<cell|arg
    max<rsub|<with|font-series|bold|\<theta\>>> log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font|cal|D>|)>,>>>>
  </eqnarray*>

  where we have assumed that the model <math|p<rsub|<with|font-series|bold|\<theta\>>>>
  is unconditional<\footnote>
    All the derivation can be easily adapted to conditional models.
  </footnote> and we have <math|N> i.i.d. observations of the observed
  variable <math|<with|font-series|bold|x>> stored in the dataset
  <math|<with|font|cal|D>=<around*|{|<with|font-series|bold|x><rsub|1>,<with|font-series|bold|x><rsub|2>,\<cdots\>,<with|font-series|bold|x><rsub|N>|}>>.

  By the same spirit, we can fit a latent variable model using MLE:

  <\eqnarray*>
    <tformat|<table|<row|<cell|<with|font-series|bold|\<theta\>><rsup|\<ast\>>>|<cell|=>|<cell|arg
    max<rsub|<with|font-series|bold|\<theta\>>> log
    \ p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font|cal|D>|)>>>|<row|<cell|>|<cell|=>|<cell|arg
    max<rsub|<with|font-series|bold|\<theta\>>><big|sum><rsub|i=1><rsup|N>log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>|)>>>|<row|<cell|>|<cell|=>|<cell|arg
    max<rsub|<with|font-series|bold|\<theta\>>><big|sum><rsub|i=1><rsup|N>log<big|int>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>
    d<with|font-series|bold|z><rsub|i>.<eq-number><label|eq:mle>>>>>
  </eqnarray*>

  where we have assumed that <math|<with|font-series|bold|z><rsub|i>> is a
  continuous latent variable. If <math|<with|font-series|bold|z><rsub|i>> is
  discrete, then the integral would be replaced by a sum. It is also valid
  for one part of <math|<with|font-series|bold|z><rsub|i>> to be continuous
  and the other part to be discrete. In general, evaluating this integral is
  intractable, since it's essentially the normalization constant in Bayes'
  rule:

  <\equation*>
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>=<frac|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>|<big|int>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>
    d<with|font-series|bold|z><rsub|i>>.
  </equation*>

  Note that this integral (or sum) is tractable in some simple cases, though
  evaluating this integral and plugging it into Equation
  <math|<reference|eq:mle>> still has certain downsides (see Section 11.4.1
  in <cite|murphy2012machine> for a short discussion on this for Gaussian
  Mixture models; see <cite|cs285slides> for a brief comment on numerical
  stability; it's surprisingly difficult to find sources that discuss the
  downsides more systematically). In other cases where it's not intractable,
  the reason<\footnote>
    Someone's personal communication with David Blei:
    <slink|https://tinyurl.com/43auucww>
  </footnote> for intractability can be having no closed-form solution or
  computational intractability. An interested reader is encouraged to seek
  additional sources.\ 

  While directly optimizing the evidence is difficult, it is possible to
  derive a lower bound to the evidence, called the
  <with|font-shape|italic|evidence lower bound> (ELBO), as follows:

  <\eqnarray*>
    <tformat|<table|<row|<cell|<big|sum><rsub|i=1><rsup|N>log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>|)>>|<cell|=>|<cell|<big|sum><rsub|i=1><rsup|N>log
    \<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>><around*|[|<frac|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>|q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>>|]><space|1em><around*|(|<text|introduce
    distributions >q<rsub|i><text|'s>|)>>>|<row|<cell|>|<cell|\<geq\>>|<cell|<big|sum><rsub|i=1><rsup|N>\<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>><around*|[|log
    <around*|(|<frac|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>|q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>>|)>|]><space|1em><around*|(|<text|apply
    Jensen's inequality>|)>>>|<row|<cell|>|<cell|=>|<cell|<big|sum><rsub|i=1><rsup|N>\<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>><around*|[|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>|]>+<big|sum><rsub|i=1><rsup|N>\<bbb-H\><around*|(|q<rsub|i>|)>>>|<row|<cell|>|<cell|\<triangleq\>>|<cell|ELBO<around*|(|<with|font-series|bold|\<theta\>>,<around*|{|q<rsub|i>|}>|)>,>>>>
  </eqnarray*>

  where the notation <math|ELBO<around*|(|<with|font-series|bold|\<theta\>>,<around*|{|q<rsub|i>|}>|)>>
  emphasizes that ELBO is a function of <math|<with|font-series|bold|\<theta\>>>
  and <math|<around*|{|q<rsub|i>|}>>. Importantly, Jensen's inequality
  becomes an equality when the random variable is a constant. This happens
  when <math|q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>=p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>
  so that <math|p<around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>/q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>>
  becomes <math|p<around*|(|<with|font-series|bold|x><rsub|i>|)>>, which does
  not contain <math|<with|font-series|bold|z><rsub|i>>. Therefore, if we keep
  alternating between (1) setting each <math|q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>>
  to be <math|p<around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>
  so that the lower bound is tight with respect to
  <math|<with|font-series|bold|\<theta\>>> and (2) maximizing the lower bound
  with respect to <math|<with|font-series|bold|\<theta\>>>, then we would
  maximize the evidence up to a local maximum. This is known as the
  Expectation Maximization (EM) algorithm, and Step 1 is called the E-step
  and Step 2 is called the M-step. The algorithm is summarized below:

  <\named-algorithm|\U Expectation Maximization (EM)>
    <with|font-series|bold|Require.> <math|<with|font|cal|D>=<around*|{|<with|font-series|bold|x><rsub|1>,\<ldots\>,<with|font-series|bold|x><rsub|N>|}>>:
    observed data; <math|<with|font-series|bold|\<theta\>><rsub|0>>: initial
    value of parameters

    <math|<with|font-series|bold|\<theta\>>\<leftarrow\><with|font-series|bold|\<theta\>><rsub|0>>

    <with|font-series|bold|while> <with|font-series|bold|not> converged:

    <space|2em><math|q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>\<leftarrow\>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>
    for <math|i=1,\<ldots\>,N><space|12em>(Expectation step; E-step)

    <space|2em><math|<with|font-series|bold|\<theta\>>\<leftarrow\> arg
    max<rsub|<with|font-series|bold|\<theta\>>>
    ELBO<around*|(|<with|font-series|bold|\<theta\>>,<around*|{|q<rsub|i>|}>|)>><space|14em>(Maximization
    step: M-step)

    <with|font-series|bold|end while>
  </named-algorithm>

  At this point, though we recognize that EM does correctly converge, it is
  not clear whether the EM approach makes things easier and what its
  consequences are, as compared to using Equation <reference|eq:mle>. To
  partly answer this question, in Section 3 and 4, we will discuss a very
  general and modular template for extending EM (that leads to AEVB in
  Section <reference|sec:models>) to models for which the E-step (again, due
  to intractability of the marginalizing integral) and the M-step are not
  tractable. In Section <reference|sec:models>, we will apply this general
  template to derive AEVB training procedures for several interesting latent
  variable models. Equation <reference|eq:mle> cannot be extended in a
  similar fashion.

  Before we move on, it's important to consider an alternative derivation
  (see Section 22.2.2 of <cite|pml2Book>) of ELBO that gives us more insights
  on the size of the gap between the lower bound and the true objective,
  which is called the <with|font-shape|italic|variational gap>. This
  derivation turns out to have <with|font-shape|italic|great> importance for
  later sections. In particular, if we write the marginal
  <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x>|)>>
  as <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x>,<with|font-series|bold|z>|)>/p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z>\<mid\><with|font-series|bold|x>|)>>
  instead of <math|<big|int>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x>,<with|font-series|bold|z>|)>
  d<with|font-series|bold|z>>, then we do not need to move the expectation
  outside the log and could have the expectation outside at the beginning.
  Starting from the evidence, one can show that

  <\eqnarray*>
    <tformat|<table|<row|<cell|<big|sum><rsub|i=1><rsup|N>log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>|)>>|<cell|=>|<cell|<big|sum><rsub|i=1><rsup|N>\<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>><around*|[|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>|)>|]>>>|<row|<cell|>|<cell|=>|<cell|<big|sum><rsub|i=1><rsup|N>\<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>><around*|[|log
    <around*|(|<frac|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>|)>|]>>>|<row|<cell|>|<cell|=>|<cell|<big|sum><rsub|i=1><rsup|N>\<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>><around*|[|log
    <around*|(|<frac|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>|q<around*|(|<with|font-series|bold|z><rsub|i>|)>>\<cdot\><frac|q<around*|(|<with|font-series|bold|z><rsub|i>|)>|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>|)>|]>>>|<row|<cell|>|<cell|=>|<cell|<wide*|<big|sum><rsub|i=1><rsup|N>\<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>><around*|[|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>-log
    q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>|]>|\<wide-underbrace\>><rsub|<text|ELBO><around*|(|<with|font-series|bold|\<theta\>>,<around*|{|q<rsub|i>|}>|)>>+<big|sum><rsub|i=1><rsup|N><wide*|\<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>><around*|[|<frac|q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>|]>|\<wide-underbrace\>><rsub|D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>\<parallel\>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>|)>>.<eq-number><label|eq:ll-elbo-kl>>>>>
  </eqnarray*>

  We see that the gap between the evidence and ELBO is elegantly the sum of
  KL divergences between the chosen distributions <math|q<rsub|i>> and the
  true posteriors. Since <math|D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>\<parallel\>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>|)>=0>
  if and only if <math|q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>=p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>,
  this agrees with our previous derivation using Jensen's inequality.\ 

  <section|Approximate E-step as variational inference>

  Section <reference|sec:avi> and <reference|sec:stocopt> partly follow the
  treatment of <cite|cs285slides> and <cite|pml2Book> respectively.\ 

  <\subsection>
    Variational inference
  </subsection>

  To reduce the variational gap in Equation <reference|eq:ll-elbo-kl> (while
  assuming that <math|<with|font-series|bold|\<theta\>>> is fixed) when
  <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>
  is intractable, we define a family of distributions
  <math|<with|font|cal|Q>> and aim to find individual
  <math|q<rsub|i>\<in\><with|font|cal|Q>> such that the KL divergence between
  <math|q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>> and
  <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>
  are minimized, i.e.,\ 

  <\equation*>
    q<rsup|\<ast\>><rsub|i>=arg min<rsub|q<rsub|i>\<in\><with|font|cal|Q>>
    D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>\<parallel\>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>|)><space|1em><text|for
    >i=1,\<ldots\>,N.
  </equation*>

  Since this is (1) optimizing over functions (probability distributions are
  functions) and (2) doing inference (i.e., obtaining some representation of
  the true posterior), it's called \Pvariational inference\Q. In the Calculus
  of Variations, \Pvariations\Q mean small changes in functions. In practice,
  <math|q<rsub|i>> would have parameters to optimize over, so we would not be
  directly optimizing over functions.

  If the true posterior is contained in <math|<with|font|cal|Q>> (i.e.,
  <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>\<in\><with|font|cal|Q>>),
  then clearly <math|q<rsup|\<ast\>><rsub|i>=p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>
  and setting each <math|q<rsub|i>=q<rsup|\<ast\>><rsub|i>> in Equation
  <reference|eq:ll-elbo-kl> will make ELBO a tight bound (with respect to
  <math|<with|font-series|bold|\<theta\>>>) because the sum of KL divergences
  will be zero. Otherwise, ELBO would not be tight, but maximizing ELBO can
  still be useful because (1) it is by definition a lower bound to the
  evidence, the quantity we care about, and (2)
  <math|q<rsup|\<ast\>><rsub|i>> would still be a very good approximation if
  <math|<with|font|cal|Q>> is flexible so ELBO would not be too loose.

  The <with|font-shape|italic|challenge> of this optimization problem is that
  the true posterior is not tractable and hence not available, so directly
  minimizing the KL divergence is not an option. In this case, there are two
  perspectives that lead to the same solution but are conceptually somewhat
  different:

  <\enumerate>
    <item>From Equation <reference|eq:ll-elbo-kl>, we see that minimizing the
    sum of KL divergences with respect to <math|q<rsub|i>>'s is equivalent to
    maximizing ELBO with respect to <math|q<rsub|i>>'s, since the evidence on
    the left-hand side is a constant with respect to <math|q<rsub|i>>'s.
    Fortunately, ELBO is fairly easy to evaluate: we always know how to
    evaluate the unnormalized posterior <math|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>>
    for any graphical model, and the expectation operator outside can be
    sidestepped with techniques that we will discuss in detail in Section
    <reference|sec:models> on a per-model basis.

    <item>One can also minimize KL divergences with respect to
    <math|q<rsub|i>>'s by dealing with the
    <with|font-shape|italic|unnormalized> true posteriors. This is a standard
    approach: see Section 21.2 of <cite|murphy2012machine> for a textbook
    treatment and Section 3 of <cite|blundell2015weight> for an application
    to deep neural networks. Importantly, the unnormalized true posterior is
    tractable for all graphical models, which is the foundation for
    techniques such as Markov Chain Monte Carlo (MCMC). Slightly abusing the
    notation of KL divergence (as <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>>
    is unnormalized), we have

    <\eqnarray*>
      <tformat|<table|<row|<cell|D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>\<parallel\>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>|)>>|<cell|=>|<cell|D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>\<parallel\>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>|)>+log
      p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>|)>>>|<row|<cell|>|<cell|=>|<cell|\<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>><around*|[|log
      q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>-log
      p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>|]>.<space|1em><around*|(|<text|dropped
      constant>|)>>>>>
    </eqnarray*>

    But this is just the negation of ELBO, and minimizing the negation of
    ELBO with respect to <math|q<rsub|i>>'s is equivalent to maximizing ELBO
    with respect to <math|q<rsub|i>>'s.
  </enumerate>

  While these two solutions are the same, they came from two different
  derivations and can give different insights.

  <subsection|Amortized variational inference><label|sec:avi>

  One natural and convenient way to define a family of distributions
  <math|<with|font|cal|Q>> is through a parametrized family. However, doing
  this naively means that the number of parameters of <math|q<rsub|i>>'s will
  grow linearly as the number of data points
  <math|<with|font-series|bold|x><rsub|i>> grow. For example, if each
  <math|q<rsub|i>> is an isotropic Gaussian with parameters
  <math|<with|font-series|bold|\<mu\>><rsub|i>> and
  <math|<with|font-series|bold|\<sigma\>><rsub|i>>, then <math|q<rsub|i>>'s
  altogether would have <math|<around*|(|<around*|\||<with|font-series|bold|\<mu\>><rsub|i>|\|>+<around*|\||<with|font-series|bold|\<sigma\>><rsub|i>|\|>|)>\<times\>N>
  parameters. In such cases, it is convenient to represent
  <math|q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>> by a neural
  network <math|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>
  such that <math|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>=q<rsub|i><around*|(|<with|font-series|bold|z><rsub|i>|)>>,
  where <math|<with|font-series|bold|\<phi\>>> is referred to as the
  <with|font-shape|italic|inference <with|font-shape|right|parameters>> (as
  opposed to <math|<with|font-series|bold|\<theta\>>>, the
  <with|font-shape|italic|generative> parameters). This approach is called
  <with|font-shape|italic|amortized> variational inference because the
  \Pcost\Q of having a fixed but large number of parameters gradually \Ppays
  off\Q, in terms of memory usage and generalization benefits, as the size of
  the dataset grows. With amortization, the right-hand side of Equation
  <reference|eq:ll-elbo-kl> becomes

  <\equation*>
    <wide*|<big|sum><rsub|i=1><rsup|N>\<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>><around*|[|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>-log
    q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>|]>|\<wide-underbrace\>><rsub|<text|ELBO><around*|(|<with|font-series|bold|\<theta\>>,<with|font-series|bold|\<phi\>>|)>>+<big|sum><rsub|i=1><rsup|N><wide*|\<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>><around*|[|<frac|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>|]>|\<wide-underbrace\>><rsub|D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>\<parallel\>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>|)>>.
  </equation*>

  <subsection|Stochastic optimization of ELBO><label|sec:stocopt><label|sec:stocopt>

  To minimize the size of the variational gap between ELBO and the evidence,
  we can maximize ELBO with respect to <math|<with|font-series|bold|\<phi\>>>
  with mini-batch gradient ascent <with|font-shape|italic|until convergence>:

  <\eqnarray*>
    <tformat|<table|<row|<cell|<with|font-series|bold|\<phi\>><rsup|t+1>>|<cell|\<leftarrow\>>|<cell|<with|font-series|bold|\<phi\>><rsup|t>+\<eta\>\<nabla\><rsub|<with|font-series|bold|\<phi\>>><around*|{|<wide*|<frac|1|N<rsub|B>><big|sum><rsub|i=1><rsup|N<rsub|B>><wide*|\<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>><around*|[|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>-log
    q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>|]>|\<wide-underbrace\>><rsub|<text|per-example
    ELBO>>|\<wide-underbrace\>><rsub|<text|mini-batch
    ELBO>>|}><rsub|<with|font-series|bold|\<phi\>>=<with|font-series|bold|\<phi\>><rsub|t>>>>|<row|<cell|>|<cell|=>|<cell|<with|font-series|bold|\<phi\>><rsup|t>+\<eta\>
    <frac|1|N<rsub|B>><big|sum><rsub|i=1><rsup|N<rsub|B>>\<nabla\><rsub|<with|font-series|bold|\<phi\>>><around*|{|\<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>><around*|[|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>-log
    q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>|]>|}><rsub|<with|font-series|bold|\<phi\>>=<with|font-series|bold|\<phi\>><rsub|t>>,<eq-number><label|eq:e-step>>>>>
  </eqnarray*>

  where <math|\<eta\>\<gtr\>0> is the learning rate and <math|N<rsub|B>> is
  the batch size. We have divided the mini-batch ELBO by <math|N<rsub|B>> so
  that picking <math|\<eta\>> can be de-coupled from picking
  <math|N<rsub|B>>. However, unless the expectations within the gradient
  operators are tractable, the gradients cannot be evaluated exactly. We will
  discuss solutions to this problem on a per-model basis in Section
  <reference|sec:models>.

  <section|Approximate M-step><label|m-step>

  After an approximate E-step is completed, we can then maximize ELBO with
  respect to <math|<with|font-series|bold|\<theta\>>> with mini-batch
  gradient ascent <with|font-shape|italic|until convergence>:

  <\eqnarray*>
    <tformat|<table|<row|<cell|<with|font-series|bold|<with|font-series|bold|\<theta\>>><rsup|t+1>>|<cell|\<leftarrow\>>|<cell|<with|font-series|bold|<with|font-series|bold|\<theta\>>><rsup|t>+\<eta\>\<nabla\><rsub|<with|font-series|bold|<with|font-series|bold|\<theta\>>>><around*|{|<frac|1|N<rsub|B>><big|sum><rsub|i=1><rsup|N<rsub|B>>\<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>><around*|[|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>-log
    q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>|]>|}><rsub|<with|font-series|bold|<with|font-series|bold|\<theta\>>>=<with|font-series|bold|\<theta\>><rsub|t>>>>|<row|<cell|>|<cell|=>|<cell|<with|font-series|bold|<with|font-series|bold|\<theta\>>><rsup|t>+\<eta\>
    <frac|1|N<rsub|B>><big|sum><rsub|i=1><rsup|N<rsub|B>>\<nabla\><rsub|<with|font-series|bold|<with|font-series|bold|\<theta\>>>><around*|{|\<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>><around*|[|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>-log
    q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>|]>|}><rsub|<with|font-series|bold|<with|font-series|bold|\<theta\>>>=<with|font-series|bold|\<theta\>><rsub|t>>.<eq-number><label|eq:m-step>>>>>
  </eqnarray*>

  Unlike in approximate E-step, here the gradient operator with respect to
  <math|<with|font-series|bold|\<theta\>>> can be moved
  <with|font-shape|italic|inside> the expectation and the expectation can be
  sampled. In Section 5, we will discuss this in more detail.

  <section|Derivation of AEVB for a few latent variable
  models><label|sec:models><float|float|t|<\big-table|<tabular|<tformat|<cwith|1|-1|1|-1|cell-halign|c>|<cwith|1|-1|1|-1|cell-valign|c>|<cwith|1|1|2|-1|font-shape|italic>|<cwith|1|-1|1|-1|cell-hyphen|n>|<cwith|1|-1|1|-1|cell-tborder|1ln>|<cwith|1|-1|1|-1|cell-bborder|1ln>|<cwith|1|-1|1|-1|cell-lborder|1ln>|<cwith|1|-1|1|-1|cell-rborder|1ln>|<table|<row|<cell|<with|font-shape|italic|Model>>|<cell|Observed>|<cell|Latent>|<cell|Joint
  density / generative model>>|<row|<cell|FA>|<cell|<math|<with|font-series|bold|x>\<in\>\<bbb-R\><rsup|D>>>|<cell|<math|<with|font-series|bold|z>\<in\>\<bbb-R\><rsup|L>>>|<cell|<math|<wide*|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|>\<mid\><with|font-series|bold|z>|)>|\<wide-underbrace\>><rsub|<text|Gaussian>><wide*|p<around*|(|<with|font-series|bold|z>|)>|\<wide-underbrace\>><rsub|<text|Gaussian>>>>>|<row|<cell|VAE>|<cell|<math|<with|font-series|bold|x>\<in\><around*|{|0,1|}><rsup|784>>>|<cell|<math|<with|font-series|bold|z>\<in\>\<bbb-R\><rsup|L>>>|<cell|<math|<wide*|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|>\<mid\><with|font-series|bold|z>|)>|\<wide-underbrace\>><rsub|<text|ProductOfContinuousBernoullis>>
  <wide*|p<around*|(|<with|font-series|bold|z>|)>|\<wide-underbrace\>><rsub|<text|Gaussian>>>>>|<row|<cell|CVAE>|<cell|<math|<with|font-series|bold|x>\<in\><around*|{|0,1|}><rsup|784>>>|<cell|<math|<with|font-series|bold|z>\<in\>\<bbb-R\><rsup|L>>>|<cell|<math|<wide*|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|>\<mid\><with|font-series|bold|z>,<with|font-series|bold|y>|)>|\<wide-underbrace\>><rsub|<text|ProductOfContinuousBernoullis>>
  <wide*|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z>\<mid\><with|font-series|bold|y>|)>|\<wide-underbrace\>><rsub|<text|Gaussian>>>>>|<row|<cell|GMVAE>|<cell|<math|<with|font-series|bold|x>\<in\><around*|{|0,1|}><rsup|784>>>|<cell|<math|<with|font-series|bold|y>\<in\>OneHot<around*|(|C|)>,
  <with|font-series|bold|z>\<in\>\<bbb-R\><rsup|L>>>|<cell|<math|<wide*|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|>\<mid\><with|font-series|bold|z>|)>|\<wide-underbrace\>><rsub|ProductOfBernoullis>
  <wide*|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z>\<mid\><with|font-series|bold|y>|)>|\<wide-underbrace\>><rsub|Gaussian>
  <wide*|p<rsub|<with|font-series|bold|>><around*|(|<with|font-series|bold|y>|)>|\<wide-underbrace\>><rsub|<text|OneHotCategorical>>>>>|<row|<cell|VRNN>|<cell|<math|<with|font-series|bold|x><rsub|t>\<in\><around*|{|0,1|}><rsup|28>>>|<cell|<math|<with|font-series|bold|z><rsub|t>\<in\>\<bbb-R\><rsup|L>>>|<cell|<math|<big|prod><rsub|t=1><rsup|T><wide*|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<leq\>t>|)>|\<wide-underbrace\>><rsub|ProductOfBernoullis>
  <wide*|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|t>|)>|\<wide-underbrace\>><rsub|Gaussian>>>>>>>>
    Summary of latent variable models presented in this tutorial. FA means
    Factor Analysis (Section <reference|sec:fa>); VAE means Variational
    Auto-Encoder (<cite|kingma2013auto>; Section <reference|sec:vae>); CVAE
    means Conditional VAE (<cite|sohn2015learning>; Section
    <reference|sec:cvae>); GMVAE means Gaussian Mixture VAE (<cite|gmvae>;
    Section <reference|sec:gmvae>); VRNN means Variational Recurrent Neural
    Network (<cite|chung2015recurrent>; Section <reference|sec:vrnn>). For
    all models except FA, the dataset used was MNIST (images of size
    <math|28\<times\>28>). More specifically, we used normalized MNIST for
    VAE and CVAE and binarized MNIST for GMVAE and VRNN. This was done to
    showcase that latent variable models can have a variety of output
    distributions. \ \ <label|table:all-models>
  </big-table>>

  In this section, we will derive the AEVB training procedure for models
  listed in Table <reference|table:all-models>.

  <subsection|What exactly is the AEVB algorithm?>

  So far, we have discussed how E-step and M-step in EM can be approximated.
  However, we haven't yet arrived at AEVB<\footnote>
    We have already gotten to the \PVB\Q part; the \PVB\Q part refers to the
    fact that the approximate E-step is essentially (amortized) variational
    inference, which is also commonly referred to as the Variational Bayesian
    approach.\ 
  </footnote>. Compared to just performing approximate E-steps and M-steps,
  AEVB makes the following additional changes. Firstly, instead of waiting
  for approximate E-step and M-step to converge before moving onto one
  another, AEVB performs gradient ascent with respect to
  <math|<with|font-series|bold|\<phi\>>,<with|font-series|bold|\<theta\>>>
  simultaneously. This can have the advantage of fast convergence, as we
  share see Section <reference|sec:fa-results>. Secondly, the \PAE\Q part
  refers to using a specific unbiased, low-variance and easy-to-evalaute
  estimator for the per-example ELBO such that the gradient of that estimator
  (with respect <math|<with|font-series|bold|\<phi\>>> and
  <math|<with|font-series|bold|\<theta\>>>) is an unbiased estimator of the
  gradient of the per-example ELBO. In this section, we will derive this
  estimator for several interesting models and showcase PyTorch code snippets
  for implementing the generative, inferential and algorithmic components.

  <subsection|Factor analysis model><label|sec:fa>

  <subsubsection|Generative model>

  The factor analysis (FA) model is the generative model defined as follows:

  <\eqnarray*>
    <tformat|<table|<row|<cell|<with|font-series|bold|x><rsub|i>>|<cell|\<sim\>>|<cell|<with|font|cal|N><around*|(|<with|font-series|bold|W><with|font-series|bold|z><rsub|i>,<with|font-series|bold|\<Phi\>>|)>>>|<row|<cell|<with|font-series|bold|z><rsub|i>>|<cell|\<sim\>>|<cell|<with|font|cal|N><around*|(|0,<with|font-series|bold|I><rsub|L>|)>>>>>
  </eqnarray*>

  where <math|<with|font-series|bold|z><rsub|i>\<in\>\<bbb-R\><rsup|L>> is
  the latent variable, <math|<with|font-series|bold|x><rsub|i>\<in\>\<bbb-R\><rsup|D>>
  is the observed variable, <math|<with|font-series|bold|W>\<in\>\<bbb-R\><rsup|D\<times\>L>>
  is the <with|font-shape|italic|factor loading >matrix and
  <math|<with|font-series|bold|\<Phi\>>> is a diagonal covariance matrix. The
  observed variable <math|<with|font-series|bold|x>> is \Pgenerated\Q by
  linearly transforming the latent variable <math|<with|font-series|bold|z>>
  and adding diagonal gaussian noise. We have assumed that
  <math|<with|font-series|bold|x>> has zero mean, since it's trivial to
  de-mean a dataset.

  For simplicity, we fit a low-dimensional FA model with <math|L=2> and
  <math|D=3> to a synthetic dataset generated by a ground-truth FA model with
  <math|L=2> and <math|D=3>. Due to the difficulty of visualizing
  3-dimensional data, we show the data projected
  <math|x<rsub|1>>-<math|x<rsub|2>>, <math|x<rsub|1>>-<math|x<rsub|3>> and
  <math|x<rsub|2>>-<math|x<rsub|3>> planes (Figure <reference|fig:fa-data>).
  The goal is to see whether AEVB can be used to successfully fit the FA
  model.<float|float|t|<\big-figure|<image|01_factor_analysis/fa_data.pdf|0.8par|||>>
    Synthetic dataset (<math|n=1000>) generated by a factor analysis model
    with <math|L=2> and <math|D=3>.<label|fig:fa-data>
  </big-figure>>

  The FA model to be fitted can be defined as a PyTorch<\footnote>
    <python|nn> is the short-hand for <python|torch.nn>; <python|Ind> is the
    short-hand for <python|torch.distributions.Independent>; <python|Normal>
    is the short-hand for <python|torch.distributions.Normal>.
  </footnote> module, which conveniently allows for learnable
  <math|<with|font-series|bold|W>> and learnable standard deviation vector
  (which is the diagonal of <math|<with|font-series|bold|\<Phi\>>>):\ 

  <with|font-base-size|8|<\python-code>
    class p_x_given_z_class(nn.Module):

    \ \ \ \ 

    \ \ \ \ def __init__(self):

    \ \ \ \ \ \ \ \ super().__init__()

    \ \ \ \ \ \ \ \ self.W = nn.Parameter(data=torch.randn(3, 2))

    \ \ \ \ \ \ \ \ self.pre_sigma = nn.Parameter(data=torch.randn(3))

    \ \ \ \ \ \ \ \ 

    \ \ \ \ @property

    \ \ \ \ def sigma(self):

    \ \ \ \ \ \ \ \ return F.softplus(self.pre_sigma)

    \ \ \ \ \ \ \ \ 

    \ \ \ \ def forward(self, zs):

    \ \ \ \ \ \ \ \ # zs shape: (batch size, 2)

    \ \ \ \ \ \ \ \ mus = (self.W @ zs.T).T \ # mus shape: (batch size, 3)

    \ \ \ \ \ \ \ \ return Ind(Normal(mus, sigma),
    reinterpreted_batch_ndims=1) \ # sigma shape: (3, )
  </python-code>>

  <subsubsection|Approximate posterior>

  Running AEVB requires that we define a family of approximate posteriors
  <math|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>.
  Fortunately, for an FA model, analytic results are available (see 12.1.2 of
  <cite|murphy2012machine>): one can show that the exact posterior
  <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>
  is a Gaussian whose mean is related to <math|<with|font-series|bold|x>> by
  a linear transformation (we shall denote this matrix by
  <math|<with|font-series|bold|V>>) and whose covariance matrix is full but
  independent of <math|<with|font-series|bold|x>> (we shall denote this
  matrix by <with|font-series|bold|<math|\<Sigma\>>>). Therefore, we can
  simply pick such Gaussians as the parametrized family<\footnote>
    This family contains the true posterior, so doing variational inference
    for FA turns out to be doing exact inference, except that we don't need
    to derive the complicated closed-form formulas for
    <math|<with|font-series|bold|V>> and <math|<with|font-series|bold|\<Sigma\>>>.
  </footnote> (<math|<with|font-series|bold|\<phi\>>=<around*|(|<with|font-series|bold|V>,<with|font-series|bold|\<Sigma\>>|)>>),
  and define its PyTorch<\footnote>
    <python|><python|MNormal> is the short-hand for
    <python|torch.distributions.MultivariateNormal>. \ 
  </footnote> module:

  <with|font-base-size|8|<\python-code>
    class q_z_given_x_class(nn.Module):

    \ \ \ \ 

    \ \ \ \ def __init__(self):

    \ \ \ \ \ \ \ \ super().__init__()

    \ \ \ \ \ \ \ \ self.V = nn.Parameter(data=torch.randn(2, 3))

    \ \ \ \ \ \ \ \ self.cov_decomp = nn.Parameter(torch.cholesky(torch.eye(2),
    upper=True))

    \ \ \ \ \ \ \ 

    \ \ \ \ @property

    \ \ \ \ def cov(self):

    \ \ \ \ \ \ \ \ temp = torch.triu(self.cov_decomp)

    \ \ \ \ \ \ \ \ return temp.T @ temp

    \ \ \ \ \ \ \ \ 

    \ \ \ \ def forward(self, xs):

    \ \ \ \ \ \ \ \ # xs shape: (batch size, 3)

    \ \ \ \ \ \ \ \ mus = (self.V @ xs.T).T

    \ \ \ \ \ \ \ \ return MNormal(mus, self.cov)
  </python-code>>

  where we have followed the standard practice to learn the
  <with|font-shape|italic|Cholesky decomposition> of the covariance matrix
  rather than the covariance matrix directly, since entries of the
  decomposition are unconstrained (i.e., real numbers) and hence more
  amendable to gradient-based optimization.

  <subsubsection|Estimator of per-example ELBO><label|sec:fa-aevb>

  Recall that, in both the E-step and the M-step, the primary challenge is
  that we need to compute gradients of per-example ELBOs: since the
  expectation operators contained in per-example ELBOs are not assumed to be
  tractable, we cannot evaluate these gradients exactly and must resort to
  using estimators for these gradients. It turns out that we can first
  construct an unbiased, low-variance estimator for each expectation rather
  than for each gradient; then, as long as the source
  <with|font-shape|italic|>of variability of this estimator does
  <with|font-shape|italic|not> depend on the parameters (which is already
  true for <math|<with|font-series|bold|\<theta\>>>), the gradient of this
  unbiased estimator would be an unbiased estimator of the gradient. To
  achieve this \Pindependence\Q, we apply the
  <with|font-shape|italic|reparametrization trick> to the per-example ELBO as
  follows:

  <\eqnarray*>
    <tformat|<table|<row|<cell|>|<cell|>|<cell|\<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>><around*|[|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>-log
    q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>|]>>>|<row|<cell|>|<cell|=>|<cell|\<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>><around*|[|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>\<mid\><with|font-series|bold|z><rsub|i>|)>+log
    p<with|font-series|bold|><around*|(|<with|font-series|bold|z><rsub|i>|)>-log
    q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>|]>>>|<row|<cell|>|<cell|=>|<cell|\<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>><around*|[|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>\<mid\><with|font-series|bold|z><rsub|i>|)>|]>-D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>\<parallel\>p<around*|(|<with|font-series|bold|z><rsub|i>|)>|)>>>|<row|<cell|>|<cell|=>|<cell|\<bbb-E\><rsub|<wide*|<with|font-series|bold|\<varepsilon\>><rsub|i>\<sim\><with|font|cal|N><around*|(|0,<with|font-series|bold|I><rsub|2>|)>|\<wide-underbrace\>><rsub|<text|No
    longer involves <math|<with|font-series|bold|\<phi\>>!>>>><around*|[|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>\<mid\><with|font-series|bold|z><rsub|i><rsup|s>|)>|]>-D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>\<parallel\>p<around*|(|<with|font-series|bold|z><rsub|i>|)>|)><space|1em><around*|(|<text|><with|font-series|bold|z><rsub|i><rsup|s>=<with|font-series|bold|V>
    <with|font-series|bold|x><rsub|i>+cholesky<around*|(|<with|font-series|bold|\<Sigma\>>|)><with|font-series|bold|\<varepsilon\>><rsub|i>|)>,>>>>
  </eqnarray*>

  where the second KL term can be evaluated in closed form for Gaussians
  (which is the case for FA), and the source of randomness in the first
  expectation is indeed no longer depend on
  <math|<with|font-series|bold|\<phi\>>>. We have used
  <math|<text|><with|font-series|bold|z><rsub|i><rsup|s>> to denote the
  <with|font-shape|italic|reparametrized sample>. This reparametrized
  expression allows us to instantiate the following unbiased, low-variance
  estimator of the per-example ELBO:

  <\equation*>
    <wide|ELBO|^><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|\<theta\>>,<with|font-series|bold|\<phi\>>|)>=log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>\<mid\><with|font-series|bold|z><rsub|i><rsup|s>|)>-D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>\<parallel\>p<with|font-series|bold|<rsub|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>|)>|)><space|1em><around*|(|<text|><with|font-series|bold|z><rsub|i><rsup|s>=<with|font-series|bold|V>
    <with|font-series|bold|x><rsub|i>+cholesky<around*|(|<with|font-series|bold|\<Sigma\>>|)><with|font-series|bold|\<varepsilon\>><rsub|i>|)>,
  </equation*>

  where <math|log p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>\<mid\><with|font-series|bold|z><rsub|i><rsup|s>|)>>
  intuitively measures how well the generative and inference components
  collaboratively perform <with|font-shape|italic|reconstruction> or
  <with|font-shape|italic|auto-encoding><\footnote>
    Hence the name <with|font-shape|italic|Auto-Encoding> Variational Bayes.
    If the expectation within the KL term is also sampled (which yields a
    higher-variance estimator), the algorithm is instead called
    <with|font-shape|italic|Stochastic Gradient> Variational Bayes (SGVB).
  </footnote>: encoding <math|<with|font-series|bold|x><rsub|i>>
  probabilistically into <math|<with|font-series|bold|z><rsub|i><rsup|s>>,
  and then decoding <math|<with|font-series|bold|z><rsub|i>>
  deterministically into <math|<with|font-series|bold|x><rsub|i><rsup|s>>. In
  PyTorch<\footnote>
    <python|kl_divergence> is the short-hand for
    <python|torch.distributions.kl.kl_divergence>. Also, note that we used
    <python|rsample> instead of <python|sample> \U this is
    <with|font-shape|italic|crucial>; otherwise we would not be able to
    differentiate through <math|<with|font-series|bold|z><rsub|i><rsup|s>>.\ 
  </footnote>, we can implement this estimator and compute the gradient of it
  with respect to <math|<with|font-series|bold|\<theta\>>> and
  <math|<with|font-series|bold|\<phi\>>> as follows:

  <with|font-base-size|8|<\python-code>
    class AEVB(nn.Module):

    \ \ \ \ # ...

    \ \ \ \ def step(self, xs):

    \ \ \ \ \ \ \ \ # xs shape: (batch size, 3)

    \ \ \ \ \ \ \ \ posterior_over_zs = self.q_z_given_x(xs)

    \ \ \ \ \ \ \ \ kl = D.kl.kl_divergence(posterior_over_zs, self.p_z)

    \ \ \ \ \ \ \ \ zs = posterior_over_zs.rsample() \ # reparametrized
    samples

    \ \ \ \ \ \ \ \ rec = self.p_x_given_z(zs).log_prob(xs) \ #
    reconstruction

    \ \ \ \ \ \ \ \ per_example_elbos = rec - kl \ # values of estimators of
    per-example ELBOs

    \ \ \ \ \ \ \ \ mini_batch_elbo = per_example_elbos.mean()

    \ \ \ \ \ \ \ \ loss = - mini_batch_elbo

    \ \ \ \ \ \ \ \ self.optimizer.zero_grad()

    \ \ \ \ \ \ \ \ loss.backward()

    \ \ \ \ \ \ \ \ self.optimizer.step()

    \ \ \ \ # ...
  </python-code>>

  <subsubsection|Results><label|sec:fa-results>

  <with|font-series|bold|Experiment 1.><float|float|t|<\big-figure|<image|01_factor_analysis/fa_learning_curve.pdf|1par|||>>
    Test set performance of the FA model across training. Red and green
    curves show that estimated ELBO and evidence improves towards the
    evidence of the true model (black dotted line) respectively, and that
    ELBO is indeed a lower bound to the evidence. As ELBO improves, we see
    that generated data (orange points) gradually matches test data (blue
    points) in distribution.<label|fig:fa-learning>
  </big-figure>> In this experiment, we empirically assess the convergence of
  AEVB on our simple FA model. We run gradient ascent on estimated mini-batch
  ELBO<\footnote>
    This is simply an average of estimators of per-example ELBOs, as shown in
    the code snippet.
  </footnote>, and after every gradient step we measure performance of AEVB
  on two metrics: the estimated ELBO on the entire test set (<math|n=1000>)
  and the exact evidence on the entire test set. For training
  hyperparameters, we used a mini-batch size of 32 and Adam
  <cite|kingma2014adam> with a learning rate of 1e-2.

  It is worth noting that, for arbitrary latent variable models, the evidence
  is generally intractable since it involves accurately evaluating the
  integral in Equation <reference|eq:mle>. While Monte Carlo integration (by
  first obtaining samples from <math|p<around*|(|<with|font-series|bold|z><rsub|i>|)>>
  and then averaging <math|p<around*|(|<with|font-series|bold|x><rsub|i>\<mid\><with|font-series|bold|z><rsub|i>|)>>)
  can work, it has high variance when the latent space has high
  dimensionality and requires too much computation to process all the
  samples. Fortunately, the evidence can be expressed analytically for an FA
  model:

  <with|font-base-size|8|<\python-code>
    class AEVB(nn.Module):

    \ \ \ \ # ... \ \ \ 

    \ \ \ \ def compute_evidence(self, xs):

    \ \ \ \ \ \ \ \ # xs shape: (batch size, 3)

    \ \ \ \ \ \ \ \ W = self.p_x_given_z.W

    \ \ \ \ \ \ \ \ Phi = (self.p_x_given_z.sigma * torch.eye(3)) ** 2

    \ \ \ \ \ \ \ \ p_x = MNormal(torch.zeros(3), Phi + W @ W.T) \ # Phi + W
    @ W.T is low-rank approximation

    \ \ \ \ \ \ \ \ return float(p_x.log_prob(xs).mean()) \ \ \ 

    \ \ \ \ # ...
  </python-code>>

  During training, we also generate data from the learned FA model to check
  whether they match the test data in distribution. This check is similar to
  a posterior predictive check in Bayesian model fitting, which allows us to
  see whether the model of choice is appropriate (e.g., does it underfit?).
  Finally, we note that the learned FA model will not recover the parameters
  of the true FA model, since the matrix <math|<with|font-series|bold|W>> is
  only unique up to a right-hand side multiplication with a 2x2 rotation
  matrix.

  Figure <reference|fig:fa-learning> shows the results of this experiment. We
  see that estimated ELBO and evidence on the test set improve over time,
  eventually coming very close to the evidence of the true model. In
  particular, ELBO is indeed a lower bound to the evidence. Predictive checks
  at different stages of training shows that, as ELBO improves, generated
  data is closer and closer to and eventually indistinguishable from test
  data . These results suggest that AEVB was successful at fitting the FA
  model. Empirically, we also find less expressive approximate posteriors
  (e.g., with a diagonal covariance matrix, or with a diagonal covariance
  matrix with fixed<\footnote>
    This works well only when the fixed values are small.
  </footnote> entries) to work reasonaly well.

  <with|font-series|bold|Experiment 2.> <float|float|t|<\big-figure|<image|01_factor_analysis/fa_learning_curve_em.pdf|1par|||>>
    Test set performance of the FA model across training when alternating
    between periods of only updating inference parameters
    <math|<with|font-series|bold|\<phi\>>> (gray regions) and periods of only
    updating generative parameters <math|<with|font-series|bold|\<theta\>>>
    (white regions). In gray regions, ELBO becomes tight; in white regions,
    both ELBO and evidence improves but ELBO is no longer tight.
    <label|fig:fa-em>
  </big-figure>>In this experiment, we confirm that viewing AEVB through the
  lense of EM is a reasonable one. In particular, we verify the following: if
  we keep updating the inference parameters without updating the generative
  parameters (approximate E-step), then ELBO would become a tight lower bound
  to the evidence; if we then switch to keep updating the generative
  parameters without updating the inference parameters (approximate M-step),
  then both ELBO and evidence would improve but ELBO would no longer be a
  tight lower bound. Hyperparameter values are unchanged from Experiment 1.

  The experiment is designed as follows. We alternate between only updating
  inference parameters for 1000 gradient steps and only updating generative
  parameters for 1000 gradient steps for two rounds, which adds up 4000
  gradient steps in total. As in Experiment 1, we are tracking the estimated
  ELBO and evidence evaluated on the entire test set after gradient step.\ 

  Figure <reference|fig:fa-em> shows the results for this experiment. Gray
  regions represent periods during which we only updated the inference
  aprameters, and white regions represent periods during which we only
  updated the generative parameters. In gray regions, we see that the
  evidence is fixed while ELBO gradually becomes a tight lower bound. From
  hindsight, this shouldn't be surprising, since inference parameters do not
  participate in the evidence computation. In white regions, we see that both
  ELBO and evidence improves, but ELBO is no longer a tight lower bound.\ 

  <subsection|Variational autoencoder><label|sec:vae>

  <subsubsection|Generative model>

  <float|float|t|<\big-figure|<image|02_vae/vae_mnist_orgs.pdf|0.8par|||>>
    Original MNIST images.<label|fig:vae-mnist-org>
  </big-figure>>The generative part of VAE <cite|kingma2013auto> for
  normalized<\footnote>
    Original MNIST is on the scale of 0-255 (discrete). We follow the common
    practice of adding Uniform noise from 0 to 1 to each pixel and then
    dividing by 256 for normalization.
  </footnote> MNIST images (Figure <reference|fig:vae-mnist-org>) is defined
  as follows:

  <\eqnarray*>
    <tformat|<table|<row|<cell|<with|font-series|bold|x><rsub|i>>|<cell|\<sim\>>|<cell|<text|Product-Of-Continuous-Bernoullis><around*|(|<with|font-series|bold|\<lambda\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>|)>|)>>>|<row|<cell|<with|font-series|bold|z><rsub|i>>|<cell|\<sim\>>|<cell|<with|font|cal|N><around*|(|0,<with|font-series|bold|I><rsub|L>|)>>>>>
  </eqnarray*>

  where <math|<with|font-series|bold|z><rsub|i>\<in\>\<bbb-R\><rsup|L>> is
  the latent variable and <math|<with|font-series|bold|x><rsub|i>\<in\>\<bbb-R\><rsup|D>>
  is the observed variable. In particular, <math|D=28\<times\>28> where
  <math|28> is the height and width of each image.
  Product-Of-Continuous-Bernoullis is a product of <math|D> independent
  continuous Bernoulli distributions (<cite|loaiza2019continuous>; each of
  which has support <math|<around*|[|0,1|]>> with parameter
  <math|\<lambda\>\<in\><around*|[|0,1|]>>) with PDF

  <\equation*>
    p<around*|(|<with|font-series|bold|x><rsub|i>\<mid\><with|font-series|bold|z><rsub|i>|)>=<big|prod><rsub|j=1><rsup|D><text|Continuous-Bernoulli><around*|(|x<rsub|i
    j>\<mid\>\<lambda\><rsub|i j >|)><text|<space|1em>where<space|1em>>\<lambda\><rsub|i
    j >=<with|font-series|bold|\<lambda\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>|)><rsub|j>
  </equation*>

  where <math|<with|font-series|bold|\<lambda\>><rsub|<with|font-series|bold|\<theta\>>>:\<bbb-R\><rsup|L>\<rightarrow\><around*|[|0,1|]><rsup|D>>
  is a neural network that maps latent vectors to parameter vectors of the
  product of independent continuous Bernoullis. We can define this generative
  model in PyTorch<\footnote>
    <python|><python|CB> is the short-hand for
    <python|torch.distributions.ContinuousBernoulli>. \ 
  </footnote> (following the network architecture in the official TensorFlow
  code<\footnote>
    Code: <slink|https://github.com/cunningham-lab/cb_and_cc/blob/master/cb/utils.py>
  </footnote> for <cite|loaiza2019continuous>):

  <\with|font-base-size|8>
    <\python-code>
      class p_x_given_z_class(nn.Module):

      \;

      \ \ \ \ def __init__(self, z_dim=20, x_dim=28*28):

      \ \ \ \ \ \ \ \ super().__init__()

      \ \ \ \ \ \ \ \ self.z_dim = z_dim

      \ \ \ \ \ \ \ \ self.x_dim = x_dim

      \ \ \ \ \ \ \ \ self.lambdas = nn.Sequential(

      \ \ \ \ \ \ \ \ \ \ \ \ nn.Linear(self.z_dim, 500),

      \ \ \ \ \ \ \ \ \ \ \ \ nn.ReLU(),

      \ \ \ \ \ \ \ \ \ \ \ \ nn.Dropout(0.1),

      \ \ \ \ \ \ \ \ \ \ \ \ nn.Linear(500, 500),

      \ \ \ \ \ \ \ \ \ \ \ \ nn.ReLU(),

      \ \ \ \ \ \ \ \ \ \ \ \ nn.Dropout(0.1),

      \ \ \ \ \ \ \ \ \ \ \ \ nn.Linear(500, self.x_dim),

      \ \ \ \ \ \ \ \ \ \ \ \ nn.Sigmoid()

      \ \ \ \ \ \ \ \ )

      \;

      \ \ \ \ def forward(self, zs):

      \ \ \ \ \ \ \ \ # zs shape: (batch size, L)

      \ \ \ \ \ \ \ \ return Ind(CB(self.lambdas(zs)), 1)
    </python-code>
  </with>

  Of course, the choice of output distribution is due to the nature of
  normalized MNIST data that we are trying to model<\footnote>
    In fact, any product of distributions defined over the interval
    <math|<around*|[|0,1|]>> would be reasonable, e.g., the Beta
    distribution.
  </footnote>, and other choices are needed for other types of data. For
  example, for binarized MNIST, Bernoulli distributions would be sufficient.
  Also, our choice is not perfect, since it does not capture the correlation
  of neighboring pixels, which has consequences that we will discuss.

  <subsubsection|Approximate posterior>

  Unlike for FA models, the posterior for a VAE model is not tractable, since
  the relationship between the latent and observed variables, as specified by
  the two neural networks <math|<with|font-series|bold|\<mu\>><rsub|<with|font-series|bold|\<theta\>>>>
  and <math|<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<theta\>>>>,
  is highly nonlinear. To define a flexible enough family of approximate
  posterior to represent the true posterior with enough accuracy, we also use
  a neural network, though in practice the output distribution can be
  relatively simple, e.g., a diagonal Gaussian:

  <\equation*>
    q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>=<with|font|cal|N><around*|(|<with|font-series|bold|\<mu\>><rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|x><rsub|i>|)>,<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|x><rsub|i>|)>|)>
  </equation*>

  which can be implemented as (again, following official code of
  <cite|loaiza2019continuous>):

  <\with|font-base-size|8>
    <\python-code>
      class q_z_given_x_class(nn.Module):

      \;

      \ \ \ \ def __init__(self, z_dim, x_dim):

      \ \ \ \ \ \ \ \ super().__init__()

      \ \ \ \ \ \ \ \ self.z_dim = z_dim

      \ \ \ \ \ \ \ \ self.x_dim = x_dim

      \ \ \ \ \ \ \ \ self.shared = nn.Sequential(

      \ \ \ \ \ \ \ \ \ \ \ \ nn.Linear(x_dim, 500),

      \ \ \ \ \ \ \ \ \ \ \ \ nn.ReLU(),

      \ \ \ \ \ \ \ \ \ \ \ \ nn.Dropout(0.1),

      \ \ \ \ \ \ \ \ \ \ \ \ nn.Linear(500, 500),

      \ \ \ \ \ \ \ \ \ \ \ \ nn.ReLU(),

      \ \ \ \ \ \ \ \ \ \ \ \ nn.Dropout(0.1),

      \ \ \ \ \ \ \ \ )

      \ \ \ \ \ \ \ \ self.mus = nn.Linear(500, z_dim)

      \ \ \ \ \ \ \ \ self.sigmas = nn.Sequential(

      \ \ \ \ \ \ \ \ \ \ \ \ nn.Linear(500, z_dim),

      \ \ \ \ \ \ \ \ \ \ \ \ nn.Softplus()

      \ \ \ \ \ \ \ \ )

      \;

      \ \ \ \ def forward(self, xs):

      \ \ \ \ \ \ \ \ # xs shape: (batch size, 28 * 28)

      \ \ \ \ \ \ \ \ xs = self.shared(xs)

      \ \ \ \ \ \ \ \ return Ind(Normal(self.mus(xs), self.sigmas(xs)), 1)
      \ \ \ 
    </python-code>
  </with>

  Recall that optimizing with respect to <math|<with|font-series|bold|<with|font-series|bold|\<phi\>>>>
  has the interpretation of minimizing the (reverse) KL between
  <math|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>
  and <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>.
  Since <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>
  is likely to be multi-modal due to nonlinearlity in the generative model,
  minimizing the reverse KL leads to <with|font-shape|italic|zero forcing>
  behavior of <math|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>,
  i.e., it locks onto a single mode of <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>.
  One could technically use a multi-modal approximate posterior (e.g., see
  <cite|graves2016stochastic> for reparametrization trick for mixture
  densities), leading to a tighter ELBO. However, it turns out that using
  Gaussians with diagonal covariance can already lead to satisfactory
  performance (in terms of quality of generated outputs) in practice.

  <subsubsection|Results>

  We trained<\footnote>
    Because AEVB for VAE is identical to AEVB for FA, we simply use the
    estimator derived in Section <reference|sec:fa-aevb>.
  </footnote> a VAE on the normalized MNIST dataset by optimizing a
  mini-batch estimate of ELBO via gradient ascent until convergence. For
  training hyperparameters, we used a latent dimension of 20, a mini-batch
  size of 100, a dropout rate of <math|p=0.1> and Adam with a learning rate
  of 3e-4.

  <\float|float|t>
    <\big-figure|<image|02_vae/vae_learning_curve.pdf|0.8par|||>>
      Estimated ELBO (test set) of VAE across training. It first improves
      quickly then plateaus.<label|fig:vae-elbo>
    </big-figure>
  </float>Figure <reference|fig:vae-elbo> shows the estimated ELBO on the
  test set across training. Training was halted after estimated ELBO
  plateaus. We plotted the parameters of 30 Product of Continuous Bernoullis
  obtained from 30 latent draws from <math|p<around*|(|<with|font-series|bold|z>|)>>
  in Figure <reference|fig:vae-gens>, and plotted one sample from each
  Product of Continuous Bernoullis in Figure <reference|fig:vae-gens-sample>.\ 

  <\float|float|t>
    <\big-figure|<image|02_vae/vae_mnist_gens_param.pdf|0.8par|||>>
      Parameters of 30 Products of Continuous Bernoullis obtained from 30
      latent draws.<label|fig:vae-gens>
    </big-figure>
  </float>Compared to the original MNIST digits, sampled digits have a lot
  more noise littered across the image, which can be attributed to the
  model's inability to capture correlation between pixels. The quality of
  generation is also highly variable. For example, in Figure
  <reference|fig:vae-gens>, the digit on the first row and second column has
  excellent quality while the digit on the first row and fourth column
  doesn't look like a digit. Overall, the generative model seems to have
  picked up the distribution of digits, but there's clearly room for
  improvement. <float|float|t|<\big-figure|<image|02_vae/vae_mnist_gens_sample.pdf|0.8par|||>>
    Samples from 30 Product of Continuous Bernoullis whose parameters are
    plotted in Figure <reference|fig:vae-gens>. <label|fig:vae-gens-sample>
  </big-figure>>

  We also visualized the structure of the latent space in Figure
  <reference|fig:vae-tsne>. We computed means of
  <math|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>
  for all <math|<with|font-series|bold|x><rsub|i>> in the test set, applied
  scikit-learn's implementation of t-SNE (<cite|van2008visualizing>) to
  project these latent means to 2 dimensions, and finally scattered and
  colored the output vectors. We see that the resulting clusters correspond
  nicely to clusters we had in mind as humans.
  <float|float|t|<\big-figure|<image|02_vae/vae_tsne.pdf|0.4par|||>>
    2-dimensional t-SNE projection of latent means (20 dimensional) obtained
    from test set. Digit labels (grey) are placed at the median of latent
    means of each class. We see that the resulting clusters correspond nicely
    to clusters we had in mind as humans.<label|fig:vae-tsne>
  </big-figure>>

  <subsection|Conditional VAE><label|sec:cvae><label|sec:cvae>

  <subsubsection|Generative model>

  While VAE can generate novel data with good quality, we might want to
  additionally condition our model to generate novel data based on some other
  observed quantity <math|<with|font-series|bold|y<rsub|>><rsub|i>>. For a
  concrete example, in the context of normalized MNIST, we might to generate
  new digits from a specific class \U in this case
  <math|<with|font-series|bold|y<rsub|>><rsub|i>> would represent the one-hot
  class label. More formally, this is the problem of modelling the
  conditional density <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>\<mid\><with|font-series|bold|y<rsub|>><rsub|i>|)>>
  using a latent variable model. Such a model has a joint density of
  <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y<rsub|>><rsub|i>|)>>,
  and the full decomposition of the joint is
  <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>\<mid\><with|font-series|bold|y<rsub|>><rsub|i>,<with|font-series|bold|z><rsub|i>|)>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y<rsub|>><rsub|i>|)>>,
  which is exactly the model specified in the Conditional VAE (CVAE)
  <cite|sohn2015learning>:

  <\eqnarray*>
    <tformat|<table|<row|<cell|<with|font-series|bold|x><rsub|i>>|<cell|\<sim\>>|<cell|<text|Product-Of-Continuous-Bernoullis><around*|(|<with|font-series|bold|p><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|y><rsub|i>,<with|font-series|bold|z><rsub|i>|)>|)>>>|<row|<cell|<with|font-series|bold|z><rsub|i>>|<cell|\<sim\>>|<cell|<with|font|cal|N><around*|(|<with|font-series|bold|\<mu\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|y><rsub|i>|)>,<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|y><rsub|i>|)>|)>.>>>>
  </eqnarray*>

  It is worth noting that this is not the only reasonable model. Here are two
  other models that assume some independence instead of using the full
  decomposition. One option is to only condition
  <math|<with|font-series|bold|z><rsub|i>> on
  <math|<with|font-series|bold|y><rsub|i>>:

  <\eqnarray*>
    <tformat|<table|<row|<cell|<with|font-series|bold|x><rsub|i>>|<cell|\<sim\>>|<cell|<text|Product-Of-Continuous-Bernoullis><around*|(|<with|font-series|bold|p><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>|)>|)>>>|<row|<cell|<with|font-series|bold|z><rsub|i>>|<cell|\<sim\>>|<cell|<with|font|cal|N><around*|(|<with|font-series|bold|\<mu\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|y><rsub|i>|)>,<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|y><rsub|i>|)>|)>.>>>>
  </eqnarray*>

  The other option is to only condition <math|<with|font-series|bold|x><rsub|i>>
  on <math|<with|font-series|bold|y><rsub|i>>:

  <\eqnarray*>
    <tformat|<table|<row|<cell|<with|font-series|bold|x><rsub|i>>|<cell|\<sim\>>|<cell|<text|Product-Of-Bernoullis><around*|(|<with|font-series|bold|p><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|y><rsub|i>,<with|font-series|bold|z><rsub|i>|)>|)>>>|<row|<cell|<with|font-series|bold|z><rsub|i>>|<cell|\<sim\>>|<cell|<with|font|cal|N><around*|(|0,<with|font-series|bold|I><rsub|L>|)>.>>>>
  </eqnarray*>

  In this section, we will focus on the first model that does not assume
  independence, though it's straightforward to extend the training procedure
  to the other two models.

  <subsubsection|Approximate posterior>

  Similar to how we chose <math|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>
  to be a diagonal Gaussian for VAE, here for CVAE we choose
  <math|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>,<with|font-series|bold|y><rsub|i>|)>>
  to be a diagonal Gaussian.

  <subsubsection|Estimator for per-example ELBO>

  Following the approach in Section <reference|sec:fa-aevb>, we first derive
  an unbiased, low-variance estimator of the per-example ELBO whose
  randomness does not depend on the parameters. The per-example ELBO for CVAE
  is almost identical to that of FA and VAE, except that the generative and
  inference components must now be conditioned by
  <math|<with|font-series|bold|y><rsub|i>> as follows:

  <\equation*>
    \<bbb-E\><rsub|<with|font-series|bold|z><rsub|i>\<sim\>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>,<with|font-series|bold|y><rsub|i>|)>><around*|[|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>|)>-log
    q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>,<with|font-series|bold|y><rsub|i>|)>|]>.
  </equation*>

  Therefore, the estimator is simply:\ 

  <\equation*>
    log p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>\<mid\><with|font-series|bold|z><rsub|i><rsup|s>,<with|font-series|bold|y><rsub|i>|)>-D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>,<with|font-series|bold|y><rsub|i>|)>\<parallel\>p<with|font-series|bold|<rsub|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>|)>|)><space|1em><around*|(|<text|><with|font-series|bold|z><rsub|i><rsup|s>=<with|font-series|bold|\<mu\>><rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|y><rsub|i>|)>+<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|y><rsub|i>|)><with|font-series|bold|\<varepsilon\>><rsub|i>,<with|font-series|bold|\<varepsilon\>><rsub|i>\<sim\><with|font|cal|N><around*|(|0,<with|font-series|bold|I><rsub|L>|)>|)>.
  </equation*>

  <subsubsection|Results>

  We trained a CVAE on the normalized MNIST dataset by optimizing a
  mini-batch estimate of ELBO via gradient ascent until convergence. We used
  the same hyperparameters for training VAE.<float|float|t|<\big-figure|<image|03_cvae/mnist_gens_conditional_param.pdf|0.8par|||>>
    Generated images by Conditional VAE. Each row contains all generations
    from the same label.<label|fig:cvae-gens>
  </big-figure>>

  After training, we conditionally generated new digits from each class by
  ancestral sampling of <math|p<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>|)>>
  and then <math|p<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>|)>>.
  The generations are shown in Figure <reference|fig:cvae-gens>, where each
  row contains all generations from the same label. The fact that this works
  well shows that the digit label was indeed exploited by the model for
  reconstruction during training; if we instead passed in random values for
  <math|<with|font-series|bold|y><rsub|i>> instead of ground-truth labels,
  the model would have learned that the digit label is not helpful for
  reconstruction and we would not be able to achieve such results.

  <subsection|Gaussian Mixture VAE><label|sec:gmvae>

  <subsubsection|Generative model>

  The generative part of the Gaussian Mixture VAE (GMVAE) <cite|gmvae> for
  binary MNIST is

  <\eqnarray*>
    <tformat|<table|<row|<cell|<with|font-series|bold|x><rsub|i>>|<cell|\<sim\>>|<cell|<text|Product-Of-Bernoullis><around*|(|<with|font-series|bold|p><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>|)>|)>>>|<row|<cell|<with|font-series|bold|z><rsub|i>>|<cell|\<sim\>>|<cell|<with|font|cal|N><around*|(|<with|font-series|bold|\<mu\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|y><rsub|i>|)>,<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|y><rsub|i>|)>|)>>>|<row|<cell|<with|font-series|bold|y><rsub|i>>|<cell|\<sim\>>|<cell|<text|One-Hot-Categorical><around*|(|<with|font-series|bold|\<pi\>>|)>>>>>
  </eqnarray*>

  where both <math|<with|font-series|bold|y><rsub|i>>, a <math|C>-dimensional
  one-hot vector, and <math|<with|font-series|bold|z><rsub|i>\<in\>\<bbb-R\><rsup|L>>
  are latent variables, and <math|<with|font-series|bold|x><rsub|i>\<in\><around*|{|0,1|}><rsup|D>>
  is the observed variable. It may seem strange that we now have two latent
  variables instead of one, but we could have treated them as a single random
  variable <math|<with|font-series|bold|y><rsub|i>\<parallel\><with|font-series|bold|z><rsub|i>>
  of dimension <math|L+D>, where <math|\<parallel\>> denotes concatenation.
  Additionally, <math|<with|font-series|bold|\<pi\>>>, chosen to be a length
  <math|C> vector <math|<around*|(|1/C,\<ldots\>,1/C|)>>, lives in the
  <math|C>-dimensional simplex; <math|<with|font-series|bold|\<mu\>><rsub|<with|font-series|bold|\<theta\>>>>
  and <math|<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<theta\>>>>
  are both linear transformations (so multiplying with a one-hot vector
  <math|<with|font-series|bold|y><rsub|i>> effectively selects a column from
  their corresponding matrices) except that
  <math|<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<theta\>>>>
  is handled with care such that its output is non-negative;
  <math|p<rsub|<with|font-series|bold|\<theta\>>>> is a multi-layer neural
  network that maps the latent variable <math|<with|font-series|bold|z><rsub|i>>
  into success probabilities of the Product-Of-Bernoullis distribution.

  While this generative model is interpretable, it is not the only such
  model. One can argue that the following model, which resembles the third
  model in Section <reference|sec:cvae>, is also interpretable:

  <\eqnarray*>
    <tformat|<table|<row|<cell|<with|font-series|bold|x><rsub|i>>|<cell|\<sim\>>|<cell|<text|Product-Of-Bernoullis><around*|(|<with|font-series|bold|p><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|y><rsub|i>,<with|font-series|bold|z><rsub|i>|)>|)>>>|<row|<cell|<with|font-series|bold|z><rsub|i>>|<cell|\<sim\>>|<cell|<with|font|cal|N><around*|(|0,<with|font-series|bold|I><rsub|L>|)>>>|<row|<cell|<with|font-series|bold|y><rsub|i>>|<cell|\<sim\>>|<cell|<text|One-Hot-Categorical><around*|(|<with|font-series|bold|\<pi\>>|)>,>>>>
  </eqnarray*>

  where <math|<with|font-series|bold|y><rsub|i>> and
  <math|<with|font-series|bold|z><rsub|i>> can be taken intuitively as class
  label and stylistic features of handwritten digits respectively. In fact,
  this is the M2 model for semi-supervised classification discussed in
  <cite|kingma2014semi>. For a short empirical discussion as to why this
  model doesn't work well for unsupervised clustering and potential fixes,
  see <cite|gmvae>.

  <subsubsection|Approximate posterior>

  The true joint posterior <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|y><rsub|i>,<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>
  factors into <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>,<with|font-series|bold|y><rsub|<rsub|i>>|)>>
  and we can decide on a family of distributions for each of them separately.
  The decision for <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>
  is straightforward: it is a one-hot categorical distribution whose
  parameters are related to <math|<with|font-series|bold|x><rsub|i>> in a
  highly nonlinear fashion. We therefore model this exactly using

  <\equation*>
    q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>=OneHotCategorical<around*|(|<with|font-series|bold|\<pi\>><rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|x><rsub|i>|)>|)>
  </equation*>

  where <math|<with|font-series|bold|\<pi\>><rsub|<with|font-series|bold|\<phi\>>>>
  is a flexible neural network that maps from <math|\<bbb-R\><rsup|D>> to the
  <math|C>-dimensional simplex. For <math|><math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>,<with|font-series|bold|y><rsub|<rsub|i>>|)>>,
  we choose <math|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>,<with|font-series|bold|y><rsub|<rsub|i>>|)>>
  to be the diagonal Gaussian family as for VAE. While the alternative
  factorization <math|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>,<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>=q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>
  is also valid, it doesn't give us the ability to cluster observations
  <math|<with|font-series|bold|x><rsub|i>>, since evaluating
  <math|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>
  would require evaluating the integral

  <\equation*>
    q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>=<big|int>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>,<with|font-series|bold|z><rsub|i>|)>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>
    d<with|font-series|bold|z><rsub|i>.
  </equation*>

  <subsubsection|Estimator for per-example ELBO><label|sec:gmvae-estimate>

  <paragraph|Estimator 1: Marginalization of <math|y<rsub|i>>>

  Following the approach in Section <reference|sec:fa-aevb>, we first derive
  an unbiased, low-variance estimator of the per-example ELBO whose
  randomness does not depend on the parameters. We marginalize out
  <math|<with|font-series|bold|y><rsub|i>> by taking the advantage of the
  fact that it's discrete, and only reparametrize
  <math|<with|font-series|bold|z><rsub|i>>:

  <\with|font-base-size|8>
    <\eqnarray*>
      <tformat|<cwith|1|-1|1|-1|font-base-size|9>|<cwith|3|4|3|3|font-base-size|10>|<table|<row|<cell|>|<cell|>|<cell|\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>,<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>><around*|<left|[|4>|log
      p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>,<with|font-series|bold|y><rsub|i>,<with|font-series|bold|z><rsub|i>|)>-log
      q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>,<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>|<right|]|4>><space|1em><around*|(|<text|per-example
      ELBO>|)>>>|<row|<cell|>|<cell|=>|<cell|\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>,<with|font-series|bold|x><rsub|i>|)>><around*|<left|[|4>|log
      \ p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>\<mid\><with|font-series|bold|z><rsub|i>|)>+<with|color|red|log
      \ p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>|)>>+<with|color|dark
      green|log \ p<around*|(|<with|font-series|bold|y><rsub|i>|)>-log
      q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>><with|color|red|-log
      q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>,<with|font-series|bold|x><rsub|i>|)>>|<right|]|4>>>>|<row|<cell|>|<cell|=>|<cell|<with|font-base-size|9|\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>><around*|<left|[|5>|\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>,<with|font-series|bold|x><rsub|i>|)>><around*|[|log
      p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>\<mid\><with|font-series|bold|><with|font-series|bold|z><rsub|i>|)>|]>+<with|color|red|\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>,<with|font-series|bold|x><rsub|i>|)>><around*|[|log
      p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>|)>-log
      q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>,<with|font-series|bold|x><rsub|i>|)>|]>>|<right|]|5>>>>>|<row|<cell|>|<cell|>|<cell|+\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>><rsub|><around*|<left|[|3>|<with|color|dark
      green|log p<around*|(|<with|font-series|bold|y><rsub|i>|)>-log
      q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>|<right|]|3>>>>|<row|<cell|>|<cell|\<backsimeq\>>|<cell|<with|font-base-size|8|\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>><around*|[|<wide*|log
      p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>\<mid\><with|font-series|bold|z><rsub|i><rsup|s>|)>|\<wide-underbrace\>><rsub|<with|font-series|bold|z><rsub|i><rsup|s><text|
      is a reparametrized sample from >q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>,<with|font-series|bold|x><rsub|i>|)>
      ><with|color|red|-D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>,<with|font-series|bold|x><rsub|i>|)>\<mid\>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>|)>|)>>|]><with|color|dark
      green|-D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>\<mid\>p<around*|(|<with|font-series|bold|y><rsub|i>|)>|)>>>>>|<row|<cell|>|<cell|=>|<cell|<around*|(|<big|sum><rsub|<with|font-series|bold|y><rsub|i>><rsup|>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>\<cdot\><around*|[|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>\<mid\><with|font-series|bold|z><rsub|i><rsup|s>|)>-D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>,<with|font-series|bold|x><rsub|i>|)>\<mid\>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>|)>|)>|]>|)>-D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>\<mid\>p<around*|(|<with|font-series|bold|y><rsub|i>|)>|)><label|eq:gmvae-elbo-marginal><eq-number>>>>>
    </eqnarray*>
  </with>

  where, in the second step, we distributed the expectation operator with
  respect to <math|q<around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>,<with|font-series|bold|x><rsub|i>|)>>
  to different terms and, in the third step, we sampled
  <math|<with|font-series|bold|z><rsub|i><rsup|s>> from
  <math|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>,<with|font-series|bold|x><rsub|i>|)>>
  using the reparametrization trick to ensure that the randomness of the
  estimator does not depend on <math|<with|font-series|bold|\<phi\>>>. Since
  <math|p<around*|(|<with|font-series|bold|y><rsub|i>|)>> has no trainable
  parameters, <math|-D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>\<mid\>p<around*|(|<with|font-series|bold|y><rsub|i>|)>|)>>
  can be written instead as <math|\<bbb-H\><around*|(|q<around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>|)>>,
  the conditional entropy of the unsupervised classifer, plus a constant
  which can be ignored. In PyTorch, Equation
  <math|><reference|eq:gmvae-elbo-marginal> can be conveniently vectorized
  and evaluated as follows:

  <\with|font-base-size|8>
    <\python-code>
      class AEVB(nn.Module):

      \ \ \ \ # ...

      \ \ \ \ def step(self, xs):

      \ \ \ \ \ \ \ \ # xs shape: (batch size, 28 * 28)

      \ \ \ \ \ \ \ \ 

      \ \ \ \ \ \ \ \ q_y = self.q_y_given_x(xs)

      \ \ \ \ \ \ \ \ cond_ent = q_y.entropy()

      \ \ \ \ \ \ \ \ 

      \ \ \ \ \ \ \ \ # ========== code below vectorizes marginalization
      =========

      \ \ \ \ \ \ \ \ 

      \ \ \ \ \ \ \ \ bs = xs.size(0)

      \ \ \ \ \ \ \ \ ys = torch.eye(self.y_dim)[torch.tensor(range(self.y_dim)).repeat_interleave(bs)]

      \ \ \ \ \ \ \ \ xs = xs.repeat(self.y_dim, 1)

      \ \ \ \ \ \ \ \ 

      \ \ \ \ \ \ \ \ post_over_zs = self.q_z(xs, ys)

      \ \ \ \ \ \ \ \ zs = post_over_zs.rsample()

      \ \ \ \ \ \ \ \ 

      \ \ \ \ \ \ \ \ other = self.p_x(zs).log_prob(xs) -
      kl_divergence(post_over_zs, self.p_z(ys))

      \ \ \ \ \ \ \ \ 

      \ \ \ \ \ \ \ \ other = other.reshape(self.y_dim, bs).T

      \ \ \ \ \ \ \ \ other = (q_y.probs * other).sum(dim=1)

      \ \ \ \ \ \ \ \ 

      \ \ \ \ \ \ \ \ # ========== code above vectorizes marginalization
      =========

      \ \ \ \ \ \ \ \ 

      \ \ \ \ \ \ \ \ per_example_elbos = other + cond_ent \ # values of
      estimators of per-example ELBOs

      \ \ \ \ \ \ \ \ mini_batch_elbo = per_example_elbos.mean()

      \ \ \ \ \ \ \ \ loss = - mini_batch_elbo

      \ \ \ \ \ \ \ \ 

      \ \ \ \ \ \ \ \ self.opt.zero_grad()

      \ \ \ \ \ \ \ \ loss.backward()

      \ \ \ \ \ \ \ \ self.opt.step()

      \ \ \ \ # ...
    </python-code>
  </with>

  <paragraph|Estimator 2: Gumbel-Softmax trick>

  It has been shown <cite|gumbel1954statistical|maddison2014A> that one can
  obtain a reparametrized sample of <math|<with|font-series|bold|y><rsub|i>>
  by<with|font-shape|italic|>

  <\equation*>
    <with|font-series|bold|y><rsub|i>=<text|onehot><around*|(|argmax<around*|(|logits+<with|font-series|bold|g><rsub|i>|)>|)>
  </equation*>

  where <math|<with|font-series|bold|g><rsub|i>=<around*|(|g<rsub|i,1>,\<ldots\>,g<rsub|i,c>|)>>
  are i.i.d. samples from <math|Gumbel<around*|(|0,1|)>> distribution and
  <math|logits> is a length-<math|C> vector containing normalized or
  unnormalized log probabilities of the original one-hot categorical
  distribution <math|q<with|font-series|bold|<rsub|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>.
  However, the resulting sample cannot be differentiated through due to the
  argmax operation, since argmax has a gradient of zero at non-zero inputs.
  Instead,, <cite|jang2017categorical|maddison2016concrete> replaces argmax
  with softmax to make it differentiable:

  <\equation*>
    <wide|<with|font-series|bold|y>|~><rsub|i>=softmax<around*|(|<around*|(|logits+<with|font-series|bold|g><rsub|i>|)>/\<tau\>|)>
  </equation*>

  where <math|\<tau\>\<gtr\>0> is called the temperature: when it's low, the
  distribution of <math|<wide|<with|font-series|bold|y>|~><rsub|i>>
  approaches the distribution of <math|<with|font-series|bold|y><rsub|i>>;
  when it's high, <math|<wide|<with|font-series|bold|y>|~><rsub|i>> would lie
  closer to the center of the simplex. The resulting distribution is called
  the Gumbel-Softmax distribution <cite|jang2017categorical> or the Concrete
  distribution <cite|maddison2016concrete>, and the procedure of using a
  differentiable but approximate sample of
  <math|<with|font-series|bold|y><rsub|i>> is called the Gumbel-Softmax trick
  or estimator. For a straight-through variant, see the original paper
  <cite|jang2017categorical>.

  The obvious consequence of using softmax is that the samples are no longer
  one-hot, which may seem counter-intuitive. The key to understanding this is
  by recognizing that the one-hot categorical distribution and the
  Gumbel-Softmax distribution are very similar (in terms of expectation and
  how samples are close to the corners of the simplex) at low temperature
  (e.g., at <math|\<tau\>\<leqslant\>1>) under the same parameter values so
  that they can be used as drop-in substitutions for one another, depending
  on the context. One can therefore see these them as separate \Pheads\Q
  attached to the same vector of logits. Below we discuss two such contexts
  when estimating the ELBO.

  <with|font-series|bold|One context.> We can derive a
  <with|font-shape|italic|slightly biased> (due to replacing argmax with
  softmax) estimator<\footnote>
    Obviously, this estimator has higher variance than the estimator that
    uses marginalization, but evaluating this estimator would have better
    time complexity than doing marginalization, especially when <math|C> is
    large.
  </footnote> of per-example the ELBO by first drawing reparametrized samples
  <math|<around*|(|<with|font-series|bold|><wide|<with|font-series|bold|y>|~><rsub|i><rsup|s>,<with|font-series|bold|z><rsub|i><rsup|s>|)>>
  of the expectation via ancestral sampling, and then evaluating the interior
  of the expectation:

  <\eqnarray*>
    <tformat|<table|<row|<cell|>|<cell|>|<cell|\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>,<with|font-series|bold|x><rsub|i>|)>><around*|[|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>\<mid\><with|font-series|bold|z><rsub|i>|)>+log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>|)>+log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|y><rsub|i>|)>-log
    q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>-log
    q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>,<with|font-series|bold|x><rsub|i>|)>|]>>>|<row|<cell|>|<cell|\<backsimeq\>>|<cell|<wide*|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>\<mid\><wide|<with|font-series|bold|y>|~><rsub|i><rsup|s>,<with|font-series|bold|z><rsub|i><rsup|s>|)>+log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i><rsup|s>\<mid\><wide|<with|font-series|bold|y>|~><rsub|i><rsup|s>|)>+log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<wide|<with|font-series|bold|y>|~><rsub|i><rsup|s>|)>-log
    q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<wide|<with|font-series|bold|y>|~><rsub|i><rsup|s>\<mid\><with|font-series|bold|x><rsub|i><rsup|s>|)>-log
    q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i><rsup|s>\<mid\><wide|<with|font-series|bold|y>|~><rsub|i><rsup|s>,<with|font-series|bold|x><rsub|i>|)>|\<wide-underbrace\>><rsub|<around*|(|<with|font-series|bold|><wide|<with|font-series|bold|y>|~><rsub|i><rsup|s>,<with|font-series|bold|z><rsub|i><rsup|s>|)><text|
    <math|<text| is a reparametrized sample from
    >q<around*|(|<wide|<with|font-series|bold|y>|~><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>q<around*|(|<with|font-series|bold|z><rsub|i>\<mid\><wide|<with|font-series|bold|y>|~><rsub|i>,<with|font-series|bold|x><rsub|i>|)>>>>>>>>
  </eqnarray*>

  where in particular <math|<wide|<with|font-series|bold|y>|~><rsub|i><rsup|s>>
  is sampled using the Gumbel-Softmax trick. The immediate problem is that
  <math|p<around*|(|<with|font-series|bold|y><rsub|i>|)>> and
  <math|q<around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>
  are by default categorical distributions and hence cannot evaluate the log
  probability of sampled <math|<with|font-series|bold|><wide|<with|font-series|bold|y>|~><rsub|i><rsup|s>>
  since <math|<wide|<with|font-series|bold|y>|~><rsub|i><rsup|s>> is
  <with|font-shape|italic|not> one-hot. The solution is to use the
  Gumbel-Softmax head for <math|p<around*|(|<with|font-series|bold|y><rsub|i>|)>>
  and <math|q<around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>.
  In PyTorch, these two heads can be implemented as:

  <with|font-base-size|8|<\python-code>
    class q_y_class(nn.Module):

    \ \ \ \ 

    \ \ \ \ def __init__(self, x_dim, y_dim):

    \ \ \ \ \ \ \ \ super().__init__()

    \ \ \ \ \ \ \ \ self.x_dim = x_dim

    \ \ \ \ \ \ \ \ self.y_dim = y_dim

    \ \ \ \ \ \ \ \ self.logits = nn.Sequential(

    \ \ \ \ \ \ \ \ \ \ \ \ # linear layers and activations

    \ \ \ \ \ \ \ \ )

    \ \ \ \ \ \ \ \ 

    \ \ \ \ def forward(self, xs, head):

    \ \ \ \ \ \ \ \ # xs shape: (batch size, 28 * 28)

    \ \ \ \ \ \ \ \ if head == "one_hot_categorical":

    \ \ \ \ \ \ \ \ \ \ \ \ return OneHotCat(logits=self.logits(xs))

    \ \ \ \ \ \ \ \ elif head == "gumbel_softmax":

    \ \ \ \ \ \ \ \ \ \ \ \ return RelaxedOneHotCat(logits=self.logits(xs),
    temperature=torch.tensor([0.5]))
  </python-code>>

  After training, when generating <math|<with|font-series|bold|x><rsub|i>>
  from samples of <math|p<around*|(|<with|font-series|bold|y><rsub|i>|)>> and
  doing classification using <math|q<around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>,
  we can switch back to using the One-Hot-Categorical head, since they are
  more interpretable for these tasks and represent the what we truly want,
  i.e., discrete latent variable. Note that distributions
  <math|p<around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>|)>>
  and <math|q<around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>,<with|font-series|bold|x><rsub|i>|)>>
  do not suffer from this problem because, as neural networks, they can
  process <math|<with|font-series|bold|><wide|<with|font-series|bold|y>|~><rsub|i><rsup|s>>
  as long as it consists of real entries. And since
  <math|<wide|<with|font-series|bold|y>|~><rsub|i><rsup|s>> can be very close
  to one-hot (though never strictly) during training, these neural networks
  would generalize to one-hot samples for purposes after training, e.g.,
  using <math|p<around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>|)>>
  for conditional generation of <math|<with|font-series|bold|x><rsub|i>>.

  <with|font-series|bold|Another context.> There are many ways to form an
  estimator of the per-example ELBO. Apart from the one just discussed, a
  popular implementation<\footnote>
    Code: <verbatim|https://github.com/jariasf/GMVAE>
  </footnote> decomposes the per-example ELBO as

  <\with|font-base-size|8>
    <\eqnarray*>
      <tformat|<cwith|1|-1|1|-1|font-base-size|10>|<table|<row|<cell|>|<cell|>|<cell|\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>,<with|font-series|bold|x><rsub|i>|)>><around*|<left|[|3>|log
      p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>\<mid\><with|font-series|bold|z><rsub|i>|)>+log
      p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>|)>+log
      p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|y><rsub|i>|)>-log
      q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>-log
      q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>,<with|font-series|bold|x><rsub|i>|)>|<right|]|3>>>>|<row|<cell|>|<cell|=>|<cell|\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>><around*|<left|[|3>|\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>,<with|font-series|bold|x><rsub|i>|)>><around*|[|log
      p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>\<mid\><with|font-series|bold|z><rsub|i>|)>|]>+\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>,<with|font-series|bold|x><rsub|i>|)>><around*|[|log
      p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>|)>-log
      q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><with|font-series|bold|y><rsub|i>,<with|font-series|bold|x><rsub|i>|)>|]>|<right|]|3>>>>|<row|<cell|>|<cell|>|<cell|+\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>><around*|<left|[|3>|log
      p<around*|(|<with|font-series|bold|y><rsub|i>|)>-log
      q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>|<right|]|3>>>>|<row|<cell|>|<cell|\<backsimeq\>>|<cell|<math|log
      p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|i>\<mid\><with|font-series|bold|z><rsub|i><rsup|s>|)>>-D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><wide|<with|font-series|bold|y>|~><rsub|i><rsup|s>,<with|font-series|bold|x><rsub|i>|)>\<mid\>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><wide|<with|font-series|bold|y>|~><rsub|i><rsup|s>|)>|)>-D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>\<mid\>p<around*|(|<with|font-series|bold|y><rsub|i>|)>|)>,>>>>
    </eqnarray*>
  </with>

  where <math|<around*|(|<with|font-series|bold|><wide|<with|font-series|bold|y>|~><rsub|i><rsup|s>,<with|font-series|bold|z><rsub|i><rsup|s>|)><text|>>
  is again a reparametrized sample from <math|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<wide|<with|font-series|bold|y>|~><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|i>\<mid\><wide|<with|font-series|bold|y>|~><rsub|i>,<with|font-series|bold|x><rsub|i>|)>>.
  In this context, since the KL between the two categorical distributions is
  computed analytically, there's no need to use the Gumbel-Softmax head for
  computing log probabilities of <math|<wide|<with|font-series|bold|y>|~><rsub|i><rsup|s>>.\ 

  <subsubsection|Results>

  We trained a GMVAE on binary MNIST by optimizing a mini-batch estimate of
  ELBO via gradient ascent until convergence. In particular, to reduce
  variance as much as possible, we use the marginalizing estimator as
  described in Section <reference|sec:gmvae-estimate>. We used <math|C=10>
  since there are 10 classes digits in MNIST. For training hyperparameters,
  we used the Glorot-Normal <cite|glorot2010understanding> initializer for
  weights and zeros for biases<\footnote>
    Following the recommentation here: <verbatim|https://github.com/RuiShu/vae-clustering/issues/10>
  </footnote>, a mini-batch size of 100 and Adam with a learning rate of
  0.001.

  Figure <reference|fig:gmvae-learning-curves> shows the estimated ELBO,
  conditional entropy and clustering accuracy on the entire test set after
  each epoch of training. Unsurprisingly, ELBO improves over time and
  plateaus. More interestingly, we see that the conditional entropy decreases
  and clustering accuracy increases over time. Since the model imposes a
  uniform prior over the classes, the model would only benefit from
  decreasing conditional entropy if it finds encoding information in
  <math|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|y><rsub|i>\<mid\><with|font-series|bold|x><rsub|i>|)>>
  helpful for reconstruction. At least for MNIST (for another such dataset,
  see Figure 4 of <cite|yang2020game>), it turns out that the model clustered
  digits like a human would, but for datasets without obvious subclasses the
  resulting clusters might be a lot less semantically meaningful and
  predictable.

  Apart from the training statistics, we can also conditionally generate new
  digits (Figure <reference|fig:gmvae-cond-gens>) from the trained model
  obtained through ancestral sampling of <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z>\<mid\><with|font-series|bold|y>|)>>
  and then <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x>\<mid\><with|font-series|bold|z>|)>>.
  Different clusters learned to generated distinct digits, though a few
  clusters do overlap. This observation couples with a good clustering
  accuracy: if all digits from the a specific class are encoded to a specific
  cluster during training, then the model would also know how to decode them
  back to digits from that same class with the help of the reconstruction
  loss.<float|float|thb|<\big-figure|<image|04_gmvae/learning_curves.pdf|1par|||>>
    Test set performance of a Gaussian Mixture VAE with <math|C=10> trained
    on binary MNIST. Estimated ELBO increases over time as expected.
    Conditional entropy and clustering accuracy indicates that the model
    learned to exploit the categorical latent variable for encoding
    information efficiently. <label|fig:gmvae-learning-curves>
  </big-figure>><float|float|t|<\big-figure|<image|04_gmvae/mnist_gens_conditional_param.pdf|0.6par|||>>
    Conditional generations of a Gaussian Mixture VAE with <math|C=10>
    trained on binary MNIST. Each row contains 15 generated digits from a
    different cluster. Most clusters capture a single digit. Note that
    clusters have been ordered by hand so that generated digits appear in
    ascending order. <label|fig:gmvae-cond-gens>
  </big-figure>>

  <subsection|Variational RNN><label|sec:vrnn>

  <subsubsection|Generative model>

  Imagine treating binary MNIST images as sequences: a 28-by-28 image of a
  digit can be thought of as a vertically stacked sequence of 28 length-28
  vectors. Then, the generative model as specified by Variational Recurrent
  Neural Network (VRNN) <cite|chung2015recurrent> for such data is (for
  <math|t=1,2,\<ldots\>,T=28>)

  <\eqnarray*>
    <tformat|<table|<row|<cell|<with|font-series|bold|x><rsub|t>>|<cell|\<sim\>>|<cell|<text|ProductOfBernoullis><around*|(|<with|font-series|bold|p><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<leq\>t>|)>|)>>>|<row|<cell|<with|font-series|bold|z><rsub|t>>|<cell|\<sim\>>|<cell|<with|font|cal|N><around*|(|<with|font-series|bold|\<mu\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>,<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>|)>.>>>>
  </eqnarray*>

  where we have ignored the index <math|i> for indexing training examples for
  brevity. <math|<with|font-series|bold|z><rsub|t>\<in\>\<bbb-R\><rsup|L>>
  <math|<around*|(|t=1,\<ldots\>,T|)>> are latent variables and
  <math|<with|font-series|bold|x><rsub|t>\<in\><around*|{|0,1|}><rsup|D>>
  <math|<around*|(|t=1,\<ldots\>,T|)>> are observed variables.
  <math|<with|font-series|bold|\<mu\>><rsub|<with|font-series|bold|\<theta\>>>>,
  <math|<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<theta\>>>>
  and <math|<with|font-series|bold|p><rsub|<with|font-series|bold|\<theta\>>>>
  are parametrized functions, which we will later define. Having latent and
  observed variables distributed over <math|T> timesteps seems strange as
  compared to the simple formulation of latent variable model discussed in
  Section <reference|sec:latent-var-models>, but similar to what we did for
  GMVAE we could define the latent variable to be
  <math|<with|font-series|bold|z>=<with|font-series|bold|z><rsub|1>\<parallel\>\<cdots\>\<parallel\><with|font-series|bold|z><rsub|T>>
  with dimension <math|L<rprime|'>=T\<times\>L> and the observed variable to
  be <math|<with|font-series|bold|x><rsub|>=<with|font-series|bold|x><rsub|1>\<parallel\>\<cdots\>\<parallel\><with|font-series|bold|x><rsub|T>>
  with dimension <math|D<rprime|'>=T\<times\>D>, where <math|\<parallel\>>
  denotes concatenation. Notice how different latent variable models differ
  primarily in how the joint density <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x>,<with|font-series|bold|z>|)>>
  factors. In fact, the structure of this model is inspired from the
  <with|font-shape|italic|complete> factorization of this joint density:

  <\equation*>
    p<around*|(|<with|font-series|bold|x><rsub|>,<with|font-series|bold|z>|)>=p<around*|(|<with|font-series|bold|x><rsub|1:T>,<with|font-series|bold|z><rsub|1:T>|)>=p<around*|(|<with|font-series|bold|z><rsub|1>|)>p<around*|(|<with|font-series|bold|x><rsub|1>\<mid\><with|font-series|bold|z><rsub|1>|)>p<around*|(|<with|font-series|bold|z><rsub|2>\<mid\><with|font-series|bold|x><rsub|1>,<with|font-series|bold|z><rsub|1>|)>p<around*|(|<with|font-series|bold|x><rsub|2>\<mid\><with|font-series|bold|x><rsub|1>,<with|font-series|bold|z><rsub|1:2>|)>\<cdots\>,
  </equation*>

  which is different from Hidden Markov models, in which the latent variables
  are not conditioned on the observed variables, and observed variables are
  not conditioned on past observed variables.

  We can rewrite the generative model more concisely using the following
  notation:

  <\eqnarray*>
    <tformat|<table|<row|<cell|<with|font-series|bold|x><rsub|t>>|<cell|\<sim\>>|<cell|<text|ProductOfBernoullis><around*|(|<with|font-series|bold|p><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|h><rsub|t>,<with|font-series|bold|z><rsub|t>|)>|)>>>|<row|<cell|<with|font-series|bold|z><rsub|t>>|<cell|\<sim\>>|<cell|<with|font|cal|N><around*|(|<with|font-series|bold|\<mu\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|h><rsub|t>|)>,<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|h><rsub|t>|)>|)>>>|<row|<cell|<with|font-series|bold|h><rsub|t>>|<cell|=>|<cell|<around*|(|<with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)><space|1em><around*|(|<text|><with|font-series|bold|h><rsub|1>=<around*|(||)>|)>,>>>>
  </eqnarray*>

  which motivates representing the model with a recurrent function <math|f>
  with fixed-size <math|<with|font-series|bold|h><rsub|t>>:

  <\eqnarray*>
    <tformat|<table|<row|<cell|<with|font-series|bold|x><rsub|t>>|<cell|\<sim\>>|<cell|<text|ProductOfBernoullis><around*|(|<with|font-series|bold|p><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|h><rsub|t>,<with|font-series|bold|z><rsub|t>|)>|)>>>|<row|<cell|<with|font-series|bold|z><rsub|t>>|<cell|\<sim\>>|<cell|<with|font|cal|N><around*|(|<with|font-series|bold|\<mu\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|h><rsub|t>|)>,<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|h><rsub|t>|)>|)>>>|<row|<cell|<with|font-series|bold|h><rsub|t>>|<cell|=>|<cell|f<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|h><rsub|t-1>,<with|font-series|bold|x><rsub|t-1>,<with|font-series|bold|z><rsub|t-1>|)><space|1em><around*|(|<with|font-series|bold|h><rsub|1>=zeros|)>.>>>>
  </eqnarray*>

  where <math|f<rsub|<with|font-series|bold|\<theta\>>>:\<bbb-R\><rsup|H>\<times\><around*|{|0,1|}><rsup|D>\<times\>\<bbb-R\><rsup|L>\<rightarrow\>\<bbb-R\><rsup|H>>,
  <math|<with|font-series|bold|\<mu\>><rsub|<with|font-series|bold|\<theta\>>>:\<bbb-R\><rsup|H>\<rightarrow\>\<bbb-R\><rsup|L>>,
  <math|<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<theta\>>>:\<bbb-R\><rsup|H>\<rightarrow\>\<bbb-R\><rsup|+><rsup|L>>
  and <math|<with|font-series|bold|p><rsub|<with|font-series|bold|\<theta\>>>:\<bbb-R\><rsup|H>\<times\>\<bbb-R\><rsup|L>\<rightarrow\><around*|{|0,1|}><rsup|D>>
  are neural networks. <math|<with|font-series|bold|\<mu\>><rsub|<with|font-series|bold|\<theta\>>>>,
  <math|<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<theta\>>>>
  and <math|<with|font-series|bold|p><rsub|<with|font-series|bold|\<theta\>>>>
  can be represented using feedforward neural networks, whereas <math|f>
  needs to be represented using a recurrent neural network, such as an LSTM
  <cite|hochreiter1997long>. Note that an LSTM maintains a \Pcell state\Q
  (which is not processed by consecutive layers) in addition to the hidden
  state; with LSTM, the model is written as:

  <\eqnarray*>
    <tformat|<table|<row|<cell|<with|font-series|bold|x><rsub|t>>|<cell|\<sim\>>|<cell|<text|ProductOfBernoullis><around*|(|<with|font-series|bold|p><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|h><rsub|t>,<with|font-series|bold|z><rsub|t>|)>|)>>>|<row|<cell|<with|font-series|bold|z><rsub|t>>|<cell|\<sim\>>|<cell|<with|font|cal|N><around*|(|<with|font-series|bold|\<mu\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|h><rsub|t>|)>,<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|h><rsub|t>|)>|)>>>|<row|<cell|<wide*|<around*|(|<with|font-series|bold|h><rsub|t>,<with|font-series|bold|c><rsub|t>|)>|\<wide-underbrace\>><rsub|state<rsub|t>>>|<cell|=>|<cell|LSTM<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|t-1>,<with|font-series|bold|z><rsub|t-1>,<wide*|<around*|(|<with|font-series|bold|h><rsub|t-1>,<with|font-series|bold|><with|font-series|bold|c><rsub|t-1>|)>|\<wide-underbrace\>><rsub|state<rsub|t-1>>|)>.>>>>
  </eqnarray*>

  <subsubsection|Approximate posterior>

  As for GMVAE, to choose the form of approximate posterior, we first write
  out the factorization of the true posterior, which is intractable:

  <\equation*>
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|1:T>\<mid\><with|font-series|bold|x><rsub|1:T>|)>=p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|1>\<mid\><with|font-series|bold|x><rsub|1:T>|)>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|1>\<mid\><with|font-series|bold|z><rsub|2>,<with|font-series|bold|x><rsub|1:T>|)>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|3>\<mid\><with|font-series|bold|z><rsub|1:2>,<with|font-series|bold|x><rsub|1:T>|)>\<cdots\>.
  </equation*>

  As in the original paper, we now make two simplications to the equation
  above to get the form of the approximate posterior. First, we use
  <math|q<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<leq\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>>
  to approximate each <math|p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|1:T>,<with|font-series|bold|z><rsub|\<less\>t>|)>>,
  which ignores the dependency of <math|<with|font-series|bold|z><rsub|t>> on
  <math|<with|font-series|bold|x><rsub|\<gtr\>t>>: since
  <math|<with|font-series|bold|z><rsub|t>> contributes to all future
  <math|<with|font-series|bold|x><rsub|\<gtr\>t>> in the generative
  procedure, knowing the values of <math|<with|font-series|bold|x><rsub|\<gtr\>t>>
  should inform us probabilistically about the value of
  <math|<with|font-series|bold|z><rsub|t>>. The advantage of doing so is that
  now <math|q<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<leq\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>>
  can be written as <math|q<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|t>,<with|font-series|bold|h><rsub|t>|)>>,
  where <math|<with|font-series|bold|h><rsub|t>> also appeared in the
  generative model, and hence the generative and inference networks can share
  the same recurrent neural network. An interested reader should implement
  <math|q<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|1:T>,<with|font-series|bold|z><rsub|\<less\>t>|)>>
  as a practice. Secondly, we choose <math|q<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<leq\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>>
  to be a diagonal Gaussian, as in VAE.\ 

  <subsubsection|Estimator for per-example ELBO>

  Following the approach in Section <reference|sec:fa-aevb>, we first derive
  an unbiased, low-variance estimator of the per-example ELBO whose
  randomness does not depend on parameters
  <math|<with|font-series|bold|\<theta\>>,<with|font-series|bold|\<phi\>>>.
  Starting from the per-example ELBO, we have (following the derivation in
  Appendix of <cite|chung2015recurrent>; color highlights the trick used in
  the derivation):

  <\eqnarray*>
    <tformat|<cwith|2|3|3|3|font-base-size|9>|<table|<row|<cell|>|<cell|>|<cell|\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|1:T>\<mid\><with|font-series|bold|x><rsub|1:T>|)>><around*|[|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|1:T>,<with|font-series|bold|z><rsub|1:T>|)>-log
    q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|1:T>\<mid\><with|font-series|bold|x><rsub|1:T>|)>|]>>>|<row|<cell|>|<cell|=>|<cell|<with|font-base-size|10|\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|1:T>\<mid\><with|font-series|bold|x><rsub|1:T>|)>><around*|[|log
    <big|prod><rsub|t=1><rsup|T>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<leq\>t>|)>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>-log
    <big|prod><rsub|t=1><rsup|T>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<leq\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>|]>>>>|<row|<cell|>|<cell|=>|<cell|<with|font-base-size|10|\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|1:T>\<mid\><with|font-series|bold|x><rsub|1:T>|)>><around*|[|
    <big|sum><rsub|t=1><rsup|T>log p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<leq\>t>|)>+log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>-log
    q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<leq\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>|]>>>>|<row|<cell|>|<cell|=>|<cell|<big|sum><rsub|t=1><rsup|T>\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|\<leq\>t>\<mid\><with|font-series|bold|x><rsub|\<leq\>t>|)>><around*|[|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<leq\>t>|)>|]>-\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|\<leq\>t>\<mid\><with|font-series|bold|x><rsub|\<leq\>t>|)>><around*|[|log
    q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<leq\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>-log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>|]>>>|<row|<cell|>|<cell|=>|<cell|<big|sum><rsub|t=1><rsup|T>\<bbb-E\><rsub|<with|color|red|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|\<leq\>t>\<mid\><with|font-series|bold|x><rsub|\<leq\>t>|)>>><around*|[|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<leq\>t>|)>|]>-\<bbb-E\><rsub|<with|color|red|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|\<less\>t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>|)>>><around*|[|D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<leq\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>\<parallel\>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>|)>|]>>>|<row|<cell|>|<cell|=>|<cell|<big|sum><rsub|t=1><rsup|T>\<bbb-E\><rsub|<with|color|red|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|1:T>\<mid\><with|font-series|bold|x><rsub|1:T>|)>>><around*|[|log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<leq\>t>|)>|]>-\<bbb-E\><rsub|<with|color|red|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|1:T>\<mid\><with|font-series|bold|x><rsub|1:T>|)>>><around*|[|D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<leq\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>\<parallel\>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>|)>|]>>>|<row|<cell|>|<cell|=>|<cell|\<bbb-E\><rsub|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|1:T>\<mid\><with|font-series|bold|x><rsub|1:T>|)>><around*|[|<big|sum><rsub|t=1><rsup|T>log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<leq\>t>|)>-D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<leq\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>\<parallel\>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>|)>|]>,>>>>
  </eqnarray*>

  where we can remove <math|<with|font-series|bold|\<phi\>>> from under the
  expectation by first decomposing <math|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|1:T>\<mid\><with|font-series|bold|x><rsub|1:T>|)>>
  into <math|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|1>\<mid\><with|font-series|bold|x><rsub|1>|)>\<cdots\>q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|T>\<mid\><with|font-series|bold|x><rsub|\<leq\>T>,<with|font-series|bold|z><rsub|\<less\>T>|)>>
  and then applying reparametrization trick to each component distribution
  (since each component distribution is a Gaussian):

  <\equation*>
    \<bbb-E\><rsub|<with|font-series|bold|\<varepsilon\>><rsub|1>\<sim\><with|font|cal|N><around*|(|0,<with|font-series|bold|I><rsub|L>|)>,\<ldots\>,<with|font-series|bold|\<varepsilon\>><rsub|T>\<sim\><with|font|cal|N><around*|(|0,<with|font-series|bold|I><rsub|L>|)>><around*|[|<big|sum><rsub|t=1><rsup|T>log
    p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<leq\>t><rsup|s>|)>-D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<leq\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>\<parallel\>p<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>|)>|]>,
  </equation*>

  where <math|<with|font-series|bold|z><rsub|1:T><rsup|s>> is computed from a
  deterministic transformation of <math|<with|font-series|bold|\<varepsilon\>><rsub|1:T>>
  and <math|<with|font-series|bold|\<theta\>>>:

  <\eqnarray*>
    <tformat|<table|<row|<cell|<with|font-series|bold|z><rsub|1>>|<cell|=>|<cell|<with|font-series|bold|\<mu\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|1>|)>+<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|1>|)><with|font-series|bold|\<varepsilon\>><rsub|1>>>|<row|<cell|<with|font-series|bold|z><rsub|2>>|<cell|=>|<cell|<with|font-series|bold|\<mu\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|\<leq\>2>,<with|font-series|bold|z><rsub|1>|)>+<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|\<leq\>2>,<with|font-series|bold|z><rsub|1>|)><with|font-series|bold|\<varepsilon\>><rsub|2>>>|<row|<cell|>|<cell|\<vdots\>>|<cell|>>>>
  </eqnarray*>

  which can also be written in terms of hidden states of the LSTM:

  <\eqnarray*>
    <tformat|<table|<row|<cell|<with|font-series|bold|h><rsub|1>,<with|font-series|bold|c><rsub|1>>|<cell|=>|<cell|<around*|(|zeros,zeros|)>>>|<row|<cell|<with|font-series|bold|z><rsub|1>>|<cell|=>|<cell|<with|font-series|bold|\<mu\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|1>,<with|font-series|bold|h><rsub|1>|)>+<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|1>,<with|font-series|bold|h><rsub|1>|)><with|font-series|bold|\<varepsilon\>><rsub|1>>>|<row|<cell|<with|font-series|bold|h><rsub|2>,<with|font-series|bold|c><rsub|2>>|<cell|=>|<cell|LSTM<rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|1>,<with|font-series|bold|z><rsub|1>,<around*|(|<with|font-series|bold|h><rsub|1>,<with|font-series|bold|><with|font-series|bold|c><rsub|1>|)>|)>>>|<row|<cell|<with|font-series|bold|z><rsub|2>>|<cell|=>|<cell|<with|font-series|bold|\<mu\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|2>,<with|font-series|bold|h><rsub|2>|)>+<with|font-series|bold|\<sigma\>><rsub|<with|font-series|bold|\<theta\>>><around*|(|<with|font-series|bold|x><rsub|2>,<with|font-series|bold|h><rsub|2>|)><with|font-series|bold|\<varepsilon\>><rsub|2>>>|<row|<cell|>|<cell|\<vdots\>>|<cell|>>>>
  </eqnarray*>

  We can now instantiate an unbiased estimator:

  <\equation*>
    <big|sum><rsub|t=1><rsup|T>log p<around*|(|<with|font-series|bold|x><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<leq\>t><rsup|s>|)>-D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<leq\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>\<parallel\>p<around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|\<less\>t>,<with|font-series|bold|z><rsub|\<less\>t>|)>|)>.
  </equation*>

  which can also be written in terms of hidden states of the LSTM as follows:

  <\equation*>
    <big|sum><rsub|t=1><rsup|T>log p<around*|(|<with|font-series|bold|x><rsub|t>\<mid\><with|font-series|bold|z><rsup|s><rsub|t>,<with|font-series|bold|h><rsub|t>|)>-D<rsub|\<bbb-K\>\<bbb-L\>><around*|(|q<rsub|<with|font-series|bold|\<phi\>>><around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|x><rsub|t>,<with|font-series|bold|h><rsub|t>|)>\<parallel\>p<around*|(|<with|font-series|bold|z><rsub|t>\<mid\><with|font-series|bold|h><rsub|t>|)>|)>,
  </equation*>

  where the <math|<with|font-series|bold|h><rsub|t>>'s here are exactly the
  <math|<with|font-series|bold|h><rsub|t>>'s used in the process of sampling
  <math|<with|font-series|bold|z><rsub|1:T><rsup|s>>. In PyTorch, we can
  implement this estimator and compute the gradients with respect to the
  parameters as follows:

  <with|font-base-size|8|<\python-code>
    class AEVB(nn.Module):

    \ \ \ \ # ...

    \ \ \ \ def step(self, x):

    \ \ \ \ \ \ \ \ # x shape (batch_size, 28, 28)

    \ \ \ \ \ \ \ \ 

    \ \ \ \ \ \ \ \ bs = x.size(0)

    \ \ \ \ \ \ \ \ seq_len = x.size(1)

    \;

    \ \ \ \ \ \ \ \ mini_batch_elbo = 0 \ # mean of estimators of per-example
    ELBO

    \;

    \ \ \ \ \ \ \ \ for t in range(seq_len):

    \ \ \ \ \ \ \ \ \ \ \ \ 

    \ \ \ \ \ \ \ \ \ \ \ \ xt = x[:,t,:]

    \;

    \ \ \ \ \ \ \ \ \ \ \ \ if t == 0:

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ht = torch.zeros(bs, self.h_dim)

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ state_t = None

    \ \ \ \ \ \ \ \ \ \ \ \ else:

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ht, state_t = self.f(x_tminus1,
    z_tminus1, state_tminus1)

    \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ ht = ht.squeeze() \ # get rid of the
    "direction" dimension

    \ \ \ \ \ \ \ \ \ \ \ \ 

    \ \ \ \ \ \ \ \ \ \ \ \ prior_over_zt = self.p_zt_given_ht(ht)

    \ \ \ \ \ \ \ \ \ \ \ \ posterior_over_zt = self.q_zt_given_ht_xt(ht, xt)

    \;

    \ \ \ \ \ \ \ \ \ \ \ \ kl = kl_divergence(posterior_over_zt,
    prior_over_zt)

    \ \ \ \ \ \ \ \ \ \ \ \ zt = posterior_over_zt.sample()

    \ \ \ \ \ \ \ \ \ \ \ \ rec = self.p_xt_given_ht_zt(ht, zt).log_prob(xt)
    \ # reconstruction

    \ \ \ \ \ \ \ \ \ \ \ \ 

    \ \ \ \ \ \ \ \ \ \ \ \ mini_batch_elbo += (rec - kl).mean()

    \ \ \ \ \ \ \ \ \ \ \ \ 

    \ \ \ \ \ \ \ \ \ \ \ \ x_tminus1 = xt

    \ \ \ \ \ \ \ \ \ \ \ \ z_tminus1 = zt

    \ \ \ \ \ \ \ \ \ \ \ \ state_tminus1 = state_t

    \ \ \ \ \ \ \ \ \ \ \ \ 

    \ \ \ \ \ \ \ \ loss = - mini_batch_elbo

    \ \ \ \ \ \ \ \ 

    \ \ \ \ \ \ \ \ self.opt.zero_grad()

    \ \ \ \ \ \ \ \ loss.backward()

    \ \ \ \ \ \ \ \ self.opt.step()

    \ \ \ \ # ...
  </python-code>>

  <subsubsection|Results>

  We transformed each MNIST image into a length-28 sequence of rows, each of
  which is a length-28 vector. We then trained a VRNN on these sequences by
  optimizing a mini-batch estimator of ELBO via gradient ascent until
  convergence. We used a small latent dimension <math|L=2> since <math|T=28>,
  a mini-batch size of 100 and Adam with a learning rate of
  0.001.<\float|float|t>
    <\big-figure|<tabular|<tformat|<table|<row|<cell|<image|05_vrnn/learning_curves.pdf|0.3par|||>>|<cell|<image|05_vrnn/mnist_gens_mean.pdf|0.6par|||>>>>>>>
      Results for a VRNN with <math|L=2> trained on binary MNIST sequences.
      (left) Estimated ELBO on the test set over time (right) Generated
      images after training. Each image is generated one row at a time.
      <label|fig:vrnn>
    </big-figure>
  </float> Figure <reference|fig:vrnn> (left) shows that the estimated ELBO
  on the test set improves over time, and we applied early stopping when the
  quality of generations became satisfactory. Figure
  <reference|fig:gmvae-cond-gens> (right) shows images generated by VRNN
  after training; images were generated one row at a time.

  <\bibliography|bib|tm-plain|../../Amortized Variational inference for
  Training Latent Variable Models/live/references>
    <\bib-list|21>
      <bibitem*|1><label|bib-blundell2015weight>Charles Blundell, Julien
      Cornebise, Koray Kavukcuoglu<localize|, and >Daan Wierstra.
      <newblock>Weight uncertainty in neural network. <newblock><localize|In
      ><with|font-shape|italic|International conference on machine learning>,
      <localize|pages >1613\U1622. PMLR, 2015.<newblock>

      <bibitem*|2><label|bib-chung2015recurrent>Junyoung Chung, Kyle Kastner,
      Laurent Dinh, Kratarth Goel, Aaron<nbsp>C Courville<localize|, and
      >Yoshua Bengio. <newblock>A recurrent latent variable model for
      sequential data. <newblock><localize|In >C.<nbsp>Cortes,
      N.<nbsp>Lawrence, D.<nbsp>Lee, M.<nbsp>Sugiyama<localize|, and
      >R.<nbsp>Garnett<localize|, editors>, <with|font-shape|italic|Advances
      in Neural Information Processing Systems>, <localize|volume><nbsp>28,
      <localize|page >0. Curran Associates, Inc., 2015.<newblock>

      <bibitem*|3><label|bib-glorot2010understanding>Xavier Glorot<localize|
      and >Yoshua Bengio. <newblock>Understanding the difficulty of training
      deep feedforward neural networks. <newblock><localize|In
      ><with|font-shape|italic|Proceedings of the thirteenth international
      conference on artificial intelligence and statistics>, <localize|pages
      >249\U256. JMLR Workshop and Conference Proceedings, 2010.<newblock>

      <bibitem*|4><label|bib-graves2016stochastic>Alex Graves.
      <newblock>Stochastic backpropagation through mixture density
      distributions. <newblock><with|font-shape|italic|ArXiv preprint
      arXiv:1607.05690>, 2016.<newblock>

      <bibitem*|5><label|bib-gumbel1954statistical>Emil<nbsp>Julius Gumbel.
      <newblock><with|font-shape|italic|Statistical theory of extreme values
      and some practical applications: a series of lectures>,
      <localize|volume><nbsp>33. <newblock>US Government Printing Office,
      1954.<newblock>

      <bibitem*|6><label|bib-hochreiter1997long>Sepp Hochreiter<localize| and
      >Jürgen Schmidhuber. <newblock>Long short-term memory.
      <newblock><with|font-shape|italic|Neural computation>, 9(8):1735\U1780,
      1997.<newblock>

      <bibitem*|7><label|bib-jang2017categorical>Eric Jang, Shixiang
      Gu<localize|, and >Ben Poole. <newblock>Categorical reparameterization
      with gumbel-softmax. <newblock><localize|In
      ><with|font-shape|italic|International Conference on Learning
      Representations>. 2017.<newblock>

      <bibitem*|8><label|bib-kingma2014adam>Diederik<nbsp>P Kingma<localize|
      and >Jimmy Ba. <newblock>Adam: a method for stochastic optimization.
      <newblock><with|font-shape|italic|ArXiv preprint arXiv:1412.6980>,
      2014.<newblock>

      <bibitem*|9><label|bib-kingma2013auto>Diederik<nbsp>P Kingma<localize|
      and >Max Welling. <newblock>Auto-encoding variational bayes.
      <newblock><localize|In ><with|font-shape|italic|International
      conference on learning representations>. 2014.<newblock>

      <bibitem*|10><label|bib-kingma2014semi>Durk<nbsp>P Kingma, Shakir
      Mohamed, Danilo Jimenez Rezende<localize|, and >Max Welling.
      <newblock>Semi-supervised learning with deep generative models.
      <newblock><with|font-shape|italic|Advances in neural information
      processing systems>, 27, 2014.<newblock>

      <bibitem*|11><label|bib-cs285slides>Sergey Levine. <newblock>CS 285:
      Deep Reinforcement Learning \U Lecture 16: Variational Inference and
      Generative Models. <newblock><slink|http://rail.eecs.berkeley.edu/deeprlcourse-fa20/static/slides/lec-18.pdf>,
      2020.<newblock>

      <bibitem*|12><label|bib-loaiza2019continuous>Gabriel
      Loaiza-Ganem<localize| and >John<nbsp>P Cunningham. <newblock>The
      continuous bernoulli: fixing a pervasive error in variational
      autoencoders. <newblock><with|font-shape|italic|Advances in Neural
      Information Processing Systems>, 32, 2019.<newblock>

      <bibitem*|13><label|bib-maddison2016concrete>Chris<nbsp>J Maddison,
      Andriy Mnih<localize|, and >Yee<nbsp>Whye Teh. <newblock>The concrete
      distribution: a continuous relaxation of discrete random variables.
      <newblock><with|font-shape|italic|ArXiv preprint arXiv:1611.00712>,
      2016.<newblock>

      <bibitem*|14><label|bib-maddison2014A>Chris<nbsp>J Maddison, Daniel
      Tarlow<localize|, and >Tom Minka. <newblock>A\<ast\>sampling.
      <newblock><localize|In >Z.<nbsp>Ghahramani, M.<nbsp>Welling,
      C.<nbsp>Cortes, N.<nbsp>Lawrence<localize|, and
      >K.Q.<nbsp>Weinberger<localize|, editors>,
      <with|font-shape|italic|Advances in Neural Information Processing
      Systems>, <localize|volume><nbsp>27, <localize|page >0. Curran
      Associates, Inc., 2014.<newblock>

      <bibitem*|15><label|bib-murphy2012machine>Kevin<nbsp>P Murphy.
      <newblock><with|font-shape|italic|Machine learning: a probabilistic
      perspective>. <newblock>MIT press, 2012.<newblock>

      <bibitem*|16><label|bib-pml2Book>Kevin<nbsp>P.<nbsp>Murphy.
      <newblock><with|font-shape|italic|Probabilistic Machine Learning:
      Advanced Topics>. <newblock>MIT Press, 2023.<newblock>

      <bibitem*|17><label|bib-paszke2019pytorch>Adam Paszke, Sam Gross,
      Francisco Massa, Adam Lerer, James Bradbury, Gregory Chanan, Trevor
      Killeen, Zeming Lin, Natalia Gimelshein, Luca Antiga et<nbsp>al.
      <newblock>Pytorch: an imperative style, high-performance deep learning
      library. <newblock><with|font-shape|italic|Advances in neural
      information processing systems>, 32, 2019.<newblock>

      <bibitem*|18><label|bib-gmvae>Rui Shu. <newblock>Gaussian mixture vae:
      lessons in variational inference, generative models, and deep nets.
      <newblock>Dec 2016.<newblock>

      <bibitem*|19><label|bib-sohn2015learning>Kihyuk Sohn, Honglak
      Lee<localize|, and >Xinchen Yan. <newblock>Learning structured output
      representation using deep conditional generative models.
      <newblock><localize|In >C.<nbsp>Cortes, N.<nbsp>Lawrence, D.<nbsp>Lee,
      M.<nbsp>Sugiyama<localize|, and >R.<nbsp>Garnett<localize|, editors>,
      <with|font-shape|italic|Advances in Neural Information Processing
      Systems>, <localize|volume><nbsp>28, <localize|page >0. Curran
      Associates, Inc., 2015.<newblock>

      <bibitem*|20><label|bib-van2008visualizing>Laurens Van
      der<nbsp>Maaten<localize| and >Geoffrey Hinton. <newblock>Visualizing
      data using t-sne. <newblock><with|font-shape|italic|Journal of machine
      learning research>, 9(11), 2008.<newblock>

      <bibitem*|21><label|bib-yang2020game>Zhihan Yang, Anurag
      Sarkar<localize|, and >Seth Cooper. <newblock>Game level clustering and
      generation using gaussian mixture vaes. <newblock><localize|In
      ><with|font-shape|italic|Proceedings of the AAAI Conference on
      Artificial Intelligence and Interactive Digital Entertainment>,
      <localize|volume><nbsp>16, <localize|pages >137\U143. 2020.<newblock>
    </bib-list>
  </bibliography>
</body>

<\initial>
  <\collection>
    <associate|page-medium|paper>
    <associate|page-screen-margin|false>
    <associate|par-columns|1>
  </collection>
</initial>

<\references>
  <\collection>
    <associate|auto-1|<tuple|1|2>>
    <associate|auto-10|<tuple|5.1|7>>
    <associate|auto-11|<tuple|5.2|7>>
    <associate|auto-12|<tuple|5.2.1|7>>
    <associate|auto-13|<tuple|1|7>>
    <associate|auto-14|<tuple|5.2.2|8>>
    <associate|auto-15|<tuple|5.2.3|8>>
    <associate|auto-16|<tuple|5.2.4|9>>
    <associate|auto-17|<tuple|2|9>>
    <associate|auto-18|<tuple|3|10>>
    <associate|auto-19|<tuple|5.3|11>>
    <associate|auto-2|<tuple|2|3>>
    <associate|auto-20|<tuple|5.3.1|11>>
    <associate|auto-21|<tuple|4|11>>
    <associate|auto-22|<tuple|5.3.2|12>>
    <associate|auto-23|<tuple|5.3.3|13>>
    <associate|auto-24|<tuple|5|13>>
    <associate|auto-25|<tuple|6|13>>
    <associate|auto-26|<tuple|7|14>>
    <associate|auto-27|<tuple|8|14>>
    <associate|auto-28|<tuple|5.4|14>>
    <associate|auto-29|<tuple|5.4.1|14>>
    <associate|auto-3|<tuple|3|4>>
    <associate|auto-30|<tuple|5.4.2|15>>
    <associate|auto-31|<tuple|5.4.3|15>>
    <associate|auto-32|<tuple|5.4.4|15>>
    <associate|auto-33|<tuple|9|15>>
    <associate|auto-34|<tuple|5.5|16>>
    <associate|auto-35|<tuple|5.5.1|16>>
    <associate|auto-36|<tuple|5.5.2|16>>
    <associate|auto-37|<tuple|5.5.3|16>>
    <associate|auto-38|<tuple|5.5.3.1|16>>
    <associate|auto-39|<tuple|5.5.3.2|17>>
    <associate|auto-4|<tuple|3.1|4>>
    <associate|auto-40|<tuple|5.5.4|19>>
    <associate|auto-41|<tuple|10|19>>
    <associate|auto-42|<tuple|11|20>>
    <associate|auto-43|<tuple|5.6|20>>
    <associate|auto-44|<tuple|5.6.1|20>>
    <associate|auto-45|<tuple|5.6.2|21>>
    <associate|auto-46|<tuple|5.6.3|21>>
    <associate|auto-47|<tuple|5.6.4|23>>
    <associate|auto-48|<tuple|12|23>>
    <associate|auto-49|<tuple|12|23>>
    <associate|auto-5|<tuple|3.2|5>>
    <associate|auto-6|<tuple|3.3|6>>
    <associate|auto-7|<tuple|4|6>>
    <associate|auto-8|<tuple|5|6>>
    <associate|auto-9|<tuple|1|6>>
    <associate|bib-blundell2015weight|<tuple|1|23>>
    <associate|bib-chung2015recurrent|<tuple|2|23>>
    <associate|bib-cs285slides|<tuple|11|24>>
    <associate|bib-glorot2010understanding|<tuple|3|23>>
    <associate|bib-gmvae|<tuple|18|24>>
    <associate|bib-graves2016stochastic|<tuple|4|23>>
    <associate|bib-gumbel1954statistical|<tuple|5|23>>
    <associate|bib-hochreiter1997long|<tuple|6|23>>
    <associate|bib-jang2017categorical|<tuple|7|23>>
    <associate|bib-kingma2013auto|<tuple|9|24>>
    <associate|bib-kingma2014adam|<tuple|8|24>>
    <associate|bib-kingma2014semi|<tuple|10|24>>
    <associate|bib-loaiza2019continuous|<tuple|12|24>>
    <associate|bib-maddison2014A|<tuple|14|24>>
    <associate|bib-maddison2016concrete|<tuple|13|24>>
    <associate|bib-murphy2012machine|<tuple|15|24>>
    <associate|bib-paszke2019pytorch|<tuple|17|24>>
    <associate|bib-pml2Book|<tuple|16|24>>
    <associate|bib-sohn2015learning|<tuple|19|24>>
    <associate|bib-van2008visualizing|<tuple|20|24>>
    <associate|bib-yang2020game|<tuple|21|24>>
    <associate|eq:e-step|<tuple|3|6>>
    <associate|eq:gmvae-elbo-marginal|<tuple|5.5.3.1|17>>
    <associate|eq:ll-elbo-kl|<tuple|2|4>>
    <associate|eq:m-step|<tuple|4|6>>
    <associate|eq:mle|<tuple|1|3>>
    <associate|fig:cvae-gens|<tuple|9|15>>
    <associate|fig:fa-data|<tuple|1|7>>
    <associate|fig:fa-em|<tuple|3|10>>
    <associate|fig:fa-learning|<tuple|2|9>>
    <associate|fig:gmvae-cond-gens|<tuple|11|20>>
    <associate|fig:gmvae-learning-curves|<tuple|10|19>>
    <associate|fig:vae-elbo|<tuple|5|13>>
    <associate|fig:vae-gens|<tuple|6|13>>
    <associate|fig:vae-gens-sample|<tuple|7|14>>
    <associate|fig:vae-mnist-org|<tuple|4|11>>
    <associate|fig:vae-tsne|<tuple|8|14>>
    <associate|fig:vrnn|<tuple|12|23>>
    <associate|footnote-1|<tuple|1|1>>
    <associate|footnote-10|<tuple|10|9>>
    <associate|footnote-11|<tuple|11|9>>
    <associate|footnote-12|<tuple|12|9>>
    <associate|footnote-13|<tuple|13|10>>
    <associate|footnote-14|<tuple|14|11>>
    <associate|footnote-15|<tuple|15|11>>
    <associate|footnote-16|<tuple|16|11>>
    <associate|footnote-17|<tuple|17|12>>
    <associate|footnote-18|<tuple|18|13>>
    <associate|footnote-19|<tuple|19|18>>
    <associate|footnote-2|<tuple|2|1>>
    <associate|footnote-20|<tuple|20|19>>
    <associate|footnote-21|<tuple|21|19>>
    <associate|footnote-3|<tuple|3|3>>
    <associate|footnote-4|<tuple|4|3>>
    <associate|footnote-5|<tuple|5|3>>
    <associate|footnote-6|<tuple|6|7>>
    <associate|footnote-7|<tuple|7|7>>
    <associate|footnote-8|<tuple|8|8>>
    <associate|footnote-9|<tuple|9|8>>
    <associate|footnr-1|<tuple|1|1>>
    <associate|footnr-10|<tuple|10|9>>
    <associate|footnr-11|<tuple|11|9>>
    <associate|footnr-12|<tuple|12|9>>
    <associate|footnr-13|<tuple|13|10>>
    <associate|footnr-14|<tuple|14|11>>
    <associate|footnr-15|<tuple|15|11>>
    <associate|footnr-16|<tuple|16|11>>
    <associate|footnr-17|<tuple|17|12>>
    <associate|footnr-18|<tuple|18|13>>
    <associate|footnr-19|<tuple|19|18>>
    <associate|footnr-2|<tuple|2|1>>
    <associate|footnr-20|<tuple|20|19>>
    <associate|footnr-21|<tuple|21|19>>
    <associate|footnr-3|<tuple|3|3>>
    <associate|footnr-4|<tuple|4|3>>
    <associate|footnr-5|<tuple|5|3>>
    <associate|footnr-6|<tuple|6|7>>
    <associate|footnr-7|<tuple|7|7>>
    <associate|footnr-8|<tuple|8|8>>
    <associate|footnr-9|<tuple|9|8>>
    <associate|m-step|<tuple|4|6>>
    <associate|sec:avi|<tuple|3.2|5>>
    <associate|sec:cvae|<tuple|5.4|14>>
    <associate|sec:fa|<tuple|5.2|7>>
    <associate|sec:fa-aevb|<tuple|5.2.3|8>>
    <associate|sec:fa-results|<tuple|5.2.4|9>>
    <associate|sec:gmvae|<tuple|5.5|16>>
    <associate|sec:gmvae-estimate|<tuple|5.5.3|16>>
    <associate|sec:latent-var-models|<tuple|1|2>>
    <associate|sec:models|<tuple|5|6>>
    <associate|sec:stocopt|<tuple|3.3|6>>
    <associate|sec:vae|<tuple|5.3|11>>
    <associate|sec:vrnn|<tuple|5.6|20>>
    <associate|table:all-models|<tuple|1|6>>
  </collection>
</references>

<\auxiliary>
  <\collection>
    <\associate|bib>
      kingma2013auto

      kingma2013auto

      sohn2015learning

      gmvae

      chung2015recurrent

      paszke2019pytorch

      murphy2012machine

      murphy2012machine

      cs285slides

      pml2Book

      cs285slides

      pml2Book

      murphy2012machine

      blundell2015weight

      kingma2013auto

      sohn2015learning

      gmvae

      chung2015recurrent

      murphy2012machine

      kingma2014adam

      kingma2013auto

      loaiza2019continuous

      loaiza2019continuous

      loaiza2019continuous

      graves2016stochastic

      van2008visualizing

      sohn2015learning

      gmvae

      kingma2014semi

      gmvae

      gumbel1954statistical

      maddison2014A

      jang2017categorical

      maddison2016concrete

      jang2017categorical

      maddison2016concrete

      jang2017categorical

      glorot2010understanding

      yang2020game

      chung2015recurrent

      hochreiter1997long

      chung2015recurrent
    </associate>
    <\associate|figure>
      <tuple|normal|<\surround|<hidden-binding|<tuple>|1>|>
        Synthetic dataset (<with|mode|<quote|math>|n=1000>) generated by a
        factor analysis model with <with|mode|<quote|math>|L=2> and
        <with|mode|<quote|math>|D=3>.
      </surround>|<pageref|auto-13>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|2>|>
        Test set performance of the FA model across training. Red and green
        curves show that estimated ELBO and evidence improves towards the
        evidence of the true model (black dotted line) respectively, and that
        ELBO is indeed a lower bound to the evidence. As ELBO improves, we
        see that generated data (orange points) gradually matches test data
        (blue points) in distribution.
      </surround>|<pageref|auto-17>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|3>|>
        Test set performance of the FA model across training when alternating
        between periods of only updating inference parameters
        <with|mode|<quote|math>|<with|font-series|<quote|bold>|\<phi\>>>
        (gray regions) and periods of only updating generative parameters
        <with|mode|<quote|math>|<with|font-series|<quote|bold>|\<theta\>>>
        (white regions). In gray regions, ELBO becomes tight; in white
        regions, both ELBO and evidence improves but ELBO is no longer tight.
        </surround>|<pageref|auto-18>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|4>|>
        Original MNIST images.
      </surround>|<pageref|auto-21>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|5>|>
        Estimated ELBO (test set) of VAE across training. It first improves
        quickly then plateaus.
      </surround>|<pageref|auto-24>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|6>|>
        Parameters of 30 Products of Continuous Bernoullis obtained from 30
        latent draws.
      </surround>|<pageref|auto-25>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|7>|>
        Samples from 30 Product of Continuous Bernoullis whose parameters are
        plotted in Figure <reference|fig:vae-gens>.\ 
      </surround>|<pageref|auto-26>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|8>|>
        2-dimensional t-SNE projection of latent means (20 dimensional)
        obtained from test set. Digit labels (grey) are placed at the median
        of latent means of each class. We see that the resulting clusters
        correspond nicely to clusters we had in mind as humans.
      </surround>|<pageref|auto-27>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|9>|>
        Generated images by Conditional VAE. Each row contains all
        generations from the same label.
      </surround>|<pageref|auto-33>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|10>|>
        Test set performance of a Gaussian Mixture VAE with
        <with|mode|<quote|math>|C=10> trained on binary MNIST. Estimated ELBO
        increases over time as expected. Conditional entropy and clustering
        accuracy indicates that the model learned to exploit the categorical
        latent variable for encoding information efficiently.\ 
      </surround>|<pageref|auto-41>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|11>|>
        Conditional generations of a Gaussian Mixture VAE with
        <with|mode|<quote|math>|C=10> trained on binary MNIST. Each row
        contains 15 generated digits from a different cluster. Most clusters
        capture a single digit. Note that clusters have been ordered by hand
        so that generated digits appear in ascending order.\ 
      </surround>|<pageref|auto-42>>

      <tuple|normal|<\surround|<hidden-binding|<tuple>|12>|>
        Results for a VRNN with <with|mode|<quote|math>|L=2> trained on
        binary MNIST sequences. (left) Estimated ELBO on the test set over
        time (right) Generated images after training. Each image is generated
        one row at a time.\ 
      </surround>|<pageref|auto-48>>
    </associate>
    <\associate|table>
      <tuple|normal|<\surround|<hidden-binding|<tuple>|1>|>
        Summary of latent variable models presented in this tutorial. FA
        means Factor Analysis (Section <reference|sec:fa>); VAE means
        Variational Auto-Encoder ([<write|bib|kingma2013auto><reference|bib-kingma2013auto>];
        Section <reference|sec:vae>); CVAE means Conditional VAE
        ([<write|bib|sohn2015learning><reference|bib-sohn2015learning>];
        Section <reference|sec:cvae>); GMVAE means Gaussian Mixture VAE
        ([<write|bib|gmvae><reference|bib-gmvae>]; Section
        <reference|sec:gmvae>); VRNN means Variational Recurrent Neural
        Network ([<write|bib|chung2015recurrent><reference|bib-chung2015recurrent>];
        Section <reference|sec:vrnn>). For all models except FA, the dataset
        used was MNIST (images of size <with|mode|<quote|math>|28\<times\>28>).
        More specifically, we used normalized MNIST for VAE and CVAE and
        binarized MNIST for GMVAE and VRNN. This was done to showcase that
        latent variable models can have a variety of output distributions.
        \ \ 
      </surround>|<pageref|auto-9>>
    </associate>
    <\associate|toc>
      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|1<space|2spc>Latent
      variable models> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-1><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|2<space|2spc>Expectation
      maximization> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-2><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|3<space|2spc>Approximate
      E-step as variational inference> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-3><vspace|0.5fn>

      <with|par-left|<quote|1tab>|3.1<space|2spc>Variational inference
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-4>>

      <with|par-left|<quote|1tab>|3.2<space|2spc>Amortized variational
      inference <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-5>>

      <with|par-left|<quote|1tab>|3.3<space|2spc>Stochastic optimization of
      ELBO <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-6>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|4<space|2spc>Approximate
      M-step> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-7><vspace|0.5fn>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|5<space|2spc>Derivation
      of AEVB for a few latent variable models>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-8><vspace|0.5fn>

      <with|par-left|<quote|1tab>|5.1<space|2spc>What exactly is the AEVB
      algorithm? <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-10>>

      <with|par-left|<quote|1tab>|5.2<space|2spc>Factor analysis model
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-11>>

      <with|par-left|<quote|2tab>|5.2.1<space|2spc>Generative model
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-12>>

      <with|par-left|<quote|2tab>|5.2.2<space|2spc>Approximate posterior
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-14>>

      <with|par-left|<quote|2tab>|5.2.3<space|2spc>Estimator of per-example
      ELBO <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-15>>

      <with|par-left|<quote|2tab>|5.2.4<space|2spc>Results
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-16>>

      <with|par-left|<quote|1tab>|5.3<space|2spc>Variational autoencoder
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-19>>

      <with|par-left|<quote|2tab>|5.3.1<space|2spc>Generative model
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-20>>

      <with|par-left|<quote|2tab>|5.3.2<space|2spc>Approximate posterior
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-22>>

      <with|par-left|<quote|2tab>|5.3.3<space|2spc>Results
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-23>>

      <with|par-left|<quote|1tab>|5.4<space|2spc>Conditional VAE
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-28>>

      <with|par-left|<quote|2tab>|5.4.1<space|2spc>Generative model
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-29>>

      <with|par-left|<quote|2tab>|5.4.2<space|2spc>Approximate posterior
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-30>>

      <with|par-left|<quote|2tab>|5.4.3<space|2spc>Estimator for per-example
      ELBO <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-31>>

      <with|par-left|<quote|2tab>|5.4.4<space|2spc>Results
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-32>>

      <with|par-left|<quote|1tab>|5.5<space|2spc>Gaussian Mixture VAE
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-34>>

      <with|par-left|<quote|2tab>|5.5.1<space|2spc>Generative model
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-35>>

      <with|par-left|<quote|2tab>|5.5.2<space|2spc>Approximate posterior
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-36>>

      <with|par-left|<quote|2tab>|5.5.3<space|2spc>Estimator for per-example
      ELBO <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-37>>

      <with|par-left|<quote|4tab>|Estimator 1: Marginalization of
      <with|mode|<quote|math>|y<rsub|i>> <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-38><vspace|0.15fn>>

      <with|par-left|<quote|4tab>|Estimator 2: Gumbel-Softmax trick
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-39><vspace|0.15fn>>

      <with|par-left|<quote|2tab>|5.5.4<space|2spc>Results
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-40>>

      <with|par-left|<quote|1tab>|5.6<space|2spc>Variational RNN
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-43>>

      <with|par-left|<quote|2tab>|5.6.1<space|2spc>Generative model
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-44>>

      <with|par-left|<quote|2tab>|5.6.2<space|2spc>Approximate posterior
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-45>>

      <with|par-left|<quote|2tab>|5.6.3<space|2spc>Estimator for per-example
      ELBO <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-46>>

      <with|par-left|<quote|2tab>|5.6.4<space|2spc>Results
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-47>>

      <vspace*|1fn><with|font-series|<quote|bold>|math-font-series|<quote|bold>|Bibliography>
      <datoms|<macro|x|<repeat|<arg|x>|<with|font-series|medium|<with|font-size|1|<space|0.2fn>.<space|0.2fn>>>>>|<htab|5mm>>
      <no-break><pageref|auto-49><vspace|0.5fn>
    </associate>
  </collection>
</auxiliary>