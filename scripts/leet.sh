# leet = Create folder/file to store a LeetCode problem
# Usage: leet MyExample
leet() {
    local base_dir="$HOME/git/leet-code"
    local prefix="00"
    local num=14
    local challenge_name="$1"
    if [ -z "$challenge_name" ]; then
        echo "Please provide a challenge name"
        echo "Usage: leet MyExample"
        return 1
    fi
    while ls "$base_dir/${prefix}${num}-"* 1> /dev/null 2>&1 || [ -d "$base_dir/${prefix}${num}" ]; do
        num=$((num + 1))
    done
    
    local new_dir="${prefix}${num}-${challenge_name}"
    mkdir -p "$base_dir/$new_dir"
    touch "$base_dir/$new_dir/${challenge_name}.java"
    touch "$base_dir/$new_dir/README.md"
    
    echo "Created directory and files for challenge: $new_dir"
};