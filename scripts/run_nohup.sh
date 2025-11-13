#!/bin/bash

# run_nohup.sh - Run program in background with nohup

PROGRAM="python3 path_to_main.py"
#PROGRAM="python3 /home/martin/PycharmProjects/simple_analyzer/simple_analyze/main.py"
LOG_FILE="nohup.out"
PID_FILE="program.pid"

start() {
    if [ -f $PID_FILE ] && ps -p $(cat $PID_FILE) > /dev/null 2>&1; then
        echo "Program is already running with PID $(cat $PID_FILE)"
        return
    fi

    echo "Starting program in background..."
    nohup $PROGRAM >> $LOG_FILE 2>&1 &
    echo $! > $PID_FILE
    echo "Program started with PID: $(cat $PID_FILE)"
    echo "Output is being logged to: $LOG_FILE"
}

stop() {
    if [ -f $PID_FILE ]; then
        PID=$(cat $PID_FILE)
        if ps -p $PID > /dev/null 2>&1; then
            echo "Stopping program with PID: $PID"
            kill $PID
            sleep 2
            if ps -p $PID > /dev/null 2>&1; then
                echo "Process did not stop, force killing..."
                kill -9 $PID
            fi
            echo "Program stopped."
        else
            echo "PID file exists but program is not running."
        fi
        rm -f $PID_FILE
    else
        echo "No PID file found. Program may not be running."
    fi
}

status() {
    if [ -f $PID_FILE ]; then
        PID=$(cat $PID_FILE)
        if ps -p $PID > /dev/null 2>&1; then
            echo "Program is running with PID: $PID"
        else
            echo "PID file exists but program is not running."
            rm -f $PID_FILE
        fi
    else
        echo "Program is not running."
    fi
}

# ----------------------------
# Main
# ----------------------------
case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    status)
        status
        ;;
    restart)
        stop
        sleep 2
        start
        ;;
    *)
        echo "Usage: $0 {start|stop|status|restart}"
        exit 1
        ;;
esac