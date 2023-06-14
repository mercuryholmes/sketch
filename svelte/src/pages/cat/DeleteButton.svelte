<script>
    import { createEventDispatcher } from 'svelte';

	const dispatch = createEventDispatcher();

	export let id;
    export let name;
	const url = `http://localhost:8080/api/cat/${id}`;

	async function submit () {
        const confirm_message = confirm(`delete ${name}?`);
        if (!confirm_message) {
            return;
        }
        await fetch(url, {
			method: 'DELETE',
		})
        .then((response) => response.json())
        .then((data) => {
            console.log('Success:', data);
			dispatch('fetchData');
        })
        .catch((error) => {
            console.error('Error:', error);
        });
	};
</script>

<button on:click={submit}>
    Delete
</button>
