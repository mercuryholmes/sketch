<script>
  import Router from 'svelte-spa-router'
  import routes from './router'
  import Tailwindcss from './Tailwindcss.svelte'
  import Counter from './lib/Counter.svelte'
</script>

<Tailwindcss />
<main>
  <h1 class="text-3xl font-bold underline">Vite + Svelte</h1>
  
  <p>svelte-spa-router sample</p>
  <p>Basic routing</p>
  
  <ul>
      <li><a href="#/">Home</a></li>
      <li><a href="#/about">About</a></li>
  </ul>
  
  <Router {routes} />

  <div class="card">
    <Counter />
  </div>
</main>

<style lang="postcss">
</style>
