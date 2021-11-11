
<style>
body {
text-align: justify}
</style>

# PhD thesis in Population Health Science

## What lies behind the causal impact of body mass index and change on human health? Added value from complementary study design and deep metabolomic phenotyping

Supervisors: [Nicholas
Timpson](https://www.bristol.ac.uk/people/person/Nicholas-Timpson-cb33193a-0edb-46a8-a06f-7532cf9ee874/),
[Kaitlin
Wade](https://www.bristol.ac.uk/people/person/Kaitlin-Wade-e0c3b266-f309-442c-bb07-0e305b1f49b9/),
[Laura
Corbin](https://www.bristol.ac.uk/people/person/Laura-Corbin-15c0325f-9e1d-4f18-bb53-4bb67aa7baf7/)

The most up to date version of the thesis can be found in
[`index/_book`](https://github.com/mattlee821/000_thesis/blob/master/index/_book/thesis.pdf).
The thesis is split into the following chapters:

-   [Chapter
    1](https://github.com/mattlee821/000_thesis/blob/master/index/01-introduction.Rmd) -
    Introduction: This chapter gives the background to the thesis and
    details the aim and objectives. All data and scripts used in this
    chapter is available in
    [`index/data/introduction`](https://github.com/mattlee821/000_thesis/blob/master/index/data/introduction)
-   [Chapter
    2](https://github.com/mattlee821/000_thesis/blob/master/index/02-systematic-review.Rmd) -
    Systematic review and meta-analyses: This chapter details a
    systematic review and meta-analyses of all Mendelian randomization
    analyses which use adiposity measures as an exposure. All data,
    scripts and results for this chapter are available in
    [`index/data/SR`](https://github.com/mattlee821/000_thesis/blob/master/index/data/SR)
-   [Chapter
    3](https://github.com/mattlee821/000_thesis/blob/master/index/03-visualisation.Rmd) -
    Visualisation: This chapter details the development of
    [`EpiViz`](https://github.com/mattlee821/EpiViz), an `R` package and
    web application for the production of Circos plots. All scripts and
    plots used in this chapter are available in
    [`index/data/visualisation`](https://github.com/mattlee821/000_thesis/blob/master/index/data/visualisation)
-   [Chapter
    4](https://github.com/mattlee821/000_thesis/blob/master/index/04-observational.Rmd) -
    Observational analyses: This chapter details a series of linear
    models using data from the [Avon Longitudinal Study of Parents and
    Children](http://www.bristol.ac.uk/alspac/) of the effect of
    adiposity on metabolites. All scripts and results for this chapter
    are available in
    [`index/data/observational`](https://github.com/mattlee821/000_thesis/blob/master/index/data/observational).
    The raw data for this work is not publicly available.
-   [Chapter
    5](https://github.com/mattlee821/000_thesis/blob/master/index/05-MR.Rmd) -
    Mendelian randomization analyses: This chapter details a series of
    two-sample Mendelian randomization analyses using publicly available
    data of the effect of adiposity on metabolites. All data, scripts,
    and results for this chapter are available in
    [`index/data/MR`](https://github.com/mattlee821/000_thesis/blob/master/index/data/MR).
-   [Chapter
    6](https://github.com/mattlee821/000_thesis/blob/master/index/06-mediation.Rmd) -
    Multivariable Mendelian randomization analysis: This chapter details
    a multivariable analysis using publicly available data to
    investigate the potential intermediary role of metabolites on the
    effect of adiposity on endometrial cancer. All data, scripts, and
    results for this chapter are available in
    [`index/data/mediation`](https://github.com/mattlee821/000_thesis/blob/master/index/data/mediation).
-   [Chapter
    7](https://github.com/mattlee821/000_thesis/blob/master/index/07-discussion.Rmd) -
    Discussion: This chapter draws together all of the work in the
    preceding chapters to discuss the overarching themes of the thesis.
-   [Chapter
    8](https://github.com/mattlee821/000_thesis/blob/master/index/08-conclusion.Rmd) -
    Conclusion
-   [Appendix](https://github.com/mattlee821/000_thesis/blob/master/index/98-appendix.Rmd):
    The appendix is split by each chapter
-   References: a `.bibtex` file of the reference library is available
    in
    [`index/bib`](https://github.com/mattlee821/000_thesis/blob/master/index/bib/).
    References are formatted using the Nature style available in
    [`index/csl`](https://github.com/mattlee821/000_thesis/blob/master/index/csl).

### Abstract

Increased adipose tissue, adiposity, is associated with many diseases
and overall mortality. Studies have suggested that metabolites may play
a role in these relationships. Within this thesis, I aimed to identify
whether metabolites play an intermediary role in the relationship
between adiposity and diseases using a variety of resources and methods
to strengthen causal inference. <br>

In a comprehensive systematic review and meta-analysis, the causal
effects of adiposity were observed across a broad spectrum of diseases.
Meta-analyses highlighted an increasing effect of adiposity on many
cancers, including endometrial cancer, as well as metabolic and
cardiovascular traits such as blood pressure. Evidence from a narrative
synthesis of over 2,000 MR analyses supported results from the
meta-analyses and many findings from the observational literature. There
was evidence from the narrative synthesis that many metabolites,
predominantly lipids, are associated with adiposity. <br>

Within the Avon Longitudinal Study of Parents and Children (ALSPAC),
evidence for an effect of body mass index (BMI), waist hip ratio (WHR),
and body fat percentage (BF) on up-to 230 predominantly lipid based
metabolites was found. There was broad consistency across the measures
of adiposity. In these linear models, the effect of adiposity persisted
after adjustment for age, sex, education, smoking status, alcohol
consumption, diet, and physical activity. In addition, not only did
effects persist across multiple time points (\~9, \~18, \~24, \~50 years
old), but the effect size tended to increase with age. <br>

Observational studies are limited by the potential for unmeasured
confounding and reverse causation. In two independent datasets,
Mendelian randomization (MR), which can overcome limitations in
observational analyses, provided further evidence for an effect of BMI
and WHR on a large number of predominantly lipid based metabolites.
These effects were consistent in sensitivity analyses. However, the
effect of BF on metabolites in MR analyses was not clear. Broadly
speaking, directions of effect were opposite to those for BMI and WHR
(in observational analyses directions of effect were highly consistent).
Additional analyses suggested this may be due to the complexity in
instrumenting BF. Nine metabolites, associated with BF in observational
analyses of adults (\~50 years old) had consistent direction of effect
in MR analyses and were taken forward. For BMI and WHR, meta-analysis
across the two datasets identified 46 and 48 metabolites respectively.
These metabolites had consistent directions of effect in observational
analysis of adults. A total of 56 unique metabolites were taken forward
for investigation with adiposity-associated diseases. <br>

Endometrial cancer, identified in the systematic review and
meta-analysis as associated with adiposity, was selected to investigate
the potential intermediary role of metabolites. MR analyses provided
evidence for an increasing effect of BMI and BF on overall endometrial
and endometrioid cancer. A weaker effect was observed for
non-endometrioid cancer. WHR was associated with an increase in
non-endometrioid cancer. Five of the 56 adiposity associated metabolites
were associated with endometrial cancer in MR analyses, two of which,
triglycerides in small and very small VLDL, were taken forward for
multivariable MR (MVMR) analysis. In MVMR, the direct effect of the
exposure controlling for the intermediate is estimated. When comparing
MVMR and MR estimates, there was evidence for a potential intermediary
role of both metabolites on the effect of WHR and BF on non-endometrioid
cancer. Weak instruments may have biased these results however.
### How

Thesis written in `R Markdown` using
[bristolthesis](https://github.com/mattlee821/bristolthesis), an altered
version of [thesisdown](https://github.com/ismayc/thesisdown) that
complies with the University of Bristol’s regulations. All formatting is
controlled by the
[`template.tex`](https://github.com/mattlee821/000_thesis/blob/master/index/template.tex)
and
[`bristolthesis.cls`](https://github.com/mattlee821/000_thesis/blob/master/index/bristolthesis.cls).
The
[`_bookdown.yml`](https://github.com/mattlee821/000_thesis/blob/master/index/_bookdown.yml)
file is used to compile the individual `.Rmd` files alongside
[`index.Rmd`](https://github.com/mattlee821/000_thesis/blob/master/index/index.Rmd).

### Change log
