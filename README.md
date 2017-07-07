# reverse-me

# Purpose

This Dockerfile builds an Ubuntu-based Docker container, specially configured for reverse-engineering.

**A quick and easy way to deploy a 32/64 bits UNIX environement platform on any box, including Linux, MacOS or Windows!**

Tools installed:

- gdb with peda layer
- radare2
- strace
- valgrind
- uncompyle6
- fish shell

# Build

To build the container, just use this command:

```bash
docker build -t reversing .
```

Docker will download the Ubuntu image and then execute the installation steps.

> Be patient, the process can be quite long the first time.

# Run

Once the build process is over, get and enjoy your new reversing platform !

```bash
docker run -it --rm -v CHALLENGE_PATH:/tmp/data --name reversing reversing YOUR_SHELL
```

Explanations:

- We mount a shared folder to simplify the data exchange between the container and the host
- We delete the container when exited

Of course, it is up to you to adjust it to your taste or need.


Note: Don't forget to regularly pull this repository for updates.