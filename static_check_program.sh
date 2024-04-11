#!/bin/bash

# コンパイル
gcc -o program program.c

# テストケースファイルを読み込み
while IFS=, read -r input expect; do
    # プログラムを実行し、出力と終了ステータスを取得
    output=$(echo $input | ./program 2>&1)
    status=$?
    
    echo "テストケース: 入力 = $input"
    # 終了ステータスが0以外、またはSegmentation faultやcore dumpedを含む場合はエラーとする
    if [ $status -ne 0 ] || [[ $output == *"Segmentation fault"* ]] || [[ $output == *"core dumped"* ]]; then
        echo " 結果: エラー (Segmentation faultまたはcore dumpedが発生しました)"
    else
        # 期待される出力が実際の出力に含まれているか確認
        if echo "$output" | grep -q "$expect"; then
            echo " 結果: 成功"
        else
            echo " 結果: 失敗"
            echo " 期待される出力: $expect"
            echo " 実際の出力: $output"
        fi
    fi
    echo ""
done < static_test_cases.txt
