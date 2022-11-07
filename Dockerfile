FROM python:3.8-buster

# RUN sudo echo 'nameserver 8.8.8.8'>/etc/resolv.conf
RUN apt-get update -y
RUN apt-get install apt-file -y
RUN apt-file update
RUN apt-get install -y python3-dev build-essential

ADD requirements.txt .
RUN pip install -r requirements.txt

# Install RabbitMQ
RUN apt-get install -y erlang
RUN apt-get install -y rabbitmq-server

# install requirements
RUN python -m spacy download en_core_web_lg
RUN python -m nltk.downloader stopwords
RUN python -m nltk.downloader punkt

# Copy Swirl App to container
RUN mkdir /app
ADD ./swirl /app/swirl
ADD ./swirl_server /app/swirl_server
ADD ./SearchProviders /app/SearchProviders
ADD ./scripts /app/scripts
ADD ./Data /app/Data
ADD ./swirl.py /app/swirl.py
ADD ./manage.py /app/manage.py

WORKDIR /app

EXPOSE 8000
