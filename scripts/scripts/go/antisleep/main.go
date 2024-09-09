package main

import (
	"fmt"
	"log"
	"math/rand"
	"os"
	"path/filepath"
	"strconv"
	"syscall"
	"time"

	"github.com/go-vgo/robotgo"
	"github.com/sevlyar/go-daemon"
)

const pidFile = ".mouse_mover_pid"

var logger *log.Logger

func initLogger(logFilePath string) {
	logFile, err := os.OpenFile(logFilePath, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		log.Fatal("Error opening log file: ", err)
	}
	logger = log.New(logFile, "", log.LstdFlags)
	logger.Println("Logger initialized")
}

func moveMouse() error {
	x, y := robotgo.GetMousePos()
	newX := x + rand.Intn(500) - 5
	newY := y + rand.Intn(500) - 5
	robotgo.MoveMouse(newX, newY)
	logger.Printf("Moved mouse from (%d, %d) to (%d, %d)", x, y, newX, newY)
	return nil
}

func mouseMover() {
	logger.Println("Mouse mover routine started")
	for {
		err := moveMouse()
		if err != nil {
			logger.Printf("Error moving mouse: %v", err)
		}
		sleepTime := time.Duration(rand.Intn(1)+1) * time.Second
		logger.Printf("Sleeping for %v", sleepTime)
		time.Sleep(sleepTime)
	}
}

func startMouseMover() {
	homeDir, err := os.UserHomeDir()
	if err != nil {
		fmt.Println("Error getting home directory:", err)
		return
	}

	pidFilePath := filepath.Join(homeDir, pidFile)
	logFilePath := filepath.Join(homeDir, ".mouse_mover.log")

	initLogger(logFilePath)
	logger.Println("Starting mouse mover")

	if _, err := os.Stat(pidFilePath); err == nil {
		logger.Println("PID file found, checking if process is running")
		pidBytes, err := os.ReadFile(pidFilePath)
		if err != nil {
			logger.Println("Error reading PID file:", err)
			logger.Println("Removing potentially corrupt PID file")
			os.Remove(pidFilePath)
		} else if len(pidBytes) == 0 {
			logger.Println("PID file is empty, removing it")
			os.Remove(pidFilePath)
		} else {
			pid, err := strconv.Atoi(string(pidBytes))
			if err != nil {
				logger.Println("Error parsing PID:", err)
				logger.Println("Removing invalid PID file")
				os.Remove(pidFilePath)
			} else {
				process, err := os.FindProcess(pid)
				if err != nil {
					logger.Println("Error finding process:", err)
					logger.Println("Removing stale PID file")
					os.Remove(pidFilePath)
				} else {
					err = process.Signal(syscall.Signal(0))
					if err == nil {
						logger.Println("Mouse mover is already running")
						fmt.Println("Mouse mover is already running. Check", logFilePath, "for logs.")
						return
					}
					logger.Println("Process not running, removing stale PID file")
					os.Remove(pidFilePath)
				}
			}
		}
	}

	cntxt := &daemon.Context{
		PidFileName: pidFilePath,
		PidFilePerm: 0644,
		LogFileName: logFilePath,
		LogFilePerm: 0644,
		WorkDir:     "./",
		Umask:       027,
	}

	d, err := cntxt.Reborn()
	if err != nil {
		logger.Println("Error starting daemon:", err)
		fmt.Println("Error starting daemon:", err)
		return
	}
	if d != nil {
		fmt.Println("Mouse mover started. Check", logFilePath, "for logs.")
		return
	}
	defer cntxt.Release()

	logger.Println("Daemon started")

	// Write PID to file manually
	pid := os.Getpid()
	err = os.WriteFile(pidFilePath, []byte(strconv.Itoa(pid)), 0644)
	if err != nil {
		logger.Println("Error writing PID file:", err)
	} else {
		logger.Printf("PID %d written to file", pid)
	}

	x, y := robotgo.GetMousePos()
	logger.Printf("Initial mouse position: (%d, %d)", x, y)

	go mouseMover()

	daemon.ServeSignals()
}

func stopMouseMover() {
	homeDir, err := os.UserHomeDir()
	if err != nil {
		fmt.Println("Error getting home directory:", err)
		return
	}

	pidFilePath := filepath.Join(homeDir, pidFile)
	logFilePath := filepath.Join(homeDir, ".mouse_mover.log")

	initLogger(logFilePath)
	logger.Println("Stopping mouse mover")

	if _, err := os.Stat(pidFilePath); os.IsNotExist(err) {
		logger.Println("PID file not found, mouse mover is not running")
		fmt.Println("Mouse mover is not running.")
		return
	}

	pidBytes, err := os.ReadFile(pidFilePath)
	if err != nil {
		logger.Println("Error reading PID file:", err)
		fmt.Println("Error reading PID file:", err)
		return
	}

	pid, err := strconv.Atoi(string(pidBytes))
	if err != nil {
		logger.Println("Error parsing PID:", err)
		fmt.Println("Error parsing PID:", err)
		return
	}

	process, err := os.FindProcess(pid)
	if err != nil {
		logger.Println("Error finding process:", err)
		fmt.Println("Error finding process:", err)
		return
	}

	err = process.Signal(os.Interrupt)
	if err != nil {
		logger.Println("Error sending interrupt signal:", err)
		fmt.Println("Error sending interrupt signal:", err)
		return
	}

	err = os.Remove(pidFilePath)
	if err != nil {
		logger.Println("Error removing PID file:", err)
		fmt.Println("Error removing PID file:", err)
		return
	}

	logger.Println("Mouse mover stopped")
	fmt.Println("Mouse mover stopped.")
}

func statusMouseMover() {
	homeDir, err := os.UserHomeDir()
	if err != nil {
		fmt.Println("Error getting home directory:", err)
		return
	}

	pidFilePath := filepath.Join(homeDir, pidFile)
	logFilePath := filepath.Join(homeDir, ".mouse_mover.log")

	initLogger(logFilePath)
	logger.Println("Checking mouse mover status")

	if _, err := os.Stat(pidFilePath); os.IsNotExist(err) {
		logger.Println("PID file not found, mouse mover is not running")
		fmt.Println("Mouse mover is not running.")
	} else {
		logger.Println("PID file found, mouse mover is running")
		fmt.Println("Mouse mover is running.")
	}
}

func main() {
	rand.Seed(time.Now().UnixNano())

	if len(os.Args) != 2 {
		fmt.Println("Usage: mouse_mover [start|stop|status]")
		os.Exit(1)
	}

	command := os.Args[1]

	switch command {
	case "start":
		startMouseMover()
	case "stop":
		stopMouseMover()
	case "status":
		statusMouseMover()
	default:
		fmt.Println("Invalid command. Use 'start', 'stop', or 'status'.")
		os.Exit(1)
	}
}