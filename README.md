# Endpoints
### User
<details>
<summary> Get One User</summary>


Request:

```http
GET /api/v0/users/:id
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{
  "data": {
    "id": "25",
    "type": "user",
    "attributes": {
      "name": "Ruby Gem",
      "location": "9705 Fishers District Dr, Fishers, IN 46037",
      "email": "jesusa@spinka.test",
      "search_radius": 25,
      "password": null
    }
  }
}
```
</details>

<details>
<summary>Create User</summary>

Request:

```http
POST /api/v0/users
Content-Type: application/json
Accept: application/json
```

Body:

```json
{
  "user": {
	"name":"Jack Sweeney",
	"location":"3405 Legend Dr., Los Angeles, CA 90034",
	"email":"test@email.com",
	"search_radius":25,
	"password":"unreadable_hash"
  }
}
```

Response: `status: 200`

```json
{
  "data": {
    "id":"4",
    "type":"user",
    "attributes": {
      "name":"Jack Sweeney",
      "location":"3405 Legend Dr., Los Angeles, CA 90034",
      "email":"test@email.com",
      "search_radius":25,
      "password": null
    }
  }
}
```
</details>

<details>
<summary> Update User </summary>
Request:

```http
PATCH /api/v0/users/:id
Content-Type: application/json
Accept: application/json
```

Body:

```json
{
  "user": {
	"name":"New Name",
	"location":"223 S Amazon Dr., Indianapolis, IN, 46259",
	"email":"test@email.com",
	"search_radius":20,
	"password":"unreadable_hash"
  }
}
```

Response: `status: 200`

```json
{
  "data": {
    "id":"4",
    "type":"user",
    "attributes": {
      "name":"Jack Sweeney",
      "location":"3405 Legend Dr., Los Angeles, CA 90034",
      "email":"test@email.com",
      "search_radius":25,
      "password": null
    }
  }
}
```
</details>

<details>
<summary> Delete User </summary>
Request:

```http
DELETE /api/v0/users/:id
Content-Type: application/json
Accept: application/json
```

Response: `status: 204`
</details>

<details>
<summary> Get User's (Liked) Tattoos </summar>
Request:

```http
GET /api/v0/users/:user_id/tattoos
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{
  "data": [
    {
      "id": "11",
      "type": "tattoos",
      "attributes": {
        "image_url": "https://gist.github.com/assets/149989113/379ece3d-6f4e-40d6-b7c4-47920d62ddfa",
        "price": 315,
        "time_estimate": 85,
        "artist_id": 0
      }
    },
    {
      "id": "12",
      "type": "tattoos",
      "attributes": {
        "image_url": "https://gist.github.com/assets/149989113/66a957cb-a6ef-4967-b049-dc6694022cf2",
        "price": 350,
        "time_estimate": 60,
        "artist_id": 5
      }
    },
    {
      "id": "13",
      "type": "tattoos",
      "attributes": {
        "image_url": "https://gist.github.com/assets/149989113/ad31388d-2480-49c3-b270-f4adcf6b7f9d",
        "price": 280,
        "time_estimate": 12,
        "artist_id": 8
      }
    },
    {
      "id": "14",
      "type": "tattoos",
      "attributes": {
        "image_url": "https://gist.github.com/assets/149989113/176b3ee5-22d9-4561-818b-e80c0fd36307",
        "price": 335,
        "time_estimate": 80,
        "artist_id": 8
      }
    },
    {
      "id": "15",
      "type": "tattoos",
      "attributes": {
        "image_url": "https://gist.github.com/assets/149989113/51cbb0a7-7d92-4835-b180-5ed250d2e815",
        "price": 245,
        "time_estimate": 75,
        "artist_id": 8
      }
    }
  ]
}
```
#### Create User Tattoo
Request:

```http
POST /api/v0/user_tattoos
Content-Type: application/json
Accept: application/json
```

Body:

```json
{
  "user_tattoo": {
    "user_id":7,
    "tattoo_id":1,
     "type": "like"
  }
}
(where 7 and 1 are valid user and tattoo IDs)
(change type to "dislike" to create UserTattoo with a "disliked" status)
```

Response: `status: 200`

```json
{
"message": "Tattoo successfully added to User"
}
```

#### Delete User Tattoo
Request:

```http
DELETE /api/v0/user_tattoos
Content-Type: application/json
Accept: application/json
```

Body:

