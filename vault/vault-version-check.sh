NEW_VERSION=$(curl --stderr - https://www.vaultproject.io/downloads  | grep -o 'Current Version:</strong> <!-- -->[0-9]*\.[0-9]*\.[0-9]*' | grep -o "[0-9]*\.[0-9]*\.[0-9]*" | uniq)
CURRENT_VERSION=$(vault version | grep -o "[0-9]*\.[0-9]*\.[0-9]*" )
echo ${NEW_VERSION}
echo ${CURRENT_VERSION}