FROM haskell:9.2.7

WORKDIR /data/repo
RUN stack upgrade
RUN stack --version

COPY . ./
RUN stack build

# CMD ["stack", "run", "scotty-api-exe"]
