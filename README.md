# pro2-runner
プロ 2 支援ツール


## Overview
プロ 2 の空ファイルの作成、ビルド、実行を支援するツールです

## Installation (Keio Unix)

```
gem install pro2-runner --user-install
```

PATH が通ってない場合は

```
echo "PATH=$PATH:$HOME/.gem/ruby/2.3.0/bin" >> ~/.bash_profile
source ~/.bash_profile
```

## Usage
まず、`project.yaml` を作成します

```
$ pro2 init 2 10
$ tree .
.
├── Prob21.java
├── Prob210.java
├── Prob22.java
├── Prob23.java
├── Prob24.java
├── Prob25.java
├── Prob26.java
├── Prob27.java
├── Prob28.java
├── Prob29.java
└── project.yaml
```

### ビルド

```
pro2 build # 全部ビルド
pro2 build Prob25.java # Prob25.java のみビルド
```

### 実行

```
pro2 execute # 全部実行
pro2 execute Prob25.java # Prob25.java のみ実行
```

### ビルドして実行

```
pro2 run # 全部
pro2 run Prob25.java # Prob25.java のみ
```


## LICENSE
MIT
