This repository contains the components of the paper, "The Effects of Evolution
 and Spatial Structure on Diversity in Biological Reserves", by Emily Dolson,
Michael Wiser, and Charles Ofria, to appear in the Proceedings of Artificial
Life XV.

The top level contains the LaTeX document for the body of the paper, all of the
figures that appear in the paper, and LaTeX style and bibliography files.

All of the scripts used to analyze the data are in the analysis directory:
- conservation_bio.Rmd: an R markdown file containing all of the code to pull
  the data into one file and analyze it (with commentary), and all graphs
  generated in R.

- conservation_bio.html: the above R markdown file, written to html.

- conservation_figs.ipynb: a Jupyter notebook containing all of the Python
  data visualizations. This includes the visualization of reserve locations,
  most of the connectivity analysis (the rest is in the R markdown file), and
  the visualizations of phenotypes across the environment.

All of the configuration files used to generate the data are in the config
directory:
- avida: the executable
  used to generate all of the data for this paper.
- *-environment.cfg files: Avida environment files describing the 8 different
  reserve configurations (plus one control environment with no reserves)
- *events*.cfg files: Avida events files that load each population and kill its
  members at the appropriate rate.
- avida.cfg: the settings with which Avida was run for these experiments
- run_list.txt: a file describing all of the experiments included in this paper