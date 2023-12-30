#!/bin/zsh

printf "Enter your API key: "; read key

echo -e "\nexport ENIGMA_API_KEY=$key" >> ~/.bashrc
echo -e "\nexport ENIGMA_API_KEY=$key" >> ~/.zshrc

kernel="/root/.venv/share/jupyter/kernels/python3/kernel.json"

echo "$(jq ".env += {\"ENIGMA_API_KEY\": \"$key\"}" $kernel)" > $kernel
