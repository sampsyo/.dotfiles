# Start with Ubuntu 13.10.
FROM stackbrew/ubuntu:saucy
MAINTAINER Adrian Sampson <adrian@radbox.org>

# Install stuff from Ubuntu's repositories.
RUN echo "deb http://archive.ubuntu.com/ubuntu saucy main universe multiverse restricted" > /etc/apt/sources.list
RUN apt-get update

# Ridiculous dance to get a UTF-8 locale on Ubuntu.
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales
ENV LC_ALL en_US.UTF-8

# Some useful stuff.
RUN apt-get install -y tmux zsh vim-nox ack-grep python-pip mercurial git
RUN apt-get install -y ruby-dev clang tcpflow dnsutils python-dev

# Set up a user who can sudo without a password.
RUN echo "asampson ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN adduser --disabled-password --shell /bin/zsh --gecos "" asampson

# Log in as user.
USER asampson
ENV HOME /home/asampson
WORKDIR /home/asampson
CMD /bin/zsh
ENV TERM xterm-256color

# Install my dotfiles.
RUN hg clone https://bitbucket.org/adrian/.dotfiles
RUN cd .dotfiles ; ./rsrc/install.sh
# Make antigen fetch the bundles.
RUN zsh -c 'source ~/.zshrc'
# And the same with Vundle.
RUN vim -E -s -u ~/.vimrc +BundleInstall! +qall ; true

# Python and Ruby stuff.
RUN pip install --user hg-git flake8
RUN gem install --user-install gist
