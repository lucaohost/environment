editv() {
    input_file="$1"
    output_file="edited-${input_file%.*}.${input_file##*.}"
    ffmpeg -i "$input_file" -vf "setpts=PTS/1.33" -af "atempo=1.33, volume=2" "$output_file"
}