export PROJECT_NAME = EKS-ARGOCD
export DOCKER_COMPOSE_PROJECT_NAME = ${PROJECT_NAME}-infrastracture
export ENVIRONMENT = dev
export AWS_USER = Joginator
DOCKER_RUN = docker-compose -f docker-compose.yaml run --rm infra

checking-project:
ifndef PROJECT_NAME
	$(error PROJECT_NAME is required)
endif

checking-env:
ifndef ENVIRONMENT
	$(error ENVIRONMENT is required)
endif

checking-user:
ifndef AWS_USER
	$(error ENVIRONMENT is required)
endif

vault-add: checking-user
	aws-vault add ${AWS_USER}

vault-exec: checking-user
	aws-vault exec ${AWS_USER} --no-session

build: checking-env
	docker-compose build

test:
	${DOCKER_RUN} ls

validate: checking-env
	${DOCKER_RUN} terraform validate

format: checking-env
	${DOCKER_RUN} terraform fmt

init: checking-env
	${DOCKER_RUN} terraform init -reconfigure -upgrade -backend-config=backend.tfvars

plan: checking-env
	${DOCKER_RUN} terraform plan

apply: checking-env
	${DOCKER_RUN} terraform apply --auto-approve

destroy: checking-env
	${DOCKER_RUN} terraform destroy
