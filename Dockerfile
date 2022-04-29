FROM golang:1.18-alpine as build
WORKDIR /app
COPY ./go.mod ./go.sum ./
RUN go get ./...
COPY ./cmd/http/main.go ./
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -mod=readonly -o /api

FROM scratch
WORKDIR /app
COPY --from=build /api /app/api
EXPOSE 80
ENTRYPOINT ["/app/api"]