if grep -qE "(microsoft|WSL)" /proc/version &>/dev/null && [[ "$(uname -r)" != *Microsoft* ]]; then
    export OPERATIONAL_SYSTEM='WSL'
else
    export OPERATIONAL_SYSTEM='LINUX'
fi