set files [glob ./src/**/*.{v,vhd}]
foreach file $files {
    vcom $file
}