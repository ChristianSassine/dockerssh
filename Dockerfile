FROM alpine:latest

# Installing required packages (figlet is for the login message)
RUN apk add --no-cache openssh figlet

# ----- These steps are for creating a student account and are optional -----------
# Adding users to the alpine container
RUN adduser -h /home/student -s /bin/sh -D student && \
    adduser -h /home/admin -s /bin/sh -D admin && \
# Password for admin is 123 and pass123 for the student
	echo -n 'student:pass123' | chpasswd && \
    echo -n 'admin:123' | chpasswd

# Adding message for ssh login in the message of the day file(motd)
RUN figlet Welcome > /etc/motd

# Generate a ssh key
RUN mkdir -p /home/admin/.ssh && \
    mkdir -p /home/student/.ssh

# Copying the public key to the users (Must have the public key in the same directory under the name id_rsa.pub)
COPY ./id_rsa.pub /home/admin/.ssh 
COPY ./id_rsa.pub /home/student/.ssh 

# Putting the public keys into the authorized_keys for the users
RUN cat /home/admin/.ssh/id_rsa.pub > /home/admin/.ssh/authorized_keys && \
    cat /home/student/.ssh/id_rsa.pub > /home/student/.ssh/authorized_keys

# Generating the server key
RUN ssh-keygen -A 

# Exposing port 22 which is the default ssh port
EXPOSE 22

# Starting the ssh server and listening to the logs
CMD ["/usr/sbin/sshd","-D", "-e"]

