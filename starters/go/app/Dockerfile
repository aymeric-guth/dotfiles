FROM golang:1.18.3-alpine3.16 AS build
RUN apk update && \
  apk add --no-cache \
  netcat-openbsd \
  iproute2 \
  nmap \
  curl
COPY . /usr/local/go/project
WORKDIR /usr/local/go/project
RUN go mod download
ARG BUILD_ARGS
ENV BUILD_ARGS=${BUILD_ARGS}
# RUN CGO_ENABLED=0 go build -o entry ${BUILD_ARGS} project


#FROM alpine:latest
#ARG GO_MAIN
#ENV GO_MAIN=${GO_MAIN}
#COPY --from=build /src/entry /
#CMD [ "/entry" ]
#
#
#EXPOSE 8080
