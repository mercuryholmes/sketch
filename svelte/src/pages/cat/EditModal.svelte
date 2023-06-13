<script>
    import { createEventDispatcher } from 'svelte';
    import Modal from '../../lib/Modal.svelte';

	const dispatch = createEventDispatcher();

	export let id;
	export let name;
	export let breed;
	export let description;

	const url = `http://localhost:8080/api/cat/${id}`;
	let showModal = false;

	async function submit () {
        await fetch(url, {
			method: 'PUT',
			headers: {'Content-Type': 'application/json'},
			body: JSON.stringify({
				"name": name,
				"breed": breed,
				"description": description,
			}),
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

<button on:click={() => (showModal = true)}>
    Edit
</button>

<Modal bind:showModal>
	<form method="POST">
		<label>
			Name
			<input name="name" bind:value={name}>
		</label>
		<label>
			Breed
			<input name="breed" bind:value={breed}>
		</label>
		<label>
			Description
			<input name="description" bind:value={description}>
		</label>
		<button type="button" on:click|preventDefault={submit}>
			Save
		</button>
	</form>
</Modal>
