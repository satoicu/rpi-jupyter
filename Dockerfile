FROM raspbian/stretch

USER root
RUN useradd -m jovyan
RUN mkdir -p /home/jovyan/work
WORKDIR /home/jovyan/work

RUN apt-get update
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ Asia/Tokyo
RUN apt-get update && apt-get install -y tzdata && rm -rf /var/lib/apt/lists/*

RUN apt update
RUN apt upgrade -y
RUN apt install -y nodejs
RUN apt install -y npm
RUN apt install -y git
RUN apt install -y nano
RUN apt install -y python3
RUN apt install -y python3-pip

RUN pip3 install -U pip
RUN pip3 install jupyter
RUN pip3 install jupyterlab
RUN jupyter notebook --generate-config

RUN echo "c.NotebookApp.ip='0.0.0.0'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.notebook_dir='/home/jovyan/work'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.port=8888" >> /root/.jupyter/jupyter_notebook_config.py

EXPOSE 8888
ENTRYPOINT ["jupyter", "notebook", "--allow-root"]