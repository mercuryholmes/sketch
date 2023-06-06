
<script>
	import { onMount } from 'svelte';

	let cats = [];

    onMount(async () => {
        await fetch('http://localhost:8080/api/cat', {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
            },
        })
        .then((response) => response.json())
        .then((data) => {
            cats = data.cats
            console.log(cats);
        })
        .catch((error) => {
            console.error('Error:', error);
        });
    });
    // });
    // let data = {"name": "テストupadated"};
    // onMount(async () => {
    //     await fetch('http://localhost:8080/api/cat/1', {
    //     method: 'PUT',
    //     headers: {
    //         'Content-Type': 'application/json',
    //     },
    //     body: JSON.stringify(data),
    //     })
    //     .then((response) => response.json())
    //     .then((data) => {
    //         console.log('Success:', data);
    //     })
    //     .catch((error) => {
    //         console.error('Error:', error);
    //     });
    // });

</script>

<h1>Cat page.</h1>

<table class="table-fixed">
    <thead>
        <tr>
            <th>番号</th>
            <th>名前</th>
            <th>種類</th>
            <th>説明</th>
        </tr>
   </thead>
   <tbody>
    {#each cats as cat}
        <tr>
            <td>{cat.id}</td>
            <td>{cat.name}</td>
            <td>{cat.breed ?? ""}</td>
            <td>{cat.description ?? ""}</td>
        </tr>
    {:else}
        <div>Loading...</div>
    {/each}
    </tbody>
</table>
