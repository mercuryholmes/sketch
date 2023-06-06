<script>
  import Router from 'svelte-spa-router'
  import routes from './router'
  import Tailwindcss from './Tailwindcss.svelte'
  import Counter from './lib/Counter.svelte'
</script>

<Tailwindcss />
<main>
  <h1 class="text-3xl font-bold">Sketch</h1>

  <div class="card">
    <Counter />
  </div>

  <p>svelte-spa-router sample</p>

  <ul>
      <li class="inline-block">
        <a href="#/">Home</a>
      </li>
      <li class="inline-block">
        <a href="#/about">About</a>
      </li>
      <li class="inline-block">
        <a href="#/cat">Cat</a>
      </li>
  </ul>

  <Router {routes} />

</main>

<style lang="postcss">
</style>
