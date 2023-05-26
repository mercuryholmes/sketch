

## Haskell　初期構築でやったことメモ

* コンテナに入る

```bash
docker exec -it haskell bash
```

* カレントディレクトリにプロジェクトの作成

```bash
stack new scotty-api --bare
```

* インストール

```bash
stack install
```

* ビルド

```bash
stack build
```
