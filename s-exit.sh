#!/bin/bash
# Exit successfully -12-11-2024
# Function to install selected packages
install_packages() {
    selected_packages=$1
    for pkg in $selected_packages; do
        sudo apt-get install -y $pkg
        if dpkg -l | grep -q "^ii  $pkg"; then
            notify-send "$pkg" "Installed successfully."
        else
            notify-send "$pkg" "Failed to install."
        fi
    done
}

# Show package selection directly with OK/Cancel
selected_packages=$(dialog --title "Select Packages to Install" \
                           --checklist "Select packages to install:" 15 50 6 \
                           curl off \
                           wget off \
                           vim off \
                           git off \
                           tree off \
                           htop off \
                           2>&1 >/dev/tty)

# If packages are selected, install them
if [ -n "$selected_packages" ]; then
    install_packages $selected_packages
fi

# After installation or selection, show the exit dialog
dialog --title "Exit" --yesno "Do you want to exit?" 7 50

response=$?
if [ $response -eq 0 ]; then
    clear
    echo "Exiting now."
    exit 0
else
    clear
    echo "Returning to package selection."
    exec $0  # Rerun the script to allow for new selections
fi
