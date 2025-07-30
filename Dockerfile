FROM satijalab/seurat:latest
LABEL maintainer="l.alessandri@unito.it"
RUN apt-get update && apt-get install -y python3-pip python3-dev curl libzmq3-dev
RUN pip3 install --no-cache-dir jupyterlab notebook
RUN Rscript -e "install.packages('IRkernel');IRkernel::installspec(user=FALSE)"

EXPOSE 8888
RUN mkdir -p /root/.jupyter && python3 -c "from jupyter_server.auth import passwd;print(\"c.ServerApp.password = u'\" + passwd('password')+ \"'\")" > /root/.jupyter/jupyter_lab_config.py
CMD ["jupyter","lab","--ip=0.0.0.0","--port=8888","--no-browser","--allow-root"]
