#!/bin/bash

# Update package list
echo "Updating package list..."
sudo apt update

# List of packages to install
packages=(
    "curl"
    "git"
    "vim"
    "htop"
    "docker.io"
    "nginx"
    "python3"
    "build-essential"
    "wget"
    "unzip"
)

# Create a temporary file to hold the selected packages
temp_file=$(mktemp)

# Create a dialog box for package selection
dialog --title "Select Packages to Install" \
       --checklist "Select packages to install (use space to select):" \
       15 50 10 \
       $(for pkg in "${packages[@]}"; do
           echo "\"$pkg\" off"
         done) 2>"$temp_file"

# Exit if the user canceled the dialog
if [ $? -ne 0 ]; then
    echo "Installation canceled."
    rm -f "$temp_file"
    exit
fi

# Read selected packages from the temporary file
selected_packages=$(cat "$temp_file")

# Convert choices into an array
IFS=' ' read -r -a selected_packages_array <<< "$selected_packages"

# Clean up temporary file
rm -f "$temp_file"

# Install each selected package
for package in "${selected_packages_array[@]}"; do
    echo "Installing $package..."
    sudo apt install -y "$package"
done

echo "All selected packages have been installed!"
