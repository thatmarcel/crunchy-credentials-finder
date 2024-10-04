FROM registry.fedoraproject.org/fedora:40

RUN dnf install -y gh git unzip java-11-openjdk

RUN mkdir /ripgrep-install && cd /ripgrep-install && curl -L "https://github.com/BurntSushi/ripgrep/releases/download/14.1.1/ripgrep-14.1.1-x86_64-unknown-linux-musl.tar.gz" -o /ripgrep-install/ripgrep.tar.gz && tar -xzf /ripgrep-install/ripgrep.tar.gz && mv /ripgrep-install/ripgrep-*/rg /usr/local/bin/rg && chmod +x /usr/local/bin/rg && cd / && rm -rf /ripgrep-install

RUN curl -L https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/linux/apktool -o /usr/local/bin/apktool && chmod +x /usr/local/bin/apktool

RUN curl -L https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_2.10.0.jar -o /usr/local/bin/apktool.jar && chmod +x /usr/local/bin/apktool.jar

WORKDIR /app

COPY . .

ENTRYPOINT ["/bin/bash", "/app/update.sh"]