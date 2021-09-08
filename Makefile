TARGET_HOST ?= "www.gobeyond.mytens.id"
TARGET_PORT ?= "80"
THREADS ?= "50"
CONTAINER_NAME ?= "docker-jmeter"
IMAGE = "telkomdev/jmeter:5.2.1"
JVM_ARGS ?= "-Xms1g -Xmx1g -XX:MaxMetaspaceSize=256m"
TARGET_PATH ?= "/report.html"
TARGET_KEYWORD ?= "google"

TEST_DIR = jmxFile
REPORT_DIR=report

all: clean run report

clean:
	@rm -rf $(REPORT_DIR) $(TEST_DIR)/test-plan.jtl $(TEST_DIR)/jmeter.log

run:
	@mkdir -p $(REPORT_DIR)
	docker run --rm --name $(CONTAINER_NAME) -i -v $(PWD):$(PWD) -w $(PWD) $(IMAGE) \
	-Dlog_level.jmeter=DEBUG \
	-JTARGET_HOST=${TARGET_HOST} -JTARGET_PORT=${TARGET_PORT} \
	-JTARGET_PATH=${TARGET_PATH} -JTARGET_KEYWORD=${TARGET_KEYWORD} \
	-JTHREADS=$(THREADS) \
	-n -t $(TEST_DIR)/test-plan.jmx -l $(TEST_DIR)/test-plan.jtl -j $(TEST_DIR)/jmeter.log \
	-e -o $(REPORT_DIR)

report:
	echo "==== jmeter.log ===="
	cat $(TEST_DIR)/jmeter.log
	echo "==== Raw Test Report ===="
	cat $(TEST_DIR)/test-plan.jtl
	echo "==== HTML Test Report ===="
	echo "See HTML test report in $(REPORT_DIR)/index.html"