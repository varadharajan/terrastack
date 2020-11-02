# Terrastack
An opinionated skeleton project for Terraform codebases with batteries included!

## Dependencies

Terrastack development environment is containerized and has minimal dependencies as listed below:

* Docker (>= 19.03.13)
* Rake (>= 13.0.1)
* Ruby (>= 2.6)

## Usage

Terrastack provides a list of commands for managing the local development environment.

```bash
➜  terrastack git:(main) ✗ rake -T
Setting environment to local
rake env:down                # Terminate local environment
rake env:logs                # Show logs from all containers
rake env:restart             # Restart local environment
rake env:up                  # Spin up local environment
rake ssh:terraform           # Open a shell to Terraform container
rake ssh:test                # Open a shell to test code (ruby) container
rake terraform:spec:apply    # Apply Terraform plan
rake terraform:spec:destroy  # Destroy Terraform resources
rake terraform:spec:plan     # Generate Terraform plan
rake test:run                # Run tests
```

As the above codeblock indicates, we can manage our local environment for development or testing purposes using commands like `env:up`, `env:down`, `env:restart`. 

```bash
➜  terrastack git:(main) ✗ rake env:up
Setting environment to local
docker-compose up -d
Starting terrastack_localstack_1 ... done
Starting terrastack_terraform_1  ... done
Starting terrastack_test_1       ... done
Starting terrastack_dockerize_1  ... done
docker-compose exec dockerize dockerize -wait tcp://localstack:4566 -timeout 60s
2020/11/02 04:37:37 Waiting for: tcp://localstack:4566
2020/11/02 04:37:37 Problem with dial: dial tcp 192.168.160.2:4566: getsockopt: connection refused. Sleeping 1s
2020/11/02 04:37:38 Problem with dial: dial tcp 192.168.160.2:4566: getsockopt: connection refused. Sleeping 1s
2020/11/02 04:37:39 Problem with dial: dial tcp 192.168.160.2:4566: getsockopt: connection refused. Sleeping 1s
2020/11/02 04:37:40 Problem with dial: dial tcp 192.168.160.2:4566: getsockopt: connection refused. Sleeping 1s
2020/11/02 04:37:41 Problem with dial: dial tcp 192.168.160.2:4566: getsockopt: connection refused. Sleeping 1s
2020/11/02 04:37:42 Problem with dial: dial tcp 192.168.160.2:4566: getsockopt: connection refused. Sleeping 1s
2020/11/02 04:37:43 Problem with dial: dial tcp 192.168.160.2:4566: getsockopt: connection refused. Sleeping 1s
2020/11/02 04:37:44 Connected to tcp://localstack:4566
Local environment up and running..


<work smart and write code here>

➜  terrastack git:(main) ✗ rake env:down
Setting environment to local
Stopping terrastack_test_1       ... done
Stopping terrastack_dockerize_1  ... done
Stopping terrastack_terraform_1  ... done
Stopping terrastack_localstack_1 ... done
Removing terrastack_test_1       ... done
Removing terrastack_dockerize_1  ... done
Removing terrastack_terraform_1  ... done
Removing terrastack_localstack_1 ... done
Removing network terrastack_default
Terminated local environment. Bye!

```

We can run all our tests using `test:run`

