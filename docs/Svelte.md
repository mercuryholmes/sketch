
## Svelte　初期構築メモ

* コンテナに入る

```bash
docker exec -it svelte sh
```

* カレントディレクトリにプロジェクトの作成

```bash
npm create vite@latest ./ -- --tmplate svelte
# yarn create vite ./ --tmplate svelte
```

* 「Svelte」 > 「TypeScript」

* インストール

```bash
npm install
# yarn install
```

* ホストからアクセスができるようvite.config.tsに追記

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
