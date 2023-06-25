
type Cat = {
    "id": number,
    "name": string,
    "breed": string | null,
    "description": string | null,
};

type CreateCat = {
    "name": string,
    "breed": string | null,
    "description": string | null,
};

type UpdateCat = {
    "name": string,
    "breed": string | null,
    "description": string | null,
};
