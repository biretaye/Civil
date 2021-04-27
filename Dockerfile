FROM debian:latest As build-env
RUN apt-get update
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3 psmisc
RUN apt-get clean 

RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter channel beta
RUN flutter upgrade
RUN flutter config --enable-web

RUN flutter doctor -v

COPY . /usr/local/bin/app
WORKDIR /usr/local/bin/app

RUN flutter pub get 


RUN flutter build web --no-sound-null-safety

EXPOSE 4040

RUN ["chmod", "+x", "/usr/local/bin/app/server/server.sh"]

# Start the web server
ENTRYPOINT [ "/usr/local/bin/app/server/server.sh" ]