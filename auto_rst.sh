#!/bin/bash

note_dir="note"
out_file="index.rst"

function tocWrite(){
	tittle=$1
	tittle=${tittle#${note_dir}"/"}  #截取note/右边
	tittle=${tittle%/*} #截取/左边
	
	echo "$tittle" >> $out_file
	echo "==================================" >> $out_file
	echo ".. toctree::" >> $out_file
	echo "   :maxdepth: 1" >> $out_file
	echo -e "   :caption: $tittle:\n" >> $out_file
}

function getfile(){
	for element in `ls $1` #ls指定目录
	do
		file=$1"/"$element #获取目录下的文件或文件夹
		
		if [[ $file == *.md ]] #如果是md文件
		then
			echo "   $file" >> $out_file
		fi
	done
	
	echo "" >> $out_file
}

function getdir(){
	for element in `ls $1` #ls指定目录
	do
		dir=$1"/"$element #获取目录下的文件或文件夹
		
		if [ -d $dir ] #如果是文件夹
		then
			tocWrite $dir
			getfile $dir
		fi
	done
}

rm $out_file -f
getdir $note_dir