DOCKER=docker
DOCKER_ARGS=-v ${DBB_PATH}:/src -w /src -u `id -u`:`id -g`
DOCKER_IMAGE=vidbina/dbb-app

image:
	${DOCKER} build --rm --force-rm -t ${DOCKER_IMAGE} .

shell:
	${DOCKER} run --rm -it \
		${DOCKER_ARGS} \
		${DOCKER_IMAGE} \
		/bin/bash
