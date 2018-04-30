package main

import (
	"fmt"
	"os"
)

func main() {
	fmt.Printf("=> %+v\n", "sending kill to PID1")
	p, err := os.FindProcess(1)
	if err != nil {
		panic(err)
	}

	if err = p.Signal(os.Interrupt); err != nil {
		panic(err)
	}

}
