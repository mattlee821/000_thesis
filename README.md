
<div style="text-align: justify">

# PhD thesis in Population Health Science

**[What lies behind the causal impact of body mass index level and
change on human health? Added value from complementary study design and
deep metabolomic
phenotyping](https://github.com/mattlee821/000_thesis/blob/master/index/_book/PGR_submission_LEE_MATTHEW_1745911.pdf)**

Supervisors: [Nicholas
Timpson](https://www.bristol.ac.uk/people/person/Nicholas-Timpson-cb33193a-0edb-46a8-a06f-7532cf9ee874/),
[Kaitlin
Wade](https://www.bristol.ac.uk/people/person/Kaitlin-Wade-e0c3b266-f309-442c-bb07-0e305b1f49b9/),
[Laura
Corbin](https://www.bristol.ac.uk/people/person/Laura-Corbin-15c0325f-9e1d-4f18-bb53-4bb67aa7baf7/)

This GitHub repository houses all of the components used in the creation
of my thesis. Importantly, it makes available all publicly available
data, scripts, results, and figures used in the thesis. All figures
presented in the thesis, and those too large to be included, are
available within this repository. The structure of the repository is as
follows:

1.  All data, results, figures, and scripts mentioned in the thesis are
    within the `index\` directory
2.  Within `index/`:
    -   `_book/` - contains the thesis as a complete PDF (`thesis.pdf`)
        as well as each individual chapter (all are accompanied by the
        `.tex` files
    -   `bib/` - contains the `bibtex` file used to create the
        references
    -   `csl/` - contains the citation style language (`csl`) file for
        references
    -   `data/` - contains all chapter specific scripts, data, results,
        and figures
    -   `.Rmd` - these are the `R Markdown` files used to write
        components of the thesis
    -   `_bookdown.yml` - `yml` file used to compile the thesis
    -   `bristolthesis.cls` - class file used by `template.tex`
    -   `template.tex` - LaTeX template file for creating thesis
3.  Within `index/data/` each chapter has a separate directory with a
    similar file structure:
    -   `scripts/` - all scripts used in the chapter
    -   `data/` - all data used in the chapter
    -   `analysis/` - all products, primarily results, from scripts
    -   `figures/` - all figures used in chapter
    -   `tables/` - tables presented in or referenced in the thesis

The final version of the thesis can be found in
[`index/_book`](https://github.com/mattlee821/000_thesis/blob/master/index/_book/).
GitHub does not always render large PDFs so you will probably need to
download to read. The thesis is split into the following chapters:

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
-   [Appendix](https://github.com/mattlee821/000_thesis/blob/master/index/98-appendix.Rmd):
    The appendix is split by each chapter
-   References: a `.bibtex` file of the reference library is available
    in
    [`index/bib`](https://github.com/mattlee821/000_thesis/blob/master/index/bib/).
    References are formatted using the Nature style available in
    [`index/csl`](https://github.com/mattlee821/000_thesis/blob/master/index/csl).

### Abstract

Excess adipose tissue, adiposity, is associated with many diseases and
overall mortality. This thesis aimed to investigate whether metabolites
play an intermediary role in these associations using a variety of
resources and methods to strengthen causal inference. <br>

In a comprehensive systematic review and meta-analysis (Chapter 2), the
causal effects of adiposity were observed across a broad spectrum of
diseases, including endometrial cancer, which was selected for
subsequent analysis. These results were supported by a narrative
synthesis of over 2,000 Mendelian randomization (MR) analyses, which
also highlighted evidence of an association between adiposity and many,
predominantly lipid-based, metabolites. <br>

Within the Avon Longitudinal Study of Parents and Children (ALSPAC),
evidence for a consistent association between body mass index (BMI),
waist hip ratio (WHR), and body fat percentage (BF) with up-to 230,
predominantly lipid-based, metabolites and ratios was found (Chapter 4).
In these linear models, the effect of adiposity persisted after
adjustment for covariables and across the lifecourse. <br>

In two independent datasets, MR, a method that mitigates limitations in
observational analyses, provided further evidence for an association
between BMI and WHR with up-to 230, predominantly lipid-based,
metabolites and ratios (Chapter 5). These effects were consistent in
sensitivity analyses. The effect of BF on metabolites was frequently
opposite to the effects observed for BMI and WHR, and BF in
observational analyses. <br>

Evidence from observational and MR analyses identified 54 metabolites
that were consistently associated with adiposity. Two of these
(triglycerides in small and very small very large low density
lipoprotein) were associated with endometrial cancer in MR analysis and,
using multivariable MR, there was evidence for a potential intermediary
role of both metabolites on the effect of WHR and BF, but not BMI, on
non-endometrioid cancer, but not endometrioid cancer (Chapter 6). Weak
instruments may have biased these results however. <br>

This work highlights the broad effect of adiposity on the metabolome,
identifies two metabolites that may be involved in the association
between adiposity and endometrial cancer, and provides a basis for
future investigations of the intermediary role of metabolites. <br>

### How

Thesis written in `R Markdown` using
[bristolthesis](https://github.com/mattlee821/bristolthesis), an altered
version of [thesisdown](https://github.com/ismayc/thesisdown) that
complies with the University of Bristol’s regulations. All formatting is
controlled by
[`template.tex`](https://github.com/mattlee821/000_thesis/blob/master/index/template.tex)
and
[`bristolthesis.cls`](https://github.com/mattlee821/000_thesis/blob/master/index/bristolthesis.cls).
The
[`_bookdown.yml`](https://github.com/mattlee821/000_thesis/blob/master/index/_bookdown.yml)
file is used to compile the individual `.Rmd` files alongside
[`index.Rmd`](https://github.com/mattlee821/000_thesis/blob/master/index/index.Rmd).

### Change log

I made corrections after my Viva in Januray 2022. All corrections are
logged in the commit
[3f89f4d82f3f47663d1fe4d93cd2f658db866a34](https://github.com/mattlee821/000_thesis/commit/3f89f4d82f3f47663d1fe4d93cd2f658db866a34)
and as a response in
[examiner_corrections.docx](https://github.com/mattlee821/000_thesis/blob/master/examiner_corrections.docx).
A final release was created after approval of these corrections (3 days
after the commit).

</div>
