# Build the application from source
FROM golang:1.20 AS build-stage

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY *.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -o /demo

# Run the tests in the container
FROM build-stage AS run-test-stage
RUN go test -v ./...

# Deploy the application binary into a lean image
FROM golang:latest AS build-release-stage

WORKDIR /

COPY --from=build-stage /demo /demo

EXPOSE 8080

ENTRYPOINT ["/demo"]