ACCOUNT := nextlogicdocker
SERVICE := django-hris-user-api
IMAGE := $(ACCOUNT)/$(SERVICE)
 
 
build:
	$(info Make: Building "$(TAG)" tagged images.)
	@docker build -t $(IMAGE):$(TAG) .

create-project:
	@docker-compose run --rm app sh -c "django-admin startproject $(NAME) ."

lint:
	@docker-compose run --rm app sh -c "flake8"

tag:
	$(info Make: Tagging image with "$(TAG)".)
	@docker tag $(IMAGE):latest $(IMAGE):$(TAG)
 
start:
	@docker-compose up
 
stop:
	$(info Make: Stopping "$(TAG)" tagged container.)
	@docker stop $(SERVICE)
	@docker rm $(SERVICE)
 
restart:
	$(info Make: Restarting "$(TAG)" tagged container.)
	@make -s stop
	@make -s start
 
push:
	$(info Make: Pushing "$(TAG)" tagged image.)
	@docker push $(IMAGE):$(TAG)
 
pull:
	$(info Make: Pulling "$(TAG)" tagged image.)
	@docker pull $(IMAGE):$(TAG)
 
clean:
	@docker system prune --volumes --force
 
login:
	$(info Make: Login to Docker Hub.)
	@docker login -u $(DOCKER_USER) -p $(DOCKER_PASS)