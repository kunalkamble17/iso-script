#!/bin/bash
# cli-script-run successfully
# Function to install packages
install_packages() {
    sudo apt update  # Update package list
    for pkg in "$@"; do
        echo "Installing $pkg..."
        sudo apt install -y $pkg
    done
}

# Package list with numbers for selection
echo "Select the packages you want to install:"
echo "1) curl"
echo "2) git"
echo "3) vim"
echo "4) htop"
echo "5) tree"
echo "6) python3"
echo "7) build-essential"
echo "8) wget"
echo "9) docker.io"

# Read the user's choice
echo "Enter your choices (comma separated, e.g., 1,3,5): "
read -r choices

# Convert choices to array
IFS=',' read -r -a selected_choices <<< "$choices"

# Initialize an empty array to store selected packages
packages_to_install=()

# Map the selected numbers to package names
for choice in "${selected_choices[@]}"; do
    case "$choice" in
        1) packages_to_install+=("curl") ;;
        2) packages_to_install+=("git") ;;
        3) packages_to_install+=("vim") ;;
        4) packages_to_install+=("htop") ;;
        5) packages_to_install+=("tree") ;;
        6) packages_to_install+=("python3") ;;
        7) packages_to_install+=("build-essential") ;;
        8) packages_to_install+=("wget") ;;
        9) packages_to_install+=("docker.io") ;;
        *) echo "Invalid choice: $choice" ;;
    esac
done

# If no valid packages selected, exit
if [ ${#packages_to_install[@]} -eq 0 ]; then
    echo "No valid packages selected. Exiting..."
    exit 1
fi

# Install the selected packages
install_packages "${packages_to_install[@]}"

echo "Installation complete!"
