

## Svelte　初期構築メモ

* コンテナに入る

```bash
docker exec -it svelte sh
```

* カレントディレクトリにプロジェクトの作成

```bash
npm create vite@latest ./
```

* 「SvelteKit」 > 「Skeleton project」 > 「Yes, using TypeScript syntax」 > ESLint, Prettier

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

* ブラウザでアクセス
http://localhost:5173/
