<script lang="ts">
    import { createEventDispatcher } from 'svelte';
    import Modal from '../../lib/Modal.svelte';

	const dispatch = createEventDispatcher();
	let showModal = false;

	export let id: number;
	export let name: string;
	export let breed: string | null;
	export let description: string | null;

	let cat: UpdateCat = {"name": '', "breed": null, "description": null};

	function initialize() {
		cat = {
			"name": name,
			"breed": breed,
			"description": description
		}
    };

	const url: string = `http://localhost:8080/api/cat/${id}`;
	async function submit() {
        await fetch(url, {
			method: 'PUT',
			headers: {'Content-Type': 'application/json'},
			body: JSON.stringify({
				"name": cat.name,
				"breed": cat.breed,
				"description": cat.description,
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

<button on:click={() => (showModal = true, initialize())}>
    Edit
</button>

<Modal bind:showModal>
	<form method="POST">
		<label>
			Name
			<input name="name" bind:value={cat.name}>
		</label>
		<label>
			Breed
			<input name="breed" bind:value={cat.breed}>
		</label>
		<label>
			Description
			<input name="description" bind:value={cat.description}>
		</label>
		<button type="button" on:click|preventDefault={submit}>
			Save
		</button>
	</form>
</Modal>
