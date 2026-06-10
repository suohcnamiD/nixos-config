#!/usr/bin/env bash

echo "========== Starting NixOS Rebuild =========="
# This forces the terminal to ask for your sudo password safely inside the window
sudo nixos-rebuild switch --flake ~/nixos-config#asus

# Check if the previous command succeeded
if [ $? -eq 0 ]; then
    notify-send -u normal -a "NixOS" "Rebuild Successful" "Your system has been updated successfully."
    echo -e "\n✅ Success! Closing in 3 seconds..."
    sleep 3
else
    notify-send -u critical -a "NixOS" "Rebuild Failed" "Check the terminal logs for compilation errors."
    echo -e "\n❌ Failed! Press ENTER to close this window..."
    read # Keeps the window open so you can actually read the error logs
fi
