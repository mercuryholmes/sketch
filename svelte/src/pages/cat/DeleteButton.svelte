<script lang="ts">
    import { createEventDispatcher } from 'svelte';

	const dispatch = createEventDispatcher();

	export let id: number;
    export let name: string;

	const url: string = `http://localhost:8080/api/cat/${id}`;
	async function submit() {
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
