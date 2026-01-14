ARG USER_BASE_IMG=loonwerks-fmide-tools
FROM $USER_BASE_IMG

# Get user UID and username
ARG UID
ARG UNAME

# Crammed a lot in here to make building the image faster
RUN useradd -u ${UID} ${UNAME} \
    && mkdir /home/${UNAME} \
    && echo 'echo "Hello, welcome to the PROVERS INSPECTA user environment"' >> /home/${UNAME}/.bashrc \
    && echo 'export PATH=/scripts/repo:$PATH' >> /home/${UNAME}/.bashrc \
    && echo 'cd /host' >> /home/${UNAME}/.bashrc \
    && chown -R ${UNAME}:${UNAME} /home/${UNAME} \
    && chmod -R ug+rw /home/${UNAME} 

VOLUME /home/${UNAME}

