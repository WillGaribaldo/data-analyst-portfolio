# Automatic Filer Sorter

## Overview 
This Python project automates the process of organizing files into specific folders based on their file types. The script is designed to categorize and move files into designated folders for CSV files, text files, and image files.

## Features
os: This module provides a way of using operating system-dependent functionality such as reading or writing to the file system.
shutil: This module offers a number of high-level operations on files and collections of files, including copying and removal of files.

### 1. Define Base 
The base path where the files are located is defined.

### 2. Create Folders:
The script checks if the folders for different file types exist, and creates them if they don't.

### 3. List Files:
A list of all files in the base path is obtained.

### 3. Move Files:
Files are moved to their respective folders based on their extensions if they are not already present in the target folder.

## Conclusion 
By automating the file organization process, this script saves time and reduces manual errors, making it easier to manage large numbers of files.
