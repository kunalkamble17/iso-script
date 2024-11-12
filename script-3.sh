#!/bin/bash

# List of packages to manage
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

# Function to install packages
install_packages() {
    echo "Updating package list..."
    sudo apt update

    for package in "${packages[@]}"; do
        echo "Installing $package..."
        sudo apt install -y "$package"
    done

    echo "All packages have been installed!"
}

# Function to remove packages
remove_packages() {
    for package in "${packages[@]}"; do
        echo "Removing $package..."
        sudo apt remove -y "$package"
    done

    echo "All packages have been removed!"
}

# Main script logic
echo "Do you want to install or remove packages? (install/remove)"
read -r action

case $action in
    install)
        install_packages
        ;;
    remove)
        remove_packages
        ;;
    *)
        echo "Invalid option. Please choose 'install' or 'remove'."
        exit 1
        ;;
esac
