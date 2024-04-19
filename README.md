# TattDaddy

## Table of Contents
- [Getting Started](#getting-started)
- [Project Description](#project-description)
- [Learning Goals for Project](#learning-goals-for-project)
- [Setup](#setup)
- [Contributors](#contributors)
- [FE Repo](https://github.com/JackCSweeney/tattdaddy-fe)

## Getting Started
### Versions
- Ruby: 3.2.2
- Rails: 7.1.3

## Project Description

Tatt Daddy is an app designed to connect users with tattoo artists in order to get pre-designed, flash tattoos in a quick and easy fashion. Users will scroll through different available designs that licensed tattoo artists will upload to the application, select tattoos they would like to get, and get connected with the artist to schedule an appointment, chat about small details of the work, and finalize payment. The goal is to allow tattoo collectors to easily add to their collection and provide artists an opportunity to fill more of their schedule with quick and efficient appointments.

This app was built with a team of 5 developers as the consultancy project for MOD 3 2311, from Turing School of Software and Design.

<details>
  <summary>Learning Goals for Project</summary>
- To learn how to build something custom from an idea, going from conceptualization to a final product.
- Better time estimates and reasonable goals for project tasks.
- Experience to build a collaborative Full stack app.
- Creating a unique app and managing tasks as a team.
- Get experience to create and build a project from scratch.
</details>

<details>
  <summary>Setup</summary>
  1. Fork and/or Clone this Repo from GitHub.
  2. In your terminal use `$ git clone <ssh or https path>`.
  3. Change into the cloned directory using `$ cd example`.
  4. Install the gem packages using `$ bundle install`.
  5. Database Migrations can be set up by running: 
  ``` bash 
  $ rails rake db:{drop,create,migrate,seed}
  ```
</details>

<details>
  <summary>Testing</summary>

  Test using the terminal utilizing RSpec:

  ```bash
  $ bundle exec rspec spec/<follow directory path to test specific files>
  ```

  or test the whole suite with `$ bundle exec rspec`
</details>

<details>
  <summary>Database Schema</summary>

  ```

  ActiveRecord::Schema[7.1].define(version: 2024_04_18_194439) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "artist_identities", force: :cascade do |t|
    t.bigint "artist_id", null: false
    t.bigint "identity_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_artist_identities_on_artist_id"
    t.index ["identity_id"], name: "index_artist_identities_on_identity_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "scheduling_link"
  end

  create_table "identities", force: :cascade do |t|
    t.string "identity_label"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tattoos", force: :cascade do |t|
    t.string "image_url"
    t.integer "price"
    t.integer "time_estimate"
    t.bigint "artist_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_tattoos_on_artist_id"
  end

  create_table "user_identities", force: :cascade do |t|
    t.bigint "identity_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["identity_id"], name: "index_user_identities_on_identity_id"
    t.index ["user_id"], name: "index_user_identities_on_user_id"
  end

  create_table "user_tattoos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "tattoo_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.index ["tattoo_id"], name: "index_user_tattoos_on_tattoo_id"
    t.index ["user_id"], name: "index_user_tattoos_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "location"
    t.integer "search_radius"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.string "token"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "artist_identities", "artists"
  add_foreign_key "artist_identities", "identities"
  add_foreign_key "tattoos", "artists"
  add_foreign_key "user_identities", "identities"
  add_foreign_key "user_identities", "users"
  add_foreign_key "user_tattoos", "tattoos"
  add_foreign_key "user_tattoos", "users"
  end
```
</details>

## External APIs/Services
#### AWS S3 API
  - In our application, we leverage AWS S3 to manage user-uploaded image files. By storing these files in an S3 bucket, we effectively reduce the size of our database, containing only essential data. This approach is particularly beneficial given the potentially large sizes of image files. Storing them in an external database like S3 enables us to store secure URLs in our database queries, rather than cumbersome image data. This optimization enhances the efficiency of our database operations while ensuring the security and accessibility of our image assets. 

  - [AWS S3 documentation](https://aws.amazon.com/s3/)

#### GitHub OAuth
- We integrated GitHub OAuth into our application to streamline the user authentication process and enhance security. By utilizing GitHub OAuth, we leverage the robust authentication infrastructure provided by GitHub, a trusted platform widely used by developers. This approach not only simplifies the login experience for our users by allowing them to use their GitHub credentials but also ensures a higher level of security by delegating the authentication process to GitHub's servers. Additionally, GitHub OAuth provides us with access to user profile information, enabling us to personalize the user experience and tailor our application's functionality based on their GitHub identity and permissions. Overall, integrating GitHub OAuth enhances both the usability and security of our application, contributing to a more seamless and trustworthy user experience.

- [GitHub Documentation](https://docs.github.com/en/apps/oauth-apps/building-oauth-apps/authorizing-oauth-apps#web-application-flow)

#### Google Matrix Distance API
- We integrated the Google Distance Matrix API into our application to enhance the user experience by providing accurate and real-time distance and travel time information between users' locations and tattoo artists' studios. By leveraging this API, Tatt Daddy can offer users valuable insights into the proximity of available tattoo artists, enabling them to make informed decisions when selecting artists for their tattoo appointments.

- The Google Distance Matrix API allows us to calculate the distance and travel time between multiple origins and destinations, considering various transportation modes such as driving, walking, or public transit. This functionality empowers users to efficiently plan their tattoo appointments based on factors such as travel distance and estimated time of arrival, ensuring a seamless and convenient booking experience.

- Additionally, by integrating the Google Distance Matrix API, we can optimize the routing and scheduling of appointments, minimizing travel time for both users and tattoo artists. This optimization not only enhances the overall efficiency of the booking process but also contributes to a more satisfying and streamlined user experience.

- [Distance Matrix Documentation](https://developers.google.com/maps/documentation/distance-matrix/overview)

## Contributors
#### Jack Sweeney   	 
- [Github](https://github.com/JackCSweeney) [LinkedIn](https://www.linkedin.com/in/jack-sweeney-024043274/)

#### Laura R Vega V 	 
- [Github](https://github.com/laurarvegav) [LinkedIn](https://www.linkedin.com/in/laurarvegav/) 

#### Joey Reyes 		 
- [Github](https://github.com/JRIV-10) [LinkedIn](https://www.linkedin.com/in/josereyes10/)

#### Jessica Kohl 		 
- [Github](https://github.com/kohljd) [LinkedIn](https://www.linkedin.com/in/jessica-kohl-545785113/)

#### Faisal Nazari 		 
- [Github](https://github.com/mfaisalnazari) [LinkedIn](https://www.linkedin.com/in/mfaisalnazari/) 

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
	"password": null
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
<summary> Get User's (Liked) Tattoos </summary>
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
        "artist_id": 0,
        "artist": {
            "id": 5,
            "name": "Ivy Running",
            "email": "ivy@running.com",
            "password_digest": null,
            "location": "45 Marathon Rd, Los Angeles, CA 90032",
            "created_at": "2024-04-19T00:23:41.504Z",
            "updated_at": "2024-04-19T00:23:41.504Z",
            "scheduling_link": "www.google.com"
        }
      }
    },
    {
      "id": "12",
      "type": "tattoos",
      "attributes": {
        "image_url": "https://gist.github.com/assets/149989113/66a957cb-a6ef-4967-b049-dc6694022cf2",
        "price": 350,
        "time_estimate": 60,
        "artist_id": 5,
        "artist": {
            "id": 5,
            "name": "Ivy Running",
            "email": "ivy@running.com",
            "password_digest": null,
            "location": "45 Marathon Rd, Los Angeles, CA 90032",
            "created_at": "2024-04-19T00:23:41.504Z",
            "updated_at": "2024-04-19T00:23:41.504Z",
            "scheduling_link": "www.google.com"
        }
      }
    },
    {
      "id": "13",
      "type": "tattoos",
      "attributes": {
        "image_url": "https://gist.github.com/assets/149989113/ad31388d-2480-49c3-b270-f4adcf6b7f9d",
        "price": 280,
        "time_estimate": 12,
        "artist_id": 8,
        "artist": {
            "id": 5,
            "name": "Ivy Running",
            "email": "ivy@running.com",
            "password_digest": null,
            "location": "45 Marathon Rd, Los Angeles, CA 90032",
            "created_at": "2024-04-19T00:23:41.504Z",
            "updated_at": "2024-04-19T00:23:41.504Z",
            "scheduling_link": "www.google.com"
        }
      }
    },
    {
      "id": "14",
      "type": "tattoos",
      "attributes": {
        "image_url": "https://gist.github.com/assets/149989113/176b3ee5-22d9-4561-818b-e80c0fd36307",
        "price": 335,
        "time_estimate": 80,
        "artist_id": 8,
        "artist": {
            "id": 5,
            "name": "Ivy Running",
            "email": "ivy@running.com",
            "password_digest": null,
            "location": "45 Marathon Rd, Los Angeles, CA 90032",
            "created_at": "2024-04-19T00:23:41.504Z",
            "updated_at": "2024-04-19T00:23:41.504Z",
            "scheduling_link": "www.google.com"
        }
      }
    },
    {
      "id": "15",
      "type": "tattoos",
      "attributes": {
        "image_url": "https://gist.github.com/assets/149989113/51cbb0a7-7d92-4835-b180-5ed250d2e815",
        "price": 245,
        "time_estimate": 75,
        "artist_id": 8,
        "artist": {
            "id": 5,
            "name": "Ivy Running",
            "email": "ivy@running.com",
            "password_digest": null,
            "location": "45 Marathon Rd, Los Angeles, CA 90032",
            "created_at": "2024-04-19T00:23:41.504Z",
            "updated_at": "2024-04-19T00:23:41.504Z",
            "scheduling_link": "www.google.com"
        }
      }
    }
  ]
}
```
</details>
<details>
  <summary>User Dislike a Tattoo</summary>
  Request:

  ```http
  DELETE /api/v0/user_tattoos
  Content-Type: application/json
  Accept: application/json
  ```

  ```json 
  {
    "message": "Successfully deleted a Tattoo"
    }
  ```
</details>
<details>
<summary>Create User Tattoo</summary> 
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
</details>

<details>
<summary> Delete User Tattoo</summary> 
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
</details>

<details>
<summary> Get User's Identities </summary>
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
</details>

<details>
<summary> Create User Identity</summary>
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
</details>

<details>
<summary> Delete User Identity</summary>
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
</details>

### Artists
<details>
<summary> Get All</summary>
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
</details>

<details>
<summary> Get One Artist</summary>
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
</details>

<details>
<summary> Create Artist</summary>
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
</details>

<details>
<summary> Update Artist</summary>
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
</details>

<details>
<summary>Delete Artist</summary>
Request:

```http
DELETE /api/v0/artists/:id
Content-Type: application/json
Accept: application/json
```

Response: `status: 204`
</details>

<details>
<summary>Get Artist Identities</summary>
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
</details>

<details>
<summary>Create Artist Identity</summary>
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
</details>

<details>
<summary>Delete Artist Identity</summary>
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
</details>

<details>
<summary>Get Artist's Tattoos</summary>
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
          "password_digest": null,
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
          "password_digest": null,
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
          "password_digest": null,
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
</details>

### Tattoos
<details>
<summary> Get One</summary>
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
</details>

<details>
<summary>Create Tattoo</summary>
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
</details>

<details>
<summary> Update Tattoo</summary>
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
</details>

<details>
<summary>Delete Tattoo</summary>
Request:

```http
DELETE /api/v0/tattoos/:id
Content-Type: application/json
Accept: application/json
```

Response: `status: 204`

</details>

<details>
<summary> Get All Matching User's Pref </summary>
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
</details>

### Identities

<details>
<summary> Get All</summary>

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
</details>

<details>
<summary> Sign In</summary>
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
</details>

<details>
<summary> Sign Out</summary
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
</details>
