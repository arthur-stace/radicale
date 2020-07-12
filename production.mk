STAGE = production

run:
	docker run -d --name radical_test \
	-p 127.0.0.1:5232:5232 \
	--init \
	--read-only \
	--security-opt="no-new-privileges:true" \
	--cap-drop ALL \
	--cap-add CHOWN \
	--cap-add SETUID \
	--cap-add SETGID \
	--cap-add KILL \
	--pids-limit 50 \
	--memory 256M \
	--health-cmd="curl --fail http://localhost:5232 || exit 1" \
	--health-interval=30s \
	--health-retries=3 \
	-v $(shell pwd)/data:/data \
	radicale:latest
	# -v ~/radicale/config:/config:ro \
		#


calendar:
	${MAKE} -e DOMAIN=$(DOMAIN) -e STAGE=$(STAGE)

