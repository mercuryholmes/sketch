<script>
	import { onMount } from 'svelte';
	import EditModal from './EditModal.svelte';
    import DeleteButton from './DeleteButton.svelte';

    let cats = [];

    async function fetchData() {
        await fetch('http://localhost:8080/api/cat', {
            method: 'GET',
            headers: {'Content-Type': 'application/json'},
        })
        .then((response) => response.json())
        .then((data) => {
            console.log(data);
            cats = data.cats;
        })
        .catch((error) => {
            console.error('Error:', error);
            alert(error);
        });
    }

    onMount(async () => {
        await fetchData();
    });
</script>

<h1>Cat page.</h1>

<table class="table-fixed">
    <thead>
        <tr>
            <th>ID</th>
            <th>名前</th>
            <th>種類</th>
            <th>説明</th>
            <th></th>
            <th></th>
        </tr>
   </thead>
   <tbody>
    {#each cats as cat}
        <tr>
            <td>{cat.id ?? ''}</td>
            <td>{cat.name ?? ''}</td>
            <td>{cat.breed ?? ''}</td>
            <td>{cat.description ?? ''}</td>
            <td><EditModal on:fetchData={ fetchData } {...cat}/></td>
            <td><DeleteButton on:fetchData={ fetchData } {...cat}/></td>
        </tr>
    {:else}
        <div>Loading...</div>
    {/each}
    </tbody>
</table>
