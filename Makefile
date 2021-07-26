# see https://man.openbsd.org/ssh-keygen.1

# Specifies the type of key to create.
# The possible values are dsa, ecdsa, ecdsa-sk, ed25519, ed25519-sk, or rsa.
KEY_TYPE ?= ed25519

# Provides a new comment.
COMMENT ?= $(USER)

SSH_KEYGEN_OPT += -t $(KEY_TYPE) -C "$(COMMENT)"

ifeq ($(KEY_TYPE),ecdsa)
KEY_BITS ?= 521
SSH_KEYGEN_OPT += -b $(KEY_BITS)
else ifeq ($(KEY_TYPE),rsa)
KEY_BITS ?= 3072
SSH_KEYGEN_OPT += -b $(KEY_BITS)
endif

SSH_KEYGEN ?= $(shell which ssh-keygen)
PUTTYGEN ?= $(shell which puttygen)

ifeq ($(SSH_KEYGEN),)
TARGET := no_ssh_keygen
else ifeq ($(PUTTYGEN),)
TARGET := no_puttygen
else
TARGET := id_$(KEY_TYPE).nopass id_$(KEY_TYPE).pass id_$(KEY_TYPE).pub \
	id_$(KEY_TYPE).nopass.ppk id_$(KEY_TYPE).pass.ppk
endif

all: $(TARGET)

no_ssh_keygen:
	@echo "Install ssh-keygen like following commands:"
	@echo "  (Debian) # apt-get install openssh-client"
	@echo "  (MSYS2)  # pacman -S openssh"

no_puttygen:
	@echo "Install puttygen like following commands:"
	@echo "  (Debian) # apt-get install putty-tools"
	@echo "  (MSYS2)  # pacman -S mingw-w64-x86_64-putty"

clean:
	$(RM) $(TARGET)

.PHONY: all no_ssh_keygen no_puttygen clean

%.nopass:
	$(SSH_KEYGEN) $(SSH_KEYGEN_OPT) -N "" -f $*
	mv $* $@

%.pass: %.nopass
	cp $< $@
	$(SSH_KEYGEN) -p -P "" -f $@

%.ppk: %
	$(PUTTYGEN) $< -o $@
