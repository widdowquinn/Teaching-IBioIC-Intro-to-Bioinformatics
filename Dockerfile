FROM andrewosh/binder-base

USER root

# Add dependencies using conda and the bioconda channel
# https://bioconda.github.io/#set-up-channels
RUN conda config --add channels conda-forge
RUN conda config --add channels defaults
RUN conda config --add channels r
RUN conda config --add channels bioconda

# Install NCBI BLAST+ 2.6.0 using conda
# https://anaconda.org/bioconda/blast
conda install -c bioconda blast=2.6.0

USER main

# Get rid of token/password requests
RUN mkdir -p $HOME/.jupyter
RUN echo "c.NotebookApp.token = ''" >> $HOME/.jupyter/jupyter_notebook_config.py

# Install requirements for Python 3
RUN /home/main/anaconda/envs/python3/bin/pip install -r requirements.txt