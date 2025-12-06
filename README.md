# **Data Diri**

Nama        : Aditya Fathan Naufaldi<br>
NIM         : H1D023076<br>
Shift Lama  : F<br>
Shift Baru  : B

---

# **Demo Aplikasi**

https://github.com/user-attachments/assets/6b93cc82-caa4-4446-969b-efe4fe62f357

---

# 📘 **README.md – API Inventory App (CodeIgniter 4 + JWT)**

## 📌 **Overview**

Project ini adalah REST API berbasis **CodeIgniter 4** dengan sistem autentikasi **JWT**. API ini digunakan oleh aplikasi Flutter untuk melakukan proses:

* Registrasi dan Login pengguna
* Autentikasi JWT
* CRUD data Item (barang)
* Penyimpanan data dengan MySQL

---

# 🚀 **Teknologi yang Digunakan**

| Komponen    | Teknologi                         |
| ----------- | --------------------------------- |
| Backend     | CodeIgniter 4                     |
| Autentikasi | JSON Web Token (firebase/php-jwt) |
| Database    | MySQL                             |
| Format Data | JSON                              |
| Client      | Flutter                           |

---

# 📡 **Spesifikasi API**

## 🔐 **Auth API**

### **1. Register**

**POST** `/register`

**Body (JSON):**

```json
{
  "nama": "User",
  "email": "user@mail.com",
  "password": "123456",
  "password_confirmation": "123456"
}
```

**Response (201):**

```json
{
  "success": true,
  "message": "Registration success",
  "data": {
    "user": {...},
    "token": "jwt-token"
  }
}
```

---

### **2. Login**

**POST** `/login`

**Body (JSON):**

```json
{
  "email": "user@mail.com",
  "password": "123456"
}
```

**Response (200):**

```json
{
  "success": true,
  "message": "Login success",
  "data": {
    "user": {...},
    "token": "jwt-token"
  }
}
```

---

### **3. Logout**

**POST** `/logout` (Optional, hanya client-side)

Tidak menghapus token dari server, hanya menghapus dari aplikasi Flutter.

---

---

# 📦 **Item API**

### **1. Get All Items**

**GET** `/items`
Header:

```
Authorization: Bearer {token}
```

Response:

```json
{
  "success": true,
  "data": [...]
}
```

---

### **2. Create Item**

**POST** `/items`
Header:

```
Authorization: Bearer {token}
```

**Body:**

```json
{
  "nama": "Beras Pandan",
  "harga": 54000,
  "jumlah": 20,
  "tanggal_masuk": "2025-01-10",
  "tanggal_kedaluwarsa": "2025-06-10"
}
```

---

### **3. Update Item**

**PUT** `/items/{id}`
Body sama seperti create.

---

### **4. Delete Item**

**DELETE** `/items/{id}`

---

---

# 📂 **Penjelasan Kode**

## 🔐 **AuthController.php**

### **▶ register()**

* Validasi input pengguna
* Hash password
* Simpan user ke database
* Generate JWT token
* Return data user + token

**Kode inti:**

```php
$token = JWT::encode(['uid' => $userId], $key, 'HS256');
```

### **▶ login()**

* Ambil user berdasarkan email
* Verifikasi password
* Buat JWT token baru
* Return user + token

### **▶ Struktur Response**

Semua response memiliki struktur:

```php
[
  'success' => true/false,
  'message' => '...',
  'data' => [...]
]
```

---

# 📦 **ItemController.php**

### **▶ index()**

Mengambil semua item dari database dan melakukan casting:

```php
$item['id'] = (int) $item['id'];
$item['harga'] = (int) $item['harga'];
$item['jumlah'] = (int) $item['jumlah'];
```

Tujuan: Menghindari error Flutter (string → int).

---

### **▶ create()**

* Mengambil data JSON request
* Insert ke database
* Ambil kembali data item yang baru dibuat
* Cast integer
* Return response JSON

---

### **▶ update($id)**

* Update data berdasarkan ID
* Fetch item yang sudah diperbarui
* Cast integer
* Return response

---

### **▶ delete($id)**

* Menghapus item berdasarkan ID
* Return pesan sukses

---

---

# 🗄 **Model: UserModel & ItemModel**

### **UserModel**

Mengatur tabel `users`:

```php
protected $allowedFields = ['nama', 'email', 'password'];
```

### **ItemModel**

Mengatur tabel `items` dan field yang bisa diisi.

---

# 📱 **Integrasi Flutter**

Flutter:

* Menyimpan token JWT di local storage
* Mengirim token pada setiap request
* Parsing JSON ke model User / Item
* Menangani error network & authentication

---

# 🏁 **Kesimpulan**

API ini menyediakan sistem lengkap:
✔ Registrasi & Login menggunakan JWT
✔ CRUD Inventory
✔ Validasi input
✔ Respon JSON standar
✔ Aman dan mudah diintegrasikan dengan Flutter
