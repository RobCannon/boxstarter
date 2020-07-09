FROM ubuntu:18.04

RUN apt-get update

RUN apt-get install -y apt-transport-https \
    gnupg \
    curl \
    wget

# Load Other repositories
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ bionic main" | \
    tee /etc/apt/sources.list.d/azure-cli.list
RUN curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl -o /etc/apt/sources.list.d/microsoft.list https://packages.microsoft.com/config/ubuntu/16.04/prod.list

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -

RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb
RUN rm packages-microsoft-prod.deb

RUN apt-get update

RUN apt-get install -y git \
    sudo \
    build-essential \
    nano \
    unzip \
    software-properties-common \
    python3 \
    python-pip \
    docker.io \
    azure-cli \
    powershell \
    nodejs \
    dotnet-sdk-3.0

RUN git config --global credential.helper store
RUN git config --global core.autocrlf false

RUN npm install -g npm npm-check-updates tldr @angular/cli

RUN dotnet tool install --global dotnet-outdated

RUN curl -L https://github.com/docker/compose/releases/download/1.22.0/docker-compose-${TARGETOS}-${TARGETARCH} -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

# RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
# RUN chmod +x ./kubectl
# RUN mv ./kubectl /usr/local/bin/kubectl

RUN curl -L https://git.io/get_helm.sh | bash
RUN helm init --client-only

ENV TERRAFORM_VERSION 0.12.9
ENV TERRAFORM_FILE terraform_${TERRAFORM_VERSION}_linux_amd64.zip
RUN curl -LO https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_FILE}
RUN unzip $TERRAFORM_FILE
RUN rm $TERRAFORM_FILE
RUN mv terraform /usr/local/bin/

RUN curl -O https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping
RUN chmod +x prettyping
RUN mv prettyping /usr/local/bin/


RUN curl -L https://github.com/justjanne/powerline-go/releases/download/v1.13.0/powerline-go-linux-amd64 --output ~/powerline-go
RUN chmod +x ~/powerline-go
RUN mv ~/powerline-go /usr/local/bin/powerline-go

RUN apt-get -y upgrade
RUN apt-get -y autoremove
RUN apt-get -y autoclean

RUN useradd -ms /bin/bash rcannon
RUN usermod -aG sudo rcannon
RUN sudo chown -R rcannon /home/rcannon

USER rcannon

CMD ["bash"]