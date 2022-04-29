package main

import (
	"net/http"
	"runtime"

	"github.com/labstack/echo/v4"
)

func main() {
	e := echo.New()
	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, "Hello, DevOps!")
	})
	e.GET("/health", Health)
	e.Logger.Fatal(e.Start(":80"))
}

func Health(c echo.Context) error {
	return c.JSON(http.StatusOK, map[string]interface{}{
		"healthy": "ok",
		"runtimeData": map[string]int{
			"cpu":       runtime.NumCPU(),
			"goRoutine": runtime.NumGoroutine(),
		},
	})
}
