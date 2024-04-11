#!/bin/bash

# コンパイル
gcc -o ex01_1 ex01_1.c

# コンパイルの成功を確認
if [ $? -ne 0 ]; then
    echo "コンパイルに失敗しました。"
    exit 1
fi

# test_cases.txtからランダムに5行を選択
mapfile -t selected_cases < <(shuf -n 5 cases/test_cases_ex01_1.txt)

# 一時ファイルを作成
temp_output="temp_output.txt"
temp_output2="temp_output2.txt"
temp_error="temp_error.txt"

# 選択されたテストケースを実行
for test_case in "${selected_cases[@]}"; do
    IFS=, read -r input expect <<< "$test_case"
    # プログラム実行し、出力を整形して一時ファイルにリダイレクト
    echo $input | ./ex01_1 | tr -d '\n ' > "$temp_output" 2>&1
    echo $input | ./ex01_1 | sed 's/二つの整数を入力してください．//' | sed 's/整数 1:  整数 2://' |  tr -d '\n' > "$temp_output2" 2>&1
    echo $input | ./ex01_1 > /dev/null 2> "$temp_error"

    
    echo "テストケース: 入力 = $input"
    if [ -s "$temp_error" ]; then
        echo " 結果: エラー"
        echo "$(cat $temp_error)"
    elif grep -q -- "$expect" "$temp_output"; then
        echo " 結果: 成功"
    else
        echo " 結果: 失敗"
        echo " 実際の出力:"
        echo " $(cat $temp_output2)"
    fi
    echo ""
done

# 一時ファイルを削除
rm "$temp_output" "$temp_output2" "$temp_error"