```json
{
  "user_tattoo": {
    "user_id":7,
    "tattoo_id":1
  }
}
(where 7 and 1 are valid user and tattoo IDs)
```

Response: `status: 204`

#### Get User's Identities
Request:

```http
GET /api/v0/users/:user_id/identities
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{
  "data": [
    {
      "id": "5",
      "type": "identity",
      "attributes": {
        "identity_label": "Female"
      }
    },
    {
      "id": "6",
      "type": "identity",
      "attributes": {
        "identity_label": "Asian"
      }
    }
  ]
}
```

#### Create User Identity
Request:

```http
POST /api/v0/user_identities
Content-Type: application/json
Accept: application/json
```

Body:

```json
{
  "user_identity": {
    "user_id":25,
    "identity_id":2
  }
}
(where 25 and 2 are valid user and identity IDs)
```

Response: `status: 200`

```json
{
"message": "Identity successfully added to User"
}
```
#### Delete User Identity
Request:

```http
DELETE /api/v0/user_identities
? /api/v0/artists/:artist_id/identities/:id -> no body
Content-Type: application/json
Accept: application/json
```

Body:

```json
{
  "user_identity": {
    "user_id":25,
    "identity_id":2
  }
}
(where 25 and 2 are valid user and identity IDs)
```

Response: `status: 204`

### Artists
#### Get All
Request:

```http
GET /api/v0/artists
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{"data": [
  {
    "id":"5",
    "type":"artist",
    "attributes": {
      "name":"Ronnie Medhurst",
      "email":"aisha@bergnaum-hirthe.example",
      "password":null,
      "location":"Suite 431 840 Marnie Estates, North Stephnie, WA 82782-8921"
    }
  },
  {
    "id":"6",
    "type":"artist",
    "attributes": {
      "name":"Malissa Schaefer",
      "email":"mel@morissette-tillman.example",
      "password":null,
      "location":"511 Collier Summit, Mairaport, DE 39107"
    }
  },
  {
    "id":"7",
    "type":"artist",
    "attributes": {
      "name":"Jake Quitzon",
      "email":"bok@kunde-vandervort.test",
      "password":null,
      "location":"521 Merrill Union, Treutelview, UT 72253"
    }
  },
  {
    "id":"8",
    "type":"artist",
    "attributes": {
      "name":"Abdul Moen III",
      "email":"carolee.crist@mcclure-brakus.test",
      "password":null,
      "location":"9173 Lashawn Court, East Haywoodshire, NC 51851"
    }
  },
  {
    "id":"9",
    "type":"artist",
    "attributes": {
      "name":"Mrs. Maynard West",
      "email":"cheryle.hagenes@hegmann.example",
      "password":null,
      "location":"Apt. 264 13947 Kiehn Plain, Trevorbury, OH 95278"
      }
    }
  ]
}
```

#### Get One
Request:

```http
GET /api/v0/artists/:id
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{
  "data": {
    "id": "5",
    "type": "artist",
    "attributes": {
      "name": "Tattoo artists",
      "email": "tatart@gmail.com",
      "password": null,
      "location": "1400 U Street NW, Washington, DC 20009"
    }
  }
}
```
#### Create Artist
Request:

```http
POST /api/v0/artists
Content-Type: application/json
Accept: application/json
```

Body:

```json
{
  "artist": {
    "name":"Ted Lasso",
    "location":"Pacific Ocean",
    "email":"soccer@gmail.com",
    "password":"TotalFutbol"
  }
}
```

Response: `status: 200`

```json
{
  "data": {
    "id":"15",
    "type":"artist",
    "attributes": {
      "name":"Ted Lasso",
      "email":"soccer@gmail.com",
      "password": null,
      "location":"Pacific Ocean"
    }
  }
}
```
#### Update Artist
Request:

```http
PATCH /api/v0/artists/:id
Content-Type: application/json
Accept: application/json
```

Body:

```json
{
  "artist": {
    "name":"Ted Lasso",
    "location":"Pacific Ocean",
    "email":"soccer@gmail.com",
    "password":"TotalFutbol"
  }
}
```

Response: `status: 200`

```json
{
  "data": {
    "id":"15",
    "type":"artist",
    "attributes": {
      "name":"Ted Lasso",
      "email":"soccer@gmail.com",
      "password": null,
      "location":"Pacific Ocean"
    }
  }
}
```

#### Delete Artist
Request:

