# clean-zone-identifiers = Delete all Zone.Identifier files recursively in the current directory
# Usage: clean-zone-identifiers
clean-zone-identifiers() {
    local count
    count=$(find . -name "*:Zone.Identifier" | wc -l)

    if [ "$count" -eq 0 ]; then
        echo "No Zone.Identifier files found."
        return 0
    fi

    echo "Found $count Zone.Identifier file(s):"
    find . -name "*:Zone.Identifier" -print
    echo ""
    find . -name "*:Zone.Identifier" -delete
    echo "Deleted $count Zone.Identifier file(s)."
};
