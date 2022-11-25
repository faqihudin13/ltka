FROM python:3.9

COPY . .

WORKDIR .

# install git
RUN apt-get update -y
RUN apt-get install -y git
RUN apt-get install -y cmake

# Install dlib
ENV CFLAGS=-static
RUN pip3 install --upgrade pip && \
    git clone -b 'v19.21' --single-branch https://github.com/davisking/dlib.git && \
    cd dlib/ && \
    python3 setup.py install --set BUILD_SHARED_LIBS=OFF
RUN cd ..

RUN pip install -r requirements.txt

CMD ["python", "-m", "flask", "run", "--host=0.0.0.0"]
