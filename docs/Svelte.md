
## Svelte　初期構築メモ

* コンテナに入る

```bash
docker exec -it svelte sh
```

* カレントディレクトリにプロジェクトの作成

```bash
npm create vite@latest ./ -- --tmplate svelte
```

* 「Svelte」 > 「JavaScript」

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

* ブラウザからアクセス
http://localhost:5173/
