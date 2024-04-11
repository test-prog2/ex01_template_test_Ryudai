#!/bin/bash

# コンパイル
gcc -o ex01_6 ex01_6.c

# コンパイルの成功を確認
if [ $? -ne 0 ]; then
    echo "コンパイルに失敗しました。"
    exit 1
fi

temp_error="temp_error.txt"

# プログラムを実行し、出力を整形して一時ファイルにリダイレクト
./ex01_6 | tr -d '\n ' > temp_output.txt

# 期待される出力を整形して別の一時ファイルに保存
tr -d '\n ' < cases/test_cases_ex01_6.txt > temp_expected.txt
echo $input | ./ex01_6 > /dev/null 2> "$temp_error"

 if [ -s "$temp_error" ]; then
        echo " 結果: エラー"
        echo "$(cat $temp_error)"
        exit 1
# 期待される出力とプログラムの出力を比較
elif diff -q temp_output.txt temp_expected.txt > /dev/null; then
    echo "全ての出力が期待される出力と一致しました。"
    exit 0
else
    echo "いくつかの出力が期待される出力と一致しませんでした。"
    diff temp_output.txt temp_expected.txt
    exit 1
fi

# 一時ファイルを削除
rm temp_output.txt temp_expected.txt temp_error.txt
