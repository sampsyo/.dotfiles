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

# Set up a user who can sudo without a password.
RUN apt-get install -y adduser sudo
RUN echo "asampson ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN /usr/sbin/adduser --disabled-password --shell /bin/zsh --gecos "" asampson

# Log in as user.
USER asampson
ENV HOME /home/asampson
WORKDIR /home/asampson
CMD /bin/zsh
ENV TERM xterm-256color

# Initial dependencies; enough to get dotfiles set up.
RUN sudo apt-get install -y zsh
RUN sudo apt-get install -y vim-nox
RUN sudo apt-get install -y python-dev
RUN sudo apt-get install -y python-pip
RUN sudo apt-get install -y git
RUN sudo pip install mercurial

# Install my dotfiles.
RUN hg clone https://bitbucket.org/adrian/.dotfiles
RUN cd .dotfiles ; ./rsrc/install.sh
# Make antigen fetch the bundles.
RUN zsh -c 'source ~/.zshrc'
# And the same with Vundle.
RUN vim -E -s -u ~/.vimrc +BundleInstall! +qall ; true

# More useful packages from Ubuntu.
RUN sudo apt-get install -y tmux
RUN sudo apt-get install -y ack-grep
RUN sudo apt-get install -y ruby-dev
RUN sudo apt-get install -y clang
RUN sudo apt-get install -y tcpflow
RUN sudo apt-get install -y dnsutils
RUN sudo apt-get install -y curl
RUN sudo apt-get install -y file
RUN sudo apt-get install -y cmake
RUN sudo apt-get install -y ninja-build

# Python and Ruby stuff.
RUN pip install --user hg-git
RUN pip install --user flake8
RUN pip install --user virtualenv
RUN gem install --user-install gist
