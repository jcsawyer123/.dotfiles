package main

import (
	"fmt"
	"math/rand"
	"os"
	"path/filepath"
	"strconv"
	"time"

	"github.com/go-vgo/robotgo"
	"github.com/sevlyar/go-daemon"
)

const pidFile = ".antisleep_pid"

func move() {
	x, y := robotgo.GetMousePos()
	newX := x + rand.Intn(11) - 5
	newY := y + rand.Intn(11) - 5
	robotgo.MoveMouse(newX, newY)
}

func Mover() {
	for {
		move()
		time.Sleep(time.Duration(rand.Intn(30)+30) * time.Second)
	}
}

func startMover() {
	homeDir, err := os.UserHomeDir()
	if err != nil {
		fmt.Println("Error getting home directory:", err)
		return
	}

	pidFilePath := filepath.Join(homeDir, pidFile)

	if _, err := os.Stat(pidFilePath); err == nil {
		fmt.Println("Antisleep is already running.")
		return
	}

	cntxt := &daemon.Context{
		PidFileName: pidFilePath,
		PidFilePerm: 0644,
		LogFileName: filepath.Join(homeDir, ".antisleep.log"),
		LogFilePerm: 0640,
		WorkDir:     "./",
		Umask:       027,
	}

	d, err := cntxt.Reborn()
	if err != nil {
		fmt.Println("Error starting daemon:", err)
		return
	}
	if d != nil {
		fmt.Println("Antisleep started.")
		return
	}
	defer cntxt.Release()

	fmt.Println("Daemon started.")
	go Mover()

	daemon.ServeSignals()
}

func stopMover() {
	homeDir, err := os.UserHomeDir()
	if err != nil {
		fmt.Println("Error getting home directory:", err)
		return
	}

	pidFilePath := filepath.Join(homeDir, pidFile)

	if _, err := os.Stat(pidFilePath); os.IsNotExist(err) {
		fmt.Println("Antisleep is not running.")
		return
	}

	pidBytes, err := os.ReadFile(pidFilePath)
	if err != nil {
		fmt.Println("Error reading PID file:", err)
		return
	}

	pid, err := strconv.Atoi(string(pidBytes))
	if err != nil {
		fmt.Println("Error parsing PID:", err)
		return
	}

	process, err := os.FindProcess(pid)
	if err != nil {
		fmt.Println("Error finding process:", err)
		return
	}

	err = process.Signal(os.Interrupt)
	if err != nil {
		fmt.Println("Error sending interrupt signal:", err)
		return
	}

	err = os.Remove(pidFilePath)
	if err != nil {
		fmt.Println("Error removing PID file:", err)
		return
	}

	fmt.Println("Antisleep stopped.")
}

func statusMover() {
	homeDir, err := os.UserHomeDir()
	if err != nil {
		fmt.Println("Error getting home directory:", err)
		return
	}

	pidFilePath := filepath.Join(homeDir, pidFile)

	if _, err := os.Stat(pidFilePath); os.IsNotExist(err) {
		fmt.Println("Antisleep is not running.")
	} else {
		fmt.Println("Antisleep is running.")
	}
}

func main() {
	if len(os.Args) != 2 {
		fmt.Println("Usage: antisleep [start|stop|status]")
		os.Exit(1)
	}

	command := os.Args[1]

	switch command {
	case "start":
		startMover()
	case "stop":
		stopMover()
	case "status":
		statusMover()
	default:
		fmt.Println("Invalid command. Use 'start', 'stop', or 'status'.")
		os.Exit(1)
	}
}