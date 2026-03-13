ARG PYTHON_VERSION=3.14
FROM public.ecr.aws/lambda/python:3.14

ENV PREFIX=/opt
RUN mkdir ${PREFIX}/python

RUN dnf install -y gcc-c++ && dnf clean all

RUN python -m pip install pip -U

COPY requirements.txt requirements.txt
COPY scripts/create-lambda-layer.sh create-lambda-layer.sh
RUN python -m pip install \
    -r requirements.txt \
    --no-binary pydantic \
    -t ${PREFIX}/python

ENV PYTHONPATH=${PREFIX}/python
ENV PATH=${PREFIX}/python/bin:${PATH}

ENTRYPOINT ["bash"]
