<script lang="ts">
    import { createEventDispatcher } from 'svelte';
    import Modal from '../../lib/Modal.svelte';
	import Message from '../../lib/Message.svelte';

	const dispatch = createEventDispatcher();
	let showModal: boolean = false;
	let message: string;
	let cat: CreateCat = {"name": '', "breed": null, "description": null};

	function initialize() {
		message = '';
		cat = {
			"name": '',
			"breed": null,
			"description": null
		}
    };

	const url: string = `http://localhost:8080/api/cat/`;
	async function submit() {
        await fetch(url, {
			method: 'POST',
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
			message = "Success create cat!";
			dispatch('fetchData');
        })
        .catch((error) => {
            console.error('Error:', error);
        });
	};
</script>

<button on:click={() => (showModal = true, initialize())}>
    Add
</button>

<Modal bind:showModal>
	<div slot="header">
		<Message bind:message />
	</div>
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
