import torch

print(torch.__version__)  # Print PyTorch version

# Check if CUDA (GPU support) is available
print("CUDA Available:", torch.cuda.is_available())

# List available GPUs
print("Available GPUs:", [torch.cuda.get_device_name(i) for i in range(torch.cuda.device_count())])

# Print the number of available GPUs
print("Num GPUs Available:", torch.cuda.device_count())

# Check if PyTorch was built with CUDA
print("Built with CUDA:", torch.version.cuda is not None)
print("cuda0 is :",torch.cuda.get_device_name(0))
