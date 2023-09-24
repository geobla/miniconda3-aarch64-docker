# Use a base image compatible with ARM64 architecture
FROM arm64v8/ubuntu

# Install required tools
RUN apt-get update && apt-get install -y wget

# Set up a working directory
WORKDIR /tmp

# Download Mambaforge for Linux AArch64 (ARM64)
RUN wget https://github.com/conda-forge/miniforge/releases/download/23.3.1-1/Mambaforge-23.3.1-1-Linux-aarch64.sh -O mambaforge.sh

# Make the installer script executable
RUN chmod +x mambaforge.sh

# Install Mambaforge
RUN /bin/sh mambaforge.sh -b -p /opt/mambaforge && rm mambaforge.sh

# Add Mambaforge to the system PATH
ENV PATH="/opt/mambaforge/bin:${PATH}"

# Update conda
RUN conda update -y conda

# Clean up using apt-get
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set the default command to start a shell
CMD ["/bin/sh"]
