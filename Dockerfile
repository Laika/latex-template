FROM ubuntu:22.04

ARG TEXLIVE_VERSION=2023

ENV DEBIAN_FRONTEND=noninteractive
ENV DEBCONF_NOWARNINGS=yes
ENV PATH="/usr/local/texlive/bin:$PATH"

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        make \
        wget \
        libfontconfig1-dev \
        libfreetype6-dev \
        ghostscript \
        perl \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        python3-pip \
        python3-dev \
    && pip3 install --no-cache-dir pygments \
    && mkdir -p /tmp/install-tl-unx \
    && wget -O - "ftp://tug.org/historic/systems/texlive/${TEXLIVE_VERSION}/install-tl-unx.tar.gz" \
        | tar -xzv -C /tmp/install-tl-unx --strip-components=1 \
    && echo -e 'selected_scheme scheme-basic\ntlpdbopt_install_docfiles 0\ntlpdbopt_install_srcfiles 0' \
        > /tmp/install-tl-unx/texlive.profile 
RUN /tmp/install-tl-unx/install-tl --no-interaction \
        #--profile "/tmp/install-tl-unx/texlive.profile" \
        #-repository  "ftp://tug.org/texlive/historic/${TEXLIVE_VERSION}/tlnet-final/" \
    && rm -r /tmp/install-tl-unx \
    && ln -sf "/usr/local/texlive/${TEXLIVE_VERSION}/bin/$(uname -m)-linux" /usr/local/texlive/bin \
    && apt-get remove -y --purge \
        build-essential \
        python3 \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

RUN tlmgr update --self \
    && tlmgr install \
        collection-bibtexextra \
        collection-fontsrecommended \
        collection-langenglish \
        collection-langjapanese \
        collection-latexrecommended \
        collection-luatex \
        collection-mathscience \
        collection-plaingeneric \
        collection-xetex \
        latexmk \
        latexdiff \
        latexindent

WORKDIR /workdir

COPY .latexmkrc /
COPY .latexmkrc /root/

LABEL org.opencontainers.image.source=https://github.com/Laika/latex-template
LABEL org.opencontainers.image.description="LaTeX template"
LABEL org.opencontainers.image.licenses=MIT
