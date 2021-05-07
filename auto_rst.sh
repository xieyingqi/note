#!/bin/bash

rst="C语言
==================================

.. toctree::
   :maxdepth: 1
   :caption: C语言:

   note/01_C语言/日常总结.md
"

function getdir(){
    for element in `ls $1`
    do
        dir_or_file=$1"/"$element
        if [ -d $dir_or_file ]
        then 
            getdir $dir_or_file
         else
            echo $dir_or_file >> $output_file
			
		echo $element >> $output_file
		echo "==================================" >> $output_file
        fi  
    done
}
input_dir="note"
output_file="out.rst"
getdir $input_dir