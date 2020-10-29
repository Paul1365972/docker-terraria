ARG ALPINE_MONO_VERSION=5.20

FROM frolvlad/alpine-mono:${ALPINE_MONO_VERSION}-glibc

RUN apk add --no-cache wget ca-certificates

WORKDIR /terraria-server

ENV WORLD_NAME=Terraria \
    WORLD_SIZE=1 \
    SEED="" \
    DIFFICULTY=0 \
    ANNOUNCEMENT_BOX=1 \
    ANNOUNCEMENT_BOX_RANGE=-1 \
    NPC_STREAM=60 \
    MAX_PLAYERS=8 \
    PORT=7777 \
    PASSWORD="" \
    SECURE=1 \
    MOTD="" \
    LANGUAGE="en-US" \
    SLOW_LIQUIDS=0 \
    ROLLING_BACKUP=2 \
    J_TIME_SPEED=2 \
    J_TIME_TOGGLE=2 \
    J_TIME_DAWN=2 \
    J_TIME_NOON=2 \
    J_TIME_DUSK=2 \
    J_TIME_MIDNIGHT=2 \
    J_GODMODE=2 \
    J_WEATHER_WIND=2 \
    J_WEATHER_WIND_TOGGLE=2 \
    J_WEATHER_RAIN=2 \
    J_WEATHER_RAIN_TOGGLE=2 \
    J_PLACEMENT_RANGE=2 \
    J_DIFFICULTY=2 \
    J_BIOME=2 \
    J_SPAWN_RATE=2

ADD entrypoint.sh ./

VOLUME [ "/world" ]
EXPOSE ${PORT}/tcp

ENTRYPOINT [ "/bin/sh", "./entrypoint.sh" ]
