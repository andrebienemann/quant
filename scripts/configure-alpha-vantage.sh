#!/bin/zsh

printf "Enter your API key: "; read key

echo -e "\nexport ALPHAVANTAGE_API_KEY=$key" >> ~/.bashrc
echo -e "\nexport ALPHAVANTAGE_API_KEY=$key" >> ~/.zshrc

kernel="/root/.venv/share/jupyter/kernels/python3/kernel.json"

echo "$(jq ".env += {\"ALPHAVANTAGE_API_KEY\": \"$key\"}" $kernel)" > $kernel
