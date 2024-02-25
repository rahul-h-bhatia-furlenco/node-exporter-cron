# Kubernetes Cron Job for Node Metrics Collection

This project demonstrates how to create a Kubernetes cron job that pulls node metrics such as CPU, Memory, and Disk usage, and stores them in a file. 

## Table of Contents
- [Problem Statement](#problem-statement)
- [Expected Output](#expected-output)
- [Project Structure](#project-structure)
- [Setup](#setup)
- [Usage](#usage)
- [Demo](#demo)
- [Assumptions](#assumptions)
- [Future Improvements](#future-improvements)
- [Contributing](#contributing)
- [License](#license)

## Problem Statement

Create a Kubernetes cron job that periodically pulls node metrics (CPU, Memory, Disk usage) and stores them in a file. Each run of the cron job should create a new file with a filename containing the current timestamp. The cron schedule should be configurable with minimal changes to the code. Use a tool like node exporter to collect and expose metrics. The instances involved are Kubernetes nodes themselves.

## Expected Output

1. The program code pulls the metrics and writes them to a file.
2. Dockerfile to containerize the code.
3. Kubernetes YAML or Helm Chart.
4. README file explaining the design, deployment, and other details.
5. Optionally, a short demo video showcasing the output with code files.

## Project Structure

## Setup

1. Clone this repository:

    ```bash
    git clone https://github.com/your-username/kubernetes-cron-job.git
    ```

2. Navigate to the project directory:

    ```bash
    cd kubernetes-cron-job
    ```

3. Customize the cron schedule in `cronjob.yaml` if needed.

## Usage

1. Build the Docker image:

    ```bash
    docker build -t metrics-collector .
    ```

2. Deploy the Kubernetes cron job:

    ```bash
    kubectl apply -f cronjob.yaml
    ```

## Demo

[![Watch the demo](demo-thumbnail.png)](demo-video.mp4)

[Watch Demo Video](demo-video.mp4)

## Assumptions

1. Node exporter is used to collect node metrics.
2. Local Kubernetes setup like Minikube or Kind is being used.
3. Generated output files are considered essential and retained on pod restarts.

## Future Improvements

- Implement support for customizing metrics collection frequency.
- Add support for other cloud platforms' Kubernetes flavors.
- Enhance error handling and logging in the metrics collector script.

## Contributing

Contributions are welcome! Please feel free to open an issue or submit a pull request for any improvements.

## License

This project is licensed under the [MIT License](LICENSE).
