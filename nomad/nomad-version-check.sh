NEW_VERSION=$(curl --stderr - https://www.nomadproject.io/downloads  | grep -o '<span class="style_version__2u5ed">[0-9]*\.[0-9]*\.[0-9]*' | grep -o "[0-9]*\.[0-9]*\.[0-9]*" | uniq)
CURRENT_VERSION=$(nomad version | grep -o "[0-9]*\.[0-9]*\.[0-9]*")
echo "New version: ${NEW_VERSION}"
echo "Current version: ${CURRENT_VERSION}"
