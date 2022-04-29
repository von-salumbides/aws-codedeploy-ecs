TF_DIR_CMD=-chdir=terraform/$(TF_DIR)
TF_ACCT_CMD=-var="aws_account=$(AWS_ACCOUNT_ID)"
.PHONY:
upgrade:
	terraform $(TF_DIR_CMD)  init -upgrade $(TF_ACCT_CMD)
init:
	terraform $(TF_DIR_CMD)  init $(TF_ACCT_CMD)
fmt:
	terraform $(TF_DIR_CMD)  fmt 
validate: fmt
	terraform $(TF_DIR_CMD)  validate 
workspace:
	terraform $(TF_DIR_CMD) workspace new $(ENVIRONMENT) >/dev/null 2>&1 || terraform $(TF_ACCT_CMD) workspace select $(ENVIRONMENT)
plan: init validate 
	terraform $(TF_DIR_CMD) plan \
	$(TF_ACCT_CMD)
apply: init validate 
	terraform $(TF_DIR_CMD) apply \
	-auto-approve \
	$(TF_ACCT_CMD)
destroy: init validate 
	terraform $(TF_DIR_CMD) destroy \
	-auto-approve \
	$(TF_ACCT_CMD)
match:
	terraform $(TF_DIR_CMD) apply \
	-refresh-only \
	-auto-approve \
	$(TF_ACCT_CMD)

#########################
#         PACKER        #
#########################
pkrfmt:
	packer fmt packer/
pkrinit:
	packer init packer/
pkrbuild: pkrinit
	packer build \
	-var "ami_account_id=$(AWS_ACCOUNT_ID)" \
	packer/

#########################
#         Ansible       #
#########################
playbook:
	ansible-playbook ./ansible/ecs.yml -e aws_account=$(AWS_ACCOUNT_ID) 
playbook-rollback:
	ansible-playbook ./ansible/ecs-rollback.yml -e aws_account=$(AWS_ACCOUNT_ID) 
