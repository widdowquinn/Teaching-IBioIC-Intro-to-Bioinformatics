FROM andrewosh/binder-base

USER root

# Add dependency
RUN apt-get update

# Install other dependencies via apt-get
RUN $HOME/install-apps.sh

USER main

# Get rid of token/password requests
RUN mkdir -p $HOME/.jupyter
RUN echo "c.NotebookApp.token = ''" >> $HOME/.jupyter/jupyter_notebook_config.py

# Install requirements for Python 3
RUN /home/main/anaconda/envs/python3/bin/pip install --upgrade pip
RUN /home/main/anaconda/envs/python3/bin/pip install -r $HOME/requirements.txt
