# 200stack CLI の配布

[200stack](https://www.200stack.com/) の CLI(`200stack`)の配布物と、Homebrew の tap を置いています。ソースはここにはありません。

```bash
brew install anytools-app/200stack/cli
```

Homebrew を使わない場合:

```bash
curl -LsSf https://github.com/anytools-app/homebrew-200stack/releases/latest/download/install.sh | sh
```

使い方・照合の手順・移行の手順は、配布物に入っている README を見てください。利用条件は [200stack の利用規約](https://www.200stack.com/terms) に従います。

- `Formula/cli.rb`: Homebrew の formula(リリースのワークフローが更新します)
- `withdrawn.txt`: 取り下げた版の一覧(1 行に 1 つ)
