# FROM golang:1.10.1-stretch AS builder
FROM golang:1.9-alpine3.7 AS BUILDER

# env GOOS=linux GARCH=amd64 CGO_ENABLED=0 go install -v -a -installsuffix cgo

# RUN apk-install bash go bzr git mercurial subversion openssh-client ca-certificates 

WORKDIR /go/src/github.com/ederavilaprado/k8s_handling_shutdown
COPY . /go/src/github.com/ederavilaprado/k8s_handling_shutdown

# RUN CGO_ENABLED=0 go build -o trap ./main_process/main.go
# RUN CGO_ENABLED=0 go build -o side ./sidecar/main.go

RUN go build -o trap ./main_process/main.go
RUN go build -o side ./sidecar/main.go

# FROM debian:stretch-slim
# RUN apt-get update -y
# RUN apt-get -y install iputils-ping telnet net-tools

FROM alpine:3.7

WORKDIR /app
COPY --from=builder /go/src/github.com/ederavilaprado/k8s_handling_shutdown/trap ./trap
COPY --from=builder /go/src/github.com/ederavilaprado/k8s_handling_shutdown/side ./side

CMD ["./trap"]
