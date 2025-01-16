##STEP1
FROM golang:1.22 AS builder

RUN mkdir -p /web

WORKDIR /app

RUN go mod init webserver && go mod tidy 

COPY . /app

#Be attention to your archicteture - I'm using arm64 (Raspberry Pi 4)
RUN CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -o main ./app.go

EXPOSE 8080

CMD ["./main" ]

#STEP2
FROM alpine:latest

#Set the working directory
WORKDIR /web

#Copy the built executable from the builder stage
COPY --from=builder /app/main .

# Add a user for running the application
RUN adduser -S -D -H -h /web app && chown -R app: /web && apk add curl 

# Switch to the new user
USER app

# Command to run the executable
CMD ["./main"]