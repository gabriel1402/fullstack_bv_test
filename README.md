# BeenVerified - Full Stack Technical Challenge

## Description
URL Shortener web application. Shorten your URLs and see the top 100 most visited sites. Developed with Angular + Rails.

## Requirements
- Ruby (2.5.3)
- Rails (5.2.2)
- PostgreSQL (11.1)
- Redis (5.0.3)
- Sidekiq

- NodeJS (8.15.0)
- NPM (6.4.1)
- Angular (7.2.0)

## Installation
Clone the project in your workspace with ```git clone https://github.com/gabriel1402/fullstack_bv_test.git```

To install the API, enter the api folder inside the cloned `fullstack_bv_test` directory and run ```bundle install``` to set the project dependencies.

Before setting the database, you must cconfigure the environment variables. Copy and rename the `application.example.yml` to `application.yml`, and set the variables according to your environment, i.e. database credentials, your host's URL, etc... 

Next, run the following commands to set up the database:

```
rails db:create
rails db:migrate
```

With that, the cconfiguration is set. Before testing the API, make sure you have a Redis server running. Execute Sidekiq to listen for the jobs with the following command:

```
bundle exec sidekiq &
```

Then, you can just run `rails s` to set up the server, and your application will be running at http://localhost:3000.

----

For the web client, enter the client folder in the `fullstack_bv_test` directory and run ```npm install```.

Make sure to configure the environment variables. For this, open the file `./src/environments/environment.ts` to edit the development variables. There, set the `api_url` variable to the URL of the API we got in the steps above.

With everything ready, start the client with ```ng serve```, and it should start running at http://localhost:4200/.

## URL Shortening Algorithm

Following suggestion from blogs like [How to design a tiny URL or URL shortener?](https://www.geeksforgeeks.org/how-to-design-a-tiny-url-or-url-shortener/) and [this blog from Matthias Kerstner](https://www.kerstner.at/2012/07/shortening-strings-using-base-62-encoding/), it was decided to follow the approach of the base62 encoding.

This approach consist of converting an id (integer in this case), to base 62, which lets the application to generate URLs that contains characters in the ranges of a-z, A-Z and 0-9. The full URL will be stored in the database, but instead of storing the shortened URL along with it, the ID is encoded to base62 and returned as the short URL. This allows the system to decode the short URL an return an integer, which points to the unique ID of the full URL stored on database and redirects to it.

The base62 encoding algorithm can be found in gems such as [jtzemp/base62](https://github.com/jtzemp/base62).

## API Reference

### URL Shortener
Recieves an URL string and returns a shorter URL.

* **URL**

  /url

* **Method:**

  `POST`
  
*  **URL Params**

   **Required:**
 
   `url=[alphanumeric]`

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** 
    ```
    {
      "status":200,
      "data":"http://shortened.url"
    }
    ```

* **Error Response:**

  * **Code:** 400 <br />
    **Content:** 
    ```
    {
      "status":400,
      "errors":{
        "attribute":[
          "error message"
        ]
      }
    }
    ```

### Top 100
Returns the list of the top 100 most visited websites from the URL generated from the application.
* **URL**

  /top

* **Method:**

  `GET`

* **Success Response:**

  * **Code:** 200 <br />
    **Content:** 
    ```
    {
    "status": "success",
    "data": [
        {
            "id": 1,
            "url": "https://full.url",
            "created_at": "2019-01-23T00:00:00.643Z",
            "updated_at": "2019-01-23T00:00:00.643Z",
            "title": "Website Title",
            "visits": 231,
            "short_url": "http://short.url/id"
        },
        {
            "id": 2,
            "url": "https://full.url2",
            "created_at": "2019-01-23T04:25:04.696Z",
            "updated_at": "2019-01-23T00:00:00.643Z",
            "title": "Website Title 2",
            "visits": 123,
            "short_url": "http://short.url/id2"
        },
        ...
    ]
}
    ```

### Redirect
Redirects the shortened URL to the full URL.
* **URL**

  /{id}

* **Method:**

  `GET`

* **Success Response:**

  * Redirect to the stored URL

* **Error Response:**
  
  * **Code:** 400 <br />
    **Content:** 
    ```
    {
      "status": 404,
      "errors": "Not Found"
    }
    ```
