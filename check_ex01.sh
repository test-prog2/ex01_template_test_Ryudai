#!/bin/sh

DATESTR=`date "+%Y%m%d-%H%M%S"`
echo ${DATESTR}
q_num=9
fname="ex01_${DATESTR}.csv"
fname_error="ex01_error_${DATESTR}.txt"
mkdir ${DATESTR}_no_error_c_files
rm tmp.exe.stackdump

find . -maxdepth 1 -name '*.c' -type f -print0 | xargs -0 nkf -u --overwrite -w

for line in `cat "meibo.txt"`
do
	
	echo $line
	echo -n "$line, " >> $fname
	echo "$line" >> $fname_error
	
	for i in `seq $q_num`
	do
		tmp_fname=$(find . -maxdepth 1 -name "*$line*Q$i.c")
		cp $tmp_fname tmp.c
		
		if [ -e tmp.c ]; then
			gcc -o tmp.exe tmp.c
			
			if [ -e tmp.exe ]; then
				echo -n "Q$i:OO" >> $fname
				
				if [ $i -eq 1 ]; then
					bash -c 'echo 1 3 | ./tmp.exe' > bash_output.file 2>&1
					if cat bash_output.file | grep -q -e 'core dumped' -e 'Segmentation fault'; then
						echo -n "-" >> $fname
					else
						if echo 1 3 | ./tmp.exe | tr -d '\n ' | grep -q 'それらの和は4です'; then
							echo -n "O" >> $fname
							mv $tmp_fname ${DATESTR}_no_error_c_files
						else
							echo -n "X" >> $fname
							echo "Q1" >> $fname_error
							echo 1 3 | ./tmp.exe >> $fname_error
						fi
					fi
				elif [ $i -eq 2 ]; then
					bash -c 'echo 10 3 | ./tmp.exe' > bash_output.file 2>&1
					if cat bash_output.file | grep -q 'core dumped'; then
						echo -n "-" >> $fname
					else
						if echo 10 3 | ./tmp.exe | tr -d '\n ' | grep -q '1373031'; then
							echo -n "O" >> $fname
							mv $tmp_fname ${DATESTR}_no_error_c_files
						else
							echo -n "X" >> $fname
							echo "Q2" >> $fname_error
							echo 10 3 | ./tmp.exe >> $fname_error
						fi
					fi
				elif [ $i -eq 3 ]; then
					bash -c 'echo 10 8 | ./tmp.exe' > bash_output.file 2>&1
					if cat bash_output.file | grep -q 'core dumped'; then
						echo -n "-" >> $fname
					else
						if cat tmp.c | tr -d ' ' | grep -q 'doublea,b;'; then
							echo -n "X" >> $fname
							echo "Q3" >> $fname_error
							cat tmp.c | tr -d ' ' | grep 'doublea,b;' >> $fname_error
						elif cat tmp.c | tr -d ' ' | grep -q 'floata,b;'; then
							echo -n "X" >> $fname
							echo "Q3" >> $fname_error
							cat tmp.c | tr -d ' ' | grep 'floata,b;' >> $fname_error
						elif echo 10 8 | ./tmp.exe | tr -d '\n ' | grep -q '1.250'; then
							echo -n "O" >> $fname
							mv $tmp_fname ${DATESTR}_no_error_c_files
						else
							echo -n "X" >> $fname
							echo "Q3" >> $fname_error
							echo 10 8 | ./tmp.exe >> $fname_error
						fi
					fi
				elif [ $i -eq 4 ]; then
					bash -c 'echo 0 | ./tmp.exe' > bash_output.file 2>&1
					if cat bash_output.file | grep -q 'core dumped'; then
						echo -n "-" >> $fname
					else
						echo 0 | ./tmp.exe | grep -o -e '0' -o -e '０' > tmp.txt
						echo 1 | ./tmp.exe | grep -o '正' >> tmp.txt
						echo -1 | ./tmp.exe | grep -o '負' >> tmp.txt
						if cat tmp.txt | tr -d '\n ' | grep -q -e '0正負' -e '０正負'; then
							echo -n "O" >> $fname
							mv $tmp_fname ${DATESTR}_no_error_c_files
						else
							echo -n "X" >> $fname
							echo "Q4" >> $fname_error
							cat tmp.txt >> $fname_error
							echo "" >> $fname_error
						fi
						rm tmp.txt
					fi
				elif [ $i -eq 5 ]; then
					bash -c 'echo 0 | ./tmp.exe' > bash_output.file 2>&1
					if cat bash_output.file | grep -q 'core dumped'; then
						echo -n "-" >> $fname
					else
						echo  0 | ./tmp.exe | grep -o 'ありません' >  tmp.txt
						echo  1 | ./tmp.exe | grep -o '冬' >> tmp.txt
						echo  2 | ./tmp.exe | grep -o '冬' >> tmp.txt
						echo  3 | ./tmp.exe | grep -o '春' >> tmp.txt
						echo  4 | ./tmp.exe | grep -o '春' >> tmp.txt
						echo  5 | ./tmp.exe | grep -o '春' >> tmp.txt
						echo  6 | ./tmp.exe | grep -o '夏' >> tmp.txt
						echo  7 | ./tmp.exe | grep -o '夏' >> tmp.txt
						echo  8 | ./tmp.exe | grep -o '夏' >> tmp.txt
						echo  9 | ./tmp.exe | grep -o '秋' >> tmp.txt
						echo 10 | ./tmp.exe | grep -o '秋' >> tmp.txt
						echo 11 | ./tmp.exe | grep -o '秋' >> tmp.txt
						echo 12 | ./tmp.exe | grep -o '冬' >> tmp.txt
						echo 13 | ./tmp.exe | grep -o 'ありません' >> tmp.txt
						if cat tmp.txt | tr -d '\n' | grep -q 'ありません冬冬春春春夏夏夏秋秋秋冬ありません'; then
							echo -n "O" >> $fname
							mv $tmp_fname ${DATESTR}_no_error_c_files
						else
							echo -n "X" >> $fname
							echo "Q5" >> $fname_error
							cat tmp.txt >> $fname_error
							echo "" >> $fname_error
						fi
						rm tmp.txt
					fi
				elif [ $i -eq 6 ]; then
					bash -c './tmp.exe' > bash_output.file 2>&1
					if cat bash_output.file | grep -q 'core dumped'; then
						echo -n "-" >> $fname
					else
						./tmp.exe | tr -d ' ' | grep -o '1回は4月18日' >  tmp.txt
						./tmp.exe | tr -d ' ' | grep -o '2回は4月25日' >>  tmp.txt
						./tmp.exe | tr -d ' ' | grep -o '3回は5月2日' >>  tmp.txt
						./tmp.exe | tr -d ' ' | grep -o '4回は5月9日' >>  tmp.txt
						./tmp.exe | tr -d ' ' | grep -o '5回は5月16日' >>  tmp.txt
						./tmp.exe | tr -d ' ' | grep -o '6回は5月23日' >>  tmp.txt
						./tmp.exe | tr -d ' ' | grep -o '7回は5月30日' >>  tmp.txt
						./tmp.exe | tr -d ' ' | grep -o '8回は6月6日' >>  tmp.txt
						./tmp.exe | tr -d ' ' | grep -o '9回は6月13日' >>  tmp.txt
						./tmp.exe | tr -d ' ' | grep -o '10回は6月20日' >>  tmp.txt
						./tmp.exe | tr -d ' ' | grep -o '11回は6月27日' >>  tmp.txt
						./tmp.exe | tr -d ' ' | grep -o '12回は7月4日' >>  tmp.txt
						./tmp.exe | tr -d ' ' | grep -o '13回は7月11日' >>  tmp.txt
						./tmp.exe | tr -d ' ' | grep -o '14回は7月18日' >>  tmp.txt
						#./tmp.exe | tr -d ' ' | grep -o '15回は7月25日' >>  tmp.txt
						if cat tmp.txt | tr -d '\n' | grep -q '1回は4月18日2回は4月25日3回は5月2日4回は5月9日5回は5月16日6回は5月23日7回は5月30日8回は6月6日9回は6月13日10回は6月20日11回は6月27日12回は7月4日13回は7月11日14回は7月18日'; then
							echo -n "O" >> $fname
							mv $tmp_fname ${DATESTR}_no_error_c_files
						else
							echo -n "X" >> $fname
							echo "Q6" >> $fname_error
							./tmp.exe >> $fname_error
							echo "" >> $fname_error
						fi
						rm tmp.txt
					fi
				elif [ $i -eq 7 ]; then
					bash -c 'echo 42 287 | ./tmp.exe' > bash_output.file 2>&1
					if cat bash_output.file | grep -q 'core dumped'; then
						echo -n "-" >> $fname
					else
						if echo 42 287 | ./tmp.exe | grep -q '7'; then
							echo -n "O" >> $fname
							mv $tmp_fname ${DATESTR}_no_error_c_files
						else
							echo -n "X" >> $fname
							echo "Q7" >> $fname_error
							echo 42 287 | ./tmp.exe >> $fname_error
						fi
					fi
				elif [ $i -eq 8 ]; then
					bash -c 'echo 埼玉太朗 | ./tmp.exe' > bash_output.file 2>&1
					if cat bash_output.file | grep -q 'core dumped'; then
						echo -n "-" >> $fname
					else
						if echo 埼玉太朗 | ./tmp.exe | grep -q '埼玉太朗'; then
							echo -n "O" >> $fname
							mv $tmp_fname ${DATESTR}_no_error_c_files
						else
							echo -n "X" >> $fname
							echo "Q8" >> $fname_error
							echo 埼玉太朗 | ./tmp.exe >> $fname_error
						fi
					fi
				elif [ $i -eq 9 ]; then
					for num in `seq 10`
					do
						bash -c 'echo 42 287 | ./tmp.exe' > bash_output.file 2>&1
						
						if cat bash_output.file | grep -q 'core dumped'; then
							echo -n - >> check_tmp.txt
						elif cat bash_output.file | tr -d '\n ' | grep -q '7'; then
							echo -n 1 >> check_tmp.txt
						else
							echo -n 0 >> check_tmp.txt
						fi
					done
					if cat check_tmp.txt | grep -q '-'; then
						echo -n "-" >> $fname
					elif cat check_tmp.txt | grep -q '1111111111'; then
						echo -n "O" >> $fname
						mv $tmp_fname ${DATESTR}_no_error_c_files
					else
						echo -n "X" >> $fname
						echo "Q9" >> $fname_error
						cat check_tmp.txt >> $fname_error
						echo 42 287 | ./tmp.exe >> $fname_error
						echo >> $fname_error
					fi
					rm check_tmp.txt
				fi
				
				rm bash_output.file
				rm tmp.exe
				
			else
				echo -n "Q$i:OXX" >> $fname
			fi
			
			rm tmp.c
			
		else
			echo -n "Q$i:XXX" >> $fname
		fi
		
		echo -n ",  " >> $fname
		
	done
	
	echo >> $fname
	
done

