#!/bin/bash

source_dir="source"
note_dir="note"
src_dir=$source_dir"/"$note_dir
out_file="source/index.rst"

function tocWrite(){
	tittle=$1
	tittle=${tittle#${src_dir}"/"}  #截取note/右边
	tittle=${tittle%/*} #截取/左边
	
	#echo "$tittle" >> $out_file
	#echo "==================================" >> $out_file
	echo ".. toctree::" >> $out_file
	echo "   :maxdepth: 2" >> $out_file
	echo -e "   :caption: $tittle\n" >> $out_file
}

function getfile(){
	for element in `ls $1` #ls指定目录
	do
		file=$1"/"$element #获取目录下的文件或文件夹
		
		if [[ $file == *.md ]] #如果是md文件
		then
			file=${file#${source_dir}"/"}
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
echo "我的学习笔记" >> $out_file
echo "==================================" >> $out_file
getdir $src_dir