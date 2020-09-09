FROM tensorflow/tensorflow:latest-gpu

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Warsaw

RUN apt-get update && apt-get install -y \
    git \
    protobuf-compiler \
    python3-tk

RUN pip install --upgrade pip && pip install \
    matplotlib

RUN git clone --depth 1 https://github.com/tensorflow/models && \
    cd models/research/ && \
    protoc object_detection/protos/*.proto --python_out=. && \
    cp object_detection/packages/tf2/setup.py . && \
    python -m pip install .

COPY . .

ENV MPLBACKEND=TKAgg

ENTRYPOINT ["python", "./src/main.py"]