```http
DELETE /api/v0/artists/:id
Content-Type: application/json
Accept: application/json
```

Response: `status: 204`
#### Get Artist Identities
Request:

```http
GET /api/v0/artists/:artist_id/identities
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{
  "data": [
    {
      "id": "5",
      "type": "identity",
      "attributes": {
        "identity_label": "Female"
      }
    },
    {
      "id": "6",
      "type": "identity",
      "attributes": {
        "identity_label": "Asian"
      }
    }
  ]
}
```

#### Create Artist Identity
Request:

```http
POST /api/v0/artist_identities
Content-Type: application/json
Accept: application/json
```

Body:

```json
{
  "artist_identity": {
    "artist_id":2,
    "identity_id":8
  }
}
(where 2 and 8 are valid artist and identity IDs)
```

Response: `status: 200`

#### Delete Artist Identity
Request:

```http
DELETE /api/v0/artist_identities
? /api/v0/artists/:artist_id/identities/:id -> no body
Content-Type: application/json
Accept: application/json
```

Body:

```json
{
  "artist_identity": {
    "artist_id":2,
    "identity_id":8
  }
}
(where 2 and 8 are valid artist and identity IDs)
```

Response: `status: 204`

#### Get Artist's Tattoos
Request:

```http
GET /api/v0/artists/:artist_id/tattoos
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{
  "data": [
    {
      "id": "210",
      "type": "tattoos",
      "attributes": {
        "image_url": "/random/url/path",
        "price": 306,
        "time_estimate": 160,
        "artist_id": 288,
        "artist": {
          "id": 288,
          "name": "Margrett Dare I",
          "email": "tonie@ritchie.test",
          "password_digest": "$2a$04$ohsFGpdinZ/B.7KPnfIGZuoocVdvIKm/R6ABtxCR00IX8VkrMmf8u",
          "location": "90797 Hammes Lodge, Port Junefort, VT 43513",
          "created_at": "2024-04-18T21:38:06.092Z",
          "updated_at": "2024-04-18T21:38:06.092Z",
          "scheduling_link": "http://conn.example/sherilyn.witting"
        }
      }
    },
    {
      "id": "211",
      "type": "tattoos",
      "attributes": {
        "image_url": "/random/url/path",
        "price": 303,
        "time_estimate": 72,
        "artist_id": 288,
        "artist": {
          "id": 288,
          "name": "Margrett Dare I",
          "email": "tonie@ritchie.test",
          "password_digest": "$2a$04$ohsFGpdinZ/B.7KPnfIGZuoocVdvIKm/R6ABtxCR00IX8VkrMmf8u",
          "location": "90797 Hammes Lodge, Port Junefort, VT 43513",
          "created_at": "2024-04-18T21:38:06.092Z",
          "updated_at": "2024-04-18T21:38:06.092Z",
          "scheduling_link": "http://conn.example/sherilyn.witting"
        }
      }
    },
    {
      "id": "212",
      "type": "tattoos",
      "attributes": {
        "image_url": "/random/url/path",
        "price": 172,
        "time_estimate": 86,
        "artist_id": 288,
        "artist": {
          "id": 288,
          "name": "Margrett Dare I",
          "email": "tonie@ritchie.test",
          "password_digest": "$2a$04$ohsFGpdinZ/B.7KPnfIGZuoocVdvIKm/R6ABtxCR00IX8VkrMmf8u",
          "location": "90797 Hammes Lodge, Port Junefort, VT 43513",
          "created_at": "2024-04-18T21:38:06.092Z",
          "updated_at": "2024-04-18T21:38:06.092Z",
          "scheduling_link": "http://conn.example/sherilyn.witting"
        }
      }
    }
  ]
}
```
### Tattoos
#### Get One
Request:

```http
GET /api/v0/tattoos/:id
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{
  "data": {
    "id": "4",
    "type": "tattoos",
    "attributes": {
      "image_url": "image/path", 
      "price": 250, 
      "time_estimate": 90, 
      "artist_id": 19
    }
  }
}
```

#### Create Tattoo
Request:

```http
POST /api/v0/tattoos
Content-Type: application/json
Accept: application/json
```

Body:

```json
{
  "price": 90, 
  "time_estimate": 120, 
  "artist_id": 18, 
  "image_url": "test/url/path"
}
```

Response: `status: 200`

```json
{
  "data": {
    "id": "3", 
    "type": "tattoos", 
    "attributes": {
      "image_url": "test/url/path", 
      "price": 90, 
      "time_estimate": 120, 
      "artist_id": 18
    }
  }
}
```

