#!/bin/bash

# Defines a tree_callback function that prints the file name and its contents.
# Exports the function, so it can be used with xargs.
# Runs tree -a -I '.git' -if --noreport . to generate a list of files and directories in the current directory, excluding .git folder and without printing the report at the end.
# Passes the output to xargs, which calls the tree_callback function for each item.
# To use the script, save it as tree_with_contents.sh, give it execute permissions with chmod +x tree_with_contents.sh, and then run it with ./tree_with_contents.sh.
# Keep in mind that this script will output the contents of all files in the specified directory and its subdirectories. If you have large files or a deep directory structure, the output might be overwhelming.

# To save output as a txt file run
# tree_with_contents > output.txt

# Example output:
# File: ./app.js
# Contents:
# console.log("Hello, world!");

# File: ./index.html
# Contents:
# <!DOCTYPE html>
# <html>
# <head>
#   <title>My App</title>
#   <link rel="stylesheet" href="styles.css">
# </head>
# <body>
#   <script src="app.js"></script>
#   <script src="gameLogic.js"></script>
# </body>
# </html>



# tree_callback: Function that displays the file name and its contents
# Arguments:
#   $1 - The file path
tree_callback() {
  # Check if the given path is a file
  if [ -f "$1" ]; then
    # Print the file name
    echo "File: $1"

    # Print the file contents
    echo "Contents:"
    cat "$1"
    echo
  fi
}

# Export the tree_callback function so it can be used with xargs
export -f tree_callback

# Run the tree command to generate a list of files and directories in the
# current directory, excluding the .git folder and without printing the report
# at the end. Then, pass the output to xargs, which calls the tree_callback
# function for each item.
tree -a -I '.git' -if --noreport . | xargs -I {} bash -c 'tree_callback "{}"'

