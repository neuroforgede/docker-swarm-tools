# [2019] - [2021] © NeuroForge GmbH & Co. KG

FROM python:3.10

# we run as root since we need access to the docker daemon anyways
USER root

# to have a sane default, but in production this should be mounted outside so that it is updated regularly
COPY requirements.txt .

RUN pip3 install --upgrade pip==21.2.4
RUN pip3 install -r requirements.txt

COPY . .

CMD ["python3", "-u", "guardian.py"]