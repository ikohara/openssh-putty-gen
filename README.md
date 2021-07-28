Makefile for SSH keys in OpenSSH and PuTTY format w/ and w/o passphrase
=======================================================================

This script generates

1. SSH public key in OpenSSH format (.pub),
2. SSH private key without a passphrase in OpenSSH format (.nopass),
3. SSH private key with the passphrase in OpenSSH format (.pass),
4. SSH private key without the passphrase in PuTTY format (.nopass.ppk), and
5. SSH private key with the passphrase in PuTTY format (.pass.ppk).


Requirements
------------

* make
* ssh-keygen
* puttygen (except Windows version)


Usage
-----

    $ make  # generates Ed25519 keys as default

or

    $ make KEY_TYPE=rsa KEY_BITS=4096 COMMENT=foo

or edit Makefile and

    $ make

Then place and link (or rename) those keys appropriately, for example,

    $ mv -i id_* ~/.ssh/
    $ ln -s id_ed25519.nopass ~/.ssh/id_ed25519


License
-------

MIT License
