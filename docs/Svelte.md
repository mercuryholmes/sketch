

## Svelte　初期構築でやったことメモ

* コンテナに入る

```bash
docker exec -it svelte sh
```

* カレントディレクトリにプロジェクトの作成

```bash
npm create vite@latest ./ -- --tmplate svelte
```

* 警告が出た場合は、npmをバージョンアップ

* インストール

```bash
npm install
```

* ホストからアクセスができるようvite.config.jsに追記

```js
  server: {
    host: true
  },
```

* 起動実行

```bash
npm run dev
```
