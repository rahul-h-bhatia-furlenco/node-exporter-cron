# Kubernetes Cron Job for Node Metrics Collection

This project demonstrates how to create a Kubernetes cron job that pulls node metrics such as CPU, Memory, and Disk usage, and stores them in a file. 

## Table of Contents
- [Problem Statement](#problem-statement)
- [Expected Output](#expected-output)
- [Setup](#setup)
- [Usage](#usage)
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



## Setup

1. Clone this repository:

    ```bash
    git clone https://github.com/rahul-h-bhatia-furlenco/node-exporter-cron.git
    ```

2. Navigate to the project directory:

    ```bash
    cd kubernetes-cron-job
    ```

3. Customize the cron schedule in `cronjob.yml` if needed.

## Usage

# Pre-Requisite
   Adding Node Exporter to the Kubernetes Cluster. Only if you have a fresh cluster, and there is no node-exporter installed. 
   These commands will install node-exporter on every node and expose it as a cluster IP service (internal to the kubernetes cluster).

    ```bash
    kubectl apply -f node-exporter-daemonset.yml
    kubectl apply -f node-exporter-service.yml
    ```
       


# To just deploy into your cluster:
   You can follow below steps 3-5

# To build from Scratch
   Follow steps from 1-5

1. Build the Docker image:

    ```bash
    docker build -t node-exporter-linux-1 .
    ```

2. Tag and Push is to Docker Hub Repository:

    ```bash
    docker tag node-exporter-linux-1 rahulbhatia1998/node-exporter-linux-1
    docker push rahulbhatia1998/node-exporter-linux-1
    ```
    You can add your own username here, I have used mine rahulbhatia1998


3. Deploy the Storage Class Template:

    ```bash
    kubectl apply -f storage-class.yml
    ```

4. Deploy the PVC Template for local storage:

    ```bash
    kubectl apply -f storage-pvc.yml
    ```

5. Deploy the Kubernetes cron job:

    ```bash
    kubectl apply -f cronjob.yml
    ```



## Assumptions

1. Node exporter is used to collect node metrics. The metrics are collected for CPU, Memory, Disk usage.
2. The following are the metrics used for collecting from the Node-Exporter-API:
   **CPU**: node_cpu_seconds_total - >  gives the total number of seconds the CPU has spent in each mode since boot. This metric provides insights into CPU usage over time and is typically broken down into different modes such as user mode, system mode, idle, etc.
   Here's a breakdown of the different modes typically included in this metric:
   **user**: Time spent running user space processes.
   **system**: Time spent running kernel space processes.
   **idle**: Time spent idle, i.e., the CPU is not doing any work.
   **nice** (optional): Time spent running niced (lower-priority) user space processes.
   **iowait** (optional): Time spent waiting for I/O operations to complete.
   **irq** (optional): Time spent handling hardware interrupts.
   **softirq** (optional): Time spent handling software interrupts.
   **steal** (optional): Time spent in other operating systems when running in a virtualized environment.
   **guest** (optional): Time spent running a virtual CPU for guest operating systems under the control of the Linux kernel.

   **Memory**: node_memory_MemTotal_bytes and node_memory_MemFree_bytes -> 
   The node_memory_MemTotal_bytes metric provides the total amount of physical RAM installed on the system, measured in bytes. This metric represents the total memory capacity of the system.
   The node_memory_MemFree_bytes metric, on the other hand, gives the amount of physical RAM currently not being used by the system, also measured in bytes. This metric represents the amount of memory that is available for use without needing to swap to disk.

   **Disk**: node_filesystem_size_bytes and node_filesystem_free_bytes ->
   The node_filesystem_size_bytes metric provides the total size of the filesystem, typically representing the total storage capacity of the disk or partition where the filesystem resides. This metric is measured in bytes.
   The node_filesystem_free_bytes metric, on the other hand, indicates the amount of free space available on the filesystem, measured in bytes. It represents the space that is currently not in use and can be utilized for storing data.

3. Local Kubernetes setup like Minikube or Kind is being used. I have used Docker Desktop based kubenetes cluster on Macbook    having version v1.29.1
4. Generated output files are considered essential and retained on pod restarts
5. Have setup PVC along with Storage class as local Host Storage, the mainifests files are present in kubernetes-cron-job/ directory.

## Future Improvements

- Can store metrics in the future in an Object Storage like S3 bucket, if moving to an AWS EKS based system. https://docs.aws.amazon.com/eks/latest/userguide/s3-csi.html S3 CSI driver can be installed in the EKS cluster
- Also Conenct with an NFS driver if multiple host machines are there like EFS on AWS
- Enhance error handling and logging in the metrics collector script.
- In case of Multiple Worker nodes, the cron job pod can be deployed on multiple worker nodes based on kubernetes Scheduler, for this we can add taint on one Worker node and add tolerant on cronjob, so that it always gets deployed on that particular node.


## Contributing

Contributions are welcome! Please feel free to open an issue or submit a pull request for any improvements.

## License

This project is licensed under the [MIT License](LICENSE).