#### Update Tattoo
Request:

```http
PATCH /api/v0/tattoos/:id
Content-Type: application/json
Accept: application/json
```

Body:

```json
{
  "tattoo": {
    "price": 90, 
    "time_estimate": 120, 
    "artist_id": 18, 
    "image_url": "test/url/path"
  }
}
```

Response: `status: 200`

```json
{
  "data": {
    "id": "4",
    "type": "tattoos",
    "attributes": {
      "image_url": "image/path", 
      "price": 250, 
      "time_estimate": 90, 
      "artist_id": 19
    }
  }
}
```

#### Delete Tattoo
Request:

```http
DELETE /api/v0/tattoos/:id
Content-Type: application/json
Accept: application/json
```

Response: `status: 204`
#### Get All Matching User's Pref $\rightarrow$ Check after done making
Request:

```http
GET /api/v0/tattoos?user=(:user_id)
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{ 
  "data": [
    {
      "id": "1",
      "type": "tattoos",
      "attributes": {
        "image_url": "https://gist.github.com/assets/149989113/fee274f7-0fa9-4606-855b-9c286fcb1661",
        "price": 300,
        "time_estimate": 90,
        "artist_id": 5
      }
    },
    {
      "id": "2",
      "type": "tattoos",
      "attributes": {
        "image_url": "https://gist.github.com/assets/149989113/e94a0c62-8f4d-4e00-8de5-9c77cafc10c0",
        "price": 300,
        "time_estimate": 90,
        "artist_id": 5
      }
    },
    {
      "id": "3",
      "type": "tattoos",
      "attributes": {
        "image_url": "https://gist.github.com/assets/149989113/c0fc1e3c-2af3-4bba-9f1b-739e3ee02c8a",
        "price": 250,
        "time_estimate": 80,
        "artist_id": 5
      }
    },
    {
      "id": "4",
      "type": "tattoos",
      "attributes": {
        "image_url": "https://gist.github.com/assets/149989113/faa4aa31-75bf-4f8e-b7a8-77ad75856549",
        "price": 275,
        "time_estimate": 80,
        "artist_id": 7
      }
    },
    {
      "id": "5",
      "type": "tattoos",
      "attributes": {
        "image_url": "https://gist.github.com/assets/149989113/331f0aef-ab8e-4360-b9b7-fc991b12976f",
        "price": 325,
        "time_estimate": 85,
        "artist_id": 8
      }
    }
  ]
}
```

### Identities

#### Get All

Request:

```http
GET /api/v0/identities
Content-Type: application/json
Accept: application/json
```

Response: `status: 200`

```json
{
  "data": [
    {
      "id": "1",
      "type": "identity",
      "attributes": {
        "identity_label": "LGBTQ+"
      }
    },
    {
      "id": "2",
      "type": "identity",
      "attributes": {
        "identity_label": "Black"
      }
    },
    {
      "id": "3",
      "type": "identity",
      "attributes": {
        "identity_label": "Native American"
      }
    },
    {
      "id": "4",
      "type": "identity",
      "attributes": {
        "identity_label": "Latino"
      }
    },
    {
      "id": "5",
      "type": "identity",
      "attributes": {
        "identity_label": "Female"
      }
    },
    {
      "id": "6",
      "type": "identity",
      "attributes": {
        "identity_label": "Asian"
      }
    },
    {
      "id": "7",
      "type": "identity",
      "attributes": {
        "identity_label": "None"
      }
    }
  ]
}
```
### Sign In
Request:

```http
POST /api/v0/sign_in
Content-Type: application/json
Accept: application/json
```

Body:

```json
{
  "sign_in": {
    "email": "jesusa@spinka.test",
    "password": "123Password",
    "type": "Sign In as User"
  }
}

(where user email & password are correct)
Note: To sign in as an Artist, alter type to "Sign In as Artist"
```

Response: `status: 200`

```json
{
  "data": {
    "id": 20, 
    "type": "artist"
  }
}
```

### Sign Out
Request:

```http
DELETE api/v0/sign_out
Content-Type: application/json
Accept: application/json
```

Body:
For an artist
```json
{
  "artist_id": 21
}

(where 21 is a valid artist id)
```

For a user
```json
{
  "user_id": 5
}

(where 5 is a valid user id)
```

Response: `status: 204`

