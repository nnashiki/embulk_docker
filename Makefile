IMAGE=gs_embulk
EMBULK_VERSION=0.9.19
TAG=${EMBULK_VERSION}
GCLOUD_SDK_VERSION=270.0.0

google-cloud-sdk.tar.gz:
	curl -o google-cloud-sdk.tar.gz -L https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_SDK_VERSION}-linux-x86_64.tar.gz
embulk:
	curl -o embulk -L "https://dl.embulk.org/embulk-latest.jar"
	chmod +x embulk

build: google-cloud-sdk.tar.gz embulk
	docker build --no-cache -t ${IMAGE}:${TAG} .

example:
	docker run -v ${PWD}:/work -w /work --rm gs_embulk:0.9.19  example ./try1
