#!/bin/bash

# コンパイル
gcc -o ex01_4 ex01_4.c

# コンパイルの成功を確認
if [ $? -ne 0 ]; then
    echo "コンパイルに失敗しました。"
    exit 1
fi

# # 一時ファイルを作成
temp_error="temp_error.txt"

# cases/test_cases_ex011_4.txtからランダムに5つのテストケースを選択
mapfile -t selected_cases < <(shuf -n 5 cases/test_cases_ex01_4.txt)

# 選択されたテストケースを実行
for test_case in "${selected_cases[@]}"; do
    IFS=, read -r input expect <<< "$test_case"
    # プログラム実行し、出力を整形して変数に格納
    output=$(echo $input | ./ex01_4 | tr -d '\n ' 2>&1)
    output2=$(echo $input | ./ex01_4 | sed 's/整数を入力してください．//' | sed 's/整数 1:  整数 2://' |  tr -d '\n' 2>&1)
    echo $input | ./ex01_4 > /dev/null 2> "$temp_error"
    
    echo "テストケース: 入力 = $input"
     if [ -s "$temp_error" ]; then
        echo " 結果: エラー"
        echo "$(cat $temp_error)"
        exit 1
    # 期待される出力とプログラムの出力を比較
    elif echo "$output" | grep -q -- "$expect"; then
        echo " 結果: 成功"
        exit 0
    else
        echo " 結果: 失敗"
        echo " 実際の出力: "
        echo "$output2"
        exit 1
    fi
    echo ""
done

# 一時ファイルを削除
rm "$temp_error"