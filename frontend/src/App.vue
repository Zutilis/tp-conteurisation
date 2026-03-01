<template>
  <div class="container">
    <header class="header">
      <h1>Contacts</h1>
      <p class="subtitle">Gérez vos contacts simplement</p>
    </header>
    <div class="card form-card">
      <h2>{{ editing ? 'Modifier' : 'Nouveau contact' }}</h2>
      <form @submit.prevent="saveContact">
        <input v-model="form.name" placeholder="Nom complet" required />
        <input v-model="form.email" type="email" placeholder="Email" required />
        <input v-model="form.phone" placeholder="Téléphone (optionnel)" />
        <div class="btn-row">
          <button type="submit" class="btn-primary">
            {{ editing ? 'Mettre à jour' : 'Ajouter' }}
          </button>
          <button v-if="editing" type="button" class="btn-secondary" @click="cancelEdit">
            Annuler
          </button>
        </div>
      </form>
    </div>
    <div class="card">
      <h2>{{ contacts.length }} contact{{ contacts.length > 1 ? 's' : '' }}</h2>
      <p v-if="contacts.length === 0" class="empty">
        Aucun contact pour l'instant.
      </p>
      <div v-for="c in contacts" :key="c.id" class="contact-row">
        <div class="info">
          <strong>{{ c.name }}</strong>
          <span>{{ c.email }}</span>
          <span v-if="c.phone" class="phone">{{ c.phone }}</span>
        </div>
        <div class="actions">
          <button class="btn-primary" @click="startEdit(c)">Modifier</button>
          <button class="btn-delete" @click="deleteContact(c.id)">Supprimer</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
const API = '/api/contacts'
const headers = { 'Content-Type': 'application/json', Accept: 'application/json' }

export default {
  data() {
    return {
      contacts: [],
      form: { name: '', email: '', phone: '' },
      editing: null
    }
  },
  mounted() {
    this.fetchContacts()
  },
  methods: {
    async fetchContacts() {
      const res = await fetch(API)
      this.contacts = await res.json()
    },
    async saveContact() {
      if (this.editing) {
        await fetch(`${API}/${this.editing}`, {
          method: 'PUT',
          headers,
          body: JSON.stringify(this.form)
        })
      } else {
        await fetch(API, { method: 'POST', headers, body: JSON.stringify(this.form) })
      }
      this.resetForm()
      this.fetchContacts()
    },
    startEdit(c) {
      this.editing = c.id
      this.form = { name: c.name, email: c.email, phone: c.phone || '' }
    },
    cancelEdit() {
      this.resetForm()
    },
    async deleteContact(id) {
      await fetch(`${API}/${id}`, { method: 'DELETE' })
      this.fetchContacts()
    },
    resetForm() {
      this.editing = null
      this.form = { name: '', email: '', phone: '' }
    }
  }
}
</script>

<style>
* {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

body {
  font-family: 'Segoe UI', sans-serif;
  background: rgb(246, 246, 246);
  color: black;
}

.header {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-items: center;
}

.container {
  max-width: 620px;
  margin: 50px auto;
  padding: 0 20px;
}

header {
  margin-bottom: 30px;
}

h1 {
  font-size: 25px;
  font-weight: 700;
  color: black;
}

.subtitle {
  margin-top: 4px;
  font-size: 14px;
}

h2 {
  font-size: 15px;
  font-weight: 600;
  margin-bottom: 20px;
  text-transform: uppercase;
}

.card {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  background: white;
  border-radius: 12px;
  padding: 28px;
  margin-bottom: 20px;
  box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
}

form {
  display: flex;
  flex-direction: column;
  gap: 12px;
  width: 100%;
}

input {
  padding: 10px 15px;
  background-color: white;
  border: 1px solid black;
  border-radius: 10px;
  font-size: 14px;
  width: 100%;
  outline: none;
  transition: border-color 0.2s;
}

.btn-row {
  display: flex;
  gap: 10px;
  margin-top: 4px;
}

button {
  padding: 10px 20px;
  border: none;
  border-radius: 10px;
  font-size: 14px;
  font-weight: 600;
  cursor: pointer;
  transition: opacity 0.15s;
}

button:hover {
  opacity: 0.85;
}

.empty {
  color: rgb(0, 0, 0, 0.5);
  font-size: 14px;
  font-style: italic;
}

.contact-row {
  display: flex;
  align-items: center;
  width: 100%;
  gap: 20px;
  padding: 15px 0;
  border-bottom: 1px solid #f0f0f0;
}

.contact-row:last-child {
  border-bottom: none;
}

.info {
  display: flex;
  flex-direction: column;
  gap: 2px;
  flex: 1;
}

.info strong {
  font-size: 15px;
}

.info span {
  font-size: 13px;
  color: #888;
}

.actions {
  display: flex;
  gap: 10px;
}

.btn-primary {
  background: #e8f4fd;
  color: #2196f3;
}

.btn-secondary {
  background: #f0f0f0;
  color: #555;
}

.btn-delete {
  background: #fdecea;
  color: #de3835;
}
</style>