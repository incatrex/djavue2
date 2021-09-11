[ django-tdd-docker ] Demo
================================================================================

## 1. Open and Build Devcontainder

F1 --> Remote-Containers: Rebuild and Reopen in Container

## 2. Note .devcontainer configuration - allows running host (Mac) docker-compose from inside devcontainer

.devcontainer.json has mount to expose host docker desktop (on Mac)
```json
	"mounts": [ 
		"source=/var/run/docker.sock,target=/var/run/docker-host.sock,type=bind",
		"source=${localEnv:HOME}/dev/.scripts,target=/.scripts,type=bind,consistency=cached" 
	],
```

Dockerfile has alias for docker-compose and install for docker and docker-compose:
```Dockerfile
RUN echo "alias dc-up='docker-compose -f docker-compose.yml -f .devcontainer/docker-compose.yml up -d --build'" >> /etc/bash.bashrc

# Install docker and docker-compose linked to host instance
COPY .devcontainer/scripts/docker-debian.sh /tmp/scripts/
RUN apt-get update && bash /tmp/scripts/docker-debian.sh
ENTRYPOINT ["/usr/local/share/docker-init.sh"]
CMD ["sleep", "infinity"]
```

.devcontainer contains docker-compose.yml override used in dc-up alias above

## 3. Build and launch containers for postgres and server with alias:

```
dc-up
```

## 4. Run tests:
```
docker-compose exec movies pytest -p no:warnings --cov=.
```

## 5.  Note linting and formatting options:

```
docker-compose exec movies flake8 .
docker-compose exec movies black --exclude=migrations .
docker-compose exec movies isort .
```

## 5. Load some test movie data:

```
docker-compose exec movies python manage.py loaddata movies.json
```

## 6. Test API via Django REST Framework and/or Swagger (and check out docs):
```
http://localhost:8009/api/movies/
http://localhost:8009/swagger-docs/
http://localhost:8009/docs/
```

## 7. CI/CD is done via GitLab and Heroku


