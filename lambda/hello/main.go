package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"

	"github.com/aws/aws-lambda-go/lambda"
)

type Response struct {
	Message string `json:"message"`
}

func Handler() (Response, error) {
	ex, err := os.Executable()
	if err != nil {
		panic(err)
	}
	exPath := filepath.Dir(ex)
	fmt.Println(exPath)
	err = os.Setenv("LD_LIBRARY_PATH", fmt.Sprintf("/var/task/lib:%s", os.Getenv("LD_LIBRARY_PATH")))

    if err != nil {
        return Response{}, err
    }
	cmd := exec.Command(fmt.Sprintf("%s/deno", exPath))
	stdoutStderr, err := cmd.CombinedOutput()
	fmt.Println(string(stdoutStderr))
	if err != nil {
		return Response{}, err
	}
	return Response{
		Message: "Go Serverless v1.0! Your function executed successfully!",
	}, nil
}

func main() {
	lambda.Start(Handler)
}
