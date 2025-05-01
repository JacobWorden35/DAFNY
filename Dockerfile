FROM mcr.microsoft.com/dotnet/aspnet:5.0-focal-amd64

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Configure apt and install packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install --no-install-recommends apt-utils 2>&1 \
    #
    && apt-get -y install git curl unzip libgomp1 python3

RUN curl -L https://github.com/dafny-lang/dafny/releases/download/v3.5.0/dafny-3.5.0-x64-ubuntu-16.04.zip \
        -o /tmp/dafny.zip && unzip -d /opt/ /tmp/dafny.zip && rm /tmp/dafny.zip

# Clean up
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/dafny:/opt/dafny/z3/bin
