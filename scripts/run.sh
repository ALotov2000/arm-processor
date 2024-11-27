#!/bin/bash

echo "Changing Directory..."
cd "$(dirname "$0")"
cd ..

MAIN_DIR="$(pwd)"
PROJECT_NAME="arm"
PROJECT_FILE="$MAIN_DIR/$PROJECT_NAME.mpf"

echo "Current Directory: $MAIN_DIR"

# Check if the ModelSim project exists
if [ ! -f "$PROJECT_FILE" ]; then
    echo "No ModelSim project found in $MAIN_DIR. Creating a new Verilog project..."

    # Create a TCL script to generate the project in the main directory
    cat <<EOT > scripts/create_project.tcl
project new {$MAIN_DIR/$PROJECT_NAME} --default_hdl verilog
project addlibrary work
EOT

    # Run the TCL script to create the project and add files
    vsim $MAIN_DIR/$PROJECT_FILE -do scripts/create_project.tcl -do ./scripts/add_files.tcl
else
    echo "ModelSim project already exists: $PROJECT_FILE"
    vsim $MAIN_DIR/$PROJECT_FILE -do ./scripts/add_files.tcl
fi