```bash
➜  terrastack git:(main) ✗ rake test:run
Setting environment to local
docker-compose up -d
Creating network "terrastack_default" with the default driver
Creating terrastack_localstack_1 ... done
Creating terrastack_terraform_1  ... done
Creating terrastack_dockerize_1  ... done
Creating terrastack_test_1       ... done
docker-compose exec dockerize dockerize -wait tcp://localstack:4566 -timeout 60s
2020/11/02 04:40:01 Waiting for: tcp://localstack:4566
2020/11/02 04:40:01 Problem with dial: dial tcp 172.18.0.2:4566: getsockopt: connection refused. Sleeping 1s
2020/11/02 04:40:02 Problem with dial: dial tcp 172.18.0.2:4566: getsockopt: connection refused. Sleeping 1s
2020/11/02 04:40:03 Problem with dial: dial tcp 172.18.0.2:4566: getsockopt: connection refused. Sleeping 1s
2020/11/02 04:40:04 Problem with dial: dial tcp 172.18.0.2:4566: getsockopt: connection refused. Sleeping 1s
2020/11/02 04:40:05 Problem with dial: dial tcp 172.18.0.2:4566: getsockopt: connection refused. Sleeping 1s
2020/11/02 04:40:06 Connected to tcp://localstack:4566
Local environment up and running..
Setting up modules/dynamodb/
docker-compose exec terraform cp providers/local.tf modules/dynamodb/spec/provider.tf
docker-compose exec terraform sh -c 'cd modules/dynamodb/spec; terraform init'
Initializing modules...
- test_table in ../../dynamodb

Initializing the backend...

Successfully configured the backend "local"! Terraform will automatically
use this backend unless the backend configuration changes.

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v3.13.0...
- Installed hashicorp/aws v3.13.0 (signed by HashiCorp)

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, we recommend adding version constraints in a required_providers block
in your configuration, with the constraint strings suggested below.

* hashicorp/aws: version = "~> 3.13.0"

Terraform has been successfully initialized!
<truncated for brevity>
docker-compose exec test bash -c 'ENVIRONMENT_FILE=/data/codebase/providers/local.rb bundle exec rspec modules/dynamodb/spec modules/lambda/spec systems/tweets/spec'
....

Finished in 0.66135 seconds (files took 0.40766 seconds to load)
4 examples, 0 failures
```

We can view logs with `env:logs`

```bash
➜  terrastack git:(main) ✗ rake env:logs
Setting environment to local
docker-compose up -d
terrastack_localstack_1 is up-to-date
terrastack_terraform_1 is up-to-date
terrastack_dockerize_1 is up-to-date
terrastack_test_1 is up-to-date
docker-compose exec dockerize dockerize -wait tcp://localstack:4566 -timeout 60s
2020/11/02 04:42:44 Waiting for: tcp://localstack:4566
2020/11/02 04:42:44 Connected to tcp://localstack:4566
Local environment up and running..
docker-compose logs -f
Attaching to terrastack_test_1, terrastack_dockerize_1, terrastack_terraform_1, terrastack_localstack_1
localstack_1  | Waiting for all LocalStack services to be ready
localstack_1  | 2020-11-02 04:40:00,592 CRIT Supervisor is running as root.  Privileges were not dropped because no user is specified in the config file.  If you intend to run as root, you can set user=root in the config file to avoid this message.
localstack_1  | 2020-11-02 04:40:00,595 INFO supervisord started with pid 14
localstack_1  | 2020-11-02 04:40:01,598 INFO spawned: 'dashboard' with pid 20
localstack_1  | 2020-11-02 04:40:01,600 INFO spawned: 'infra' with pid 21
localstack_1  | (. .venv/bin/activate; bin/localstack web)
localstack_1  | 2020-11-02 04:40:01,606 INFO success: dashboard entered RUNNING state, process has stayed up for > than 0 seconds (startsecs)
localstack_1  | LocalStack version: 0.12.0
localstack_1  | (. .venv/bin/activate; exec bin/localstack start --host)
localstack_1  | LocalStack version: 0.12.0
```

We can shell into the containers with `ssh:*` targets

```bash
➜  terrastack git:(main) ✗ rake ssh:test
Setting environment to local
docker-compose up -d
terrastack_localstack_1 is up-to-date
terrastack_terraform_1 is up-to-date
terrastack_dockerize_1 is up-to-date
terrastack_test_1 is up-to-date
docker-compose exec dockerize dockerize -wait tcp://localstack:4566 -timeout 60s
2020/11/02 04:44:06 Waiting for: tcp://localstack:4566
2020/11/02 04:44:06 Connected to tcp://localstack:4566
Local environment up and running..
docker-compose exec test bash
root@450e0e8045b7:/data/codebase#
